"""Verify LOCAL DEVELOPMENT ONLY fixtures. Never connects to a remote database.

Requires the Horus local Podman containers. Auth responses are captured and
discarded; access/refresh tokens and response bodies are never printed.
"""
import json
import subprocess

ACCOUNTS = [
    ("rector", "Rector", "rector"),
    ("dean", "Dean", "dean"),
    ("hod", "Hod", "department_head"),
    ("professor", "Professor", "professor"),
    ("ta", "Assistant", "teaching_assistant"),
    ("registrar", "Registrar", "registrar_officer"),
    ("advisor", "Advisor", "academic_advisor"),
    ("student", "Student", "regular_student"),
    ("freshman", "Freshman", "freshman"),
    ("guest", "Guest", "guest"),
    ("student2", "Student2", "regular_student"),
    ("student3", "Student3", "regular_student"),
]


def main():
    query = """
      SELECT u.email, string_agg(rd.code, ',' ORDER BY rd.code)
      FROM auth.users u JOIN public.user_roles ur ON ur.user_id=u.id
      JOIN public.role_definitions rd ON rd.id=ur.role_id AND rd.is_active
      WHERE u.id BETWEEN 'd0000000-0000-4000-8000-000000000001'::uuid
        AND 'd0000000-0000-4000-8000-000000000012'::uuid
        AND ur.granted_at <= now() AND (ur.expires_at IS NULL OR ur.expires_at > now())
      GROUP BY u.email ORDER BY u.email;
    """
    result = subprocess.run([
        "podman", "exec", "supabase_db_Horus", "psql", "-U", "postgres",
        "-d", "postgres", "-At", "-F", "|", "-v", "ON_ERROR_STOP=1", "-c", query,
    ], capture_output=True, text=True, check=True, timeout=30)
    roles = dict(line.split("|", 1) for line in result.stdout.splitlines())
    failures = 0
    print("LOCAL DEVELOPMENT ONLY")
    print(f"{'ACCOUNT':36} {'CANONICAL ROLE':22} AUTH / ROLE")
    for prefix, suffix, expected_role in ACCOUNTS:
        email = prefix + ".dev@horus.edu.eg"
        request = json.dumps({"email": email, "password": "HorusDev!2026-" + suffix})
        response = subprocess.run([
            "podman", "exec", "supabase_auth_Horus", "wget", "-qO-",
            "--header=Content-Type: application/json", "--post-data=" + request,
            "http://127.0.0.1:9999/token?grant_type=password",
        ], capture_output=True, text=True, timeout=30)
        try:
            auth = json.loads(response.stdout)
            login_ok = bool(auth.get("access_token")) and auth.get("user", {}).get("email") == email
        except (ValueError, TypeError):
            login_ok = False
        role_ok = roles.get(email) == expected_role
        failures += not (login_ok and role_ok)
        print(f"{email:36} {roles.get(email, 'MISSING'):22} "
              f"{'PASS' if login_ok else 'FAIL'} / {'PASS' if role_ok else 'FAIL'}")
    return int(bool(failures))


if __name__ == "__main__":
    raise SystemExit(main())
