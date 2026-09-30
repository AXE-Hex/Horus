#!/usr/bin/env python3
"""Render documentation from a local catalog.sql export; never query remotely."""
import json
import re
import sys
from pathlib import Path

catalog = json.loads(Path(sys.argv[1]).read_text())
relations = sorted(catalog['relations'], key=lambda r: r['name'])
functions = sorted((f for f in catalog['functions'] if not f['extension']), key=lambda f: f['signature'])
tables = [r for r in relations if r['kind'] in ('r', 'p')]
logical = [r for r in tables if not r['partition']]
views = [r for r in relations if r['kind'] in ('v', 'm')]
counts = dict(Tables=len(logical), Partitions=len(tables)-len(logical), Views=len(views),
              Functions=len(functions), Triggers=len(catalog['triggers']), Enums=len(catalog['enums']),
              Policies=sum(len(r['policies'] or []) for r in tables)+len(catalog['storage_policies'] or []),
              Indexes=sum(len(r['indexes'] or []) for r in tables), Storage_buckets=len(catalog['buckets']))

def inline(value):
    return str(value).replace('|', '\\|').replace('\n', ' ')

def grants(r, role):
    return ', '.join(sorted(g['privilege_type'] for g in r['grants'] or [] if g['grantee']==role)) or '—'

purposes = {
    'profiles': 'Authentication-linked user profile and account state.',
    'role_definitions': 'Canonical role catalog for authorization.',
    'user_roles': 'Scoped, time-bounded canonical role assignments.',
    'permissions': 'Canonical permission catalog.',
    'role_permissions': 'Role-to-permission grants.',
    'posts': 'University feed posts with explicit academic visibility scope.',
    'post_comments': 'Threaded comments on feed posts.',
    'post_likes': 'Unique user reactions to feed posts.',
    'conversations': 'Private conversation roots and creator ownership.',
    'conversation_members': 'Conversation membership and invitation state.',
    'messages': 'Conversation-scoped private messages.',
    'notifications': 'Per-user application notifications and read state.',
    'grades': 'Student course grade records.',
    'attendance': 'Student attendance records for academic offerings.',
    'payments': 'Server-authoritative payment state and provider references.',
    'invoices': 'Student financial obligations.',
}

out = ['# Horus database inventory', '',
       'Generated from the LOCAL PostgreSQL 17 catalog after the September 2026 hardening reset.',
       '`scripts/database/catalog.sql` → JSON → `scripts/database/render_inventory.py`.',
       'Migrations remain authoritative. This snapshot is evidence, not a second schema source.', '',
       '| Object | Count |', '| --- | ---: |']
out += [f'| {k.replace("_", " ")} | {v} |' for k,v in counts.items()]
out += ['', 'Tables exclude partition children; indexes include physical child indexes. Policies include',
        'public application relations and Storage. Functions exclude extension-owned functions.',
        'Triggers include application triggers on auth.users and inherited partition triggers.', '',
        '## Table contracts', '',
        'Each table below lists all columns and relationships, not just client-used fields. Sensitive',
        'classification is conservative: private academic, financial, messaging, operational and',
        'identity rows require authorization even where a particular column is not named below.',
        'Read/write permission predicates are the exact policies in the accompanying RLS matrix.',
        'Column grants can further restrict a table grant. Unlisted operations remain denied.', '']
for r in tables:
    out += [f'### `{r["name"]}`', '']
    if r['partition']:
        out += ['Physical partition; inherits its parent contract. Direct client grants remain denied.', '']
    else:
        cols = {x['name'] for x in r['columns']}
        scope = ', '.join(sorted(cols & {'user_id','student_id','author_id','sender_id','uploader_id','college_id','department_id','course_id','conversation_id','request_id','professor_id','profile_id'})) or 'reference/system scope'
        purpose = r['comment'] or purposes.get(r['name'], r['name'].replace('_', ' ').capitalize()+' relation; bounded context and exact fields below.')
        sensitive = sorted(x for x in cols if re.search(r'email|phone|national|student_id|advisor|warning|banned|tags|ip_address|user_agent|key_hash|cipher|host_url|passcode|gateway_response|old_data|new_data|device|metadata|answer|score|amount|gpa|grade|content',x))
        out += [f'Purpose: {purpose}', '', f'Owning scope: `{scope}`. Sensitive fields: '+(', '.join(f'`{x}`' for x in sensitive) or 'row classification and authorization still apply')+'.', '']
    out += [f'RLS enabled: **{r["rls"]}**; forced: **{r["force"]}**.', '',
            f'Table grants — anon: {grants(r,"anon")}; authenticated: {grants(r,"authenticated")}; service_role: {grants(r,"service_role")}.', '',
            '| Column | Type | Nullable | Default |', '| --- | --- | --- | --- |']
    out += [f'| `{x["name"]}` | {inline(x["type"])} | {x["nullable"]} | {inline(x["default"] or "—")} |' for x in r['columns']]
    out += ['', 'Constraints:', '']
    out += [f'- `{x["name"]}`: {inline(x["definition"])}; validated={x["validated"]}.' for x in r['constraints'] or []]
    out += ['', 'Indexes:', '']
    out += [f'- `{inline(x)}`' for x in r['indexes'] or []] or ['- None.']
    out += ['']
out += ['## Views', '']
for r in views:
    out += [f'### `{r["name"]}`', '', r['comment'] or 'Application view.', '', '```sql',r['view'],'```','']
out += ['## Functions and RPCs', '',
        'All application definers have pinned search_path and no PUBLIC/anon EXECUTE. Helpers',
        'are callable by authenticated because policies need them, and independently bind the caller.', '',
        '| Signature | Returns | Definer | Volatility | Configuration | ACL |', '| --- | --- | --- | --- | --- | --- |']
out += [f'| `{inline(f["signature"])}` | {inline(f["result"])} | {f["definer"]} | {f["volatility"]} | {inline(f["config"])} | {inline(f["acl"])} |' for f in functions]
out += ['', '### Function definitions', '']
for f in functions:
    out += [f'#### `{f["signature"]}`', '', '```sql', f['definition'], '```', '']
out += ['## Triggers', '', '| Relation | Trigger | Definition |', '| --- | --- | --- |']
out += [f'| `{t["table"]}` | `{t["name"]}` | {inline(t["definition"])} |' for t in sorted(catalog['triggers'],key=lambda x:(x['table'],x['name']))]
out += ['', '## Enums', '', '| Enum | Values |', '| --- | --- |']
out += [f'| `{e["typname"]}` | {inline(", ".join(e["labels"]))} |' for e in sorted(catalog['enums'],key=lambda x:x['typname'])]
out += ['', '## Storage buckets', '', '| Bucket | Public | Size bytes | MIME allowlist |', '| --- | --- | ---: | --- |']
out += [f'| `{b["id"]}` | {b["public"]} | {b["file_size_limit"]} | {inline(b["allowed_mime_types"])} |' for b in sorted(catalog['buckets'],key=lambda x:x['id'])]
out += ['', '## Realtime publication', '', '| Publication | Relation |', '| --- | --- |']
out += [f'| `{p["pubname"]}` | `{p["schemaname"]}.{p["tablename"]}` |' for p in sorted(catalog['publication'],key=lambda x:x['tablename'])]
out += ['', '## Direct client column grants', '', '| Relation | Role | Column | Privilege |', '| --- | --- | --- | --- |']
out += [f'| `{g["table_name"]}` | {g["grantee"]} | `{g["column_name"]}` | {g["privilege_type"]} |' for g in sorted(catalog['column_grants'] or [],key=lambda x:(x['table_name'],x['grantee'],x['column_name'],x['privilege_type']))]
Path('docs/DATABASE_INVENTORY.md').write_text('\n'.join(out)+'\n')
# Preserve existing human scope explanation; append exact catalog truth.
p=Path('docs/RLS_MATRIX.md');existing=p.read_text().split('\n## Catalog-verified effective policies')[0]
matrix=['', '## Catalog-verified effective policies', '',
        'This complete snapshot includes every application table and physical partition.',
        'Restrictive account policies intersect permissive scope policies. No policy grants',
        'table or column privileges. An absent grant remains deny-by-default.', '',
        '| Relation | RLS | Forced | Anon grants | Authenticated table grants | Policies |',
        '| --- | --- | --- | --- | --- | --- |']
for r in tables:
    matrix.append(f'| `{r["name"]}` | {r["rls"]} | {r["force"]} | {grants(r,"anon")} | {grants(r,"authenticated")} | {len(r["policies"] or [])} |')
matrix += ['', '### Exact predicates by operation', '']
for r in tables:
    matrix += [f'#### `{r["name"]}`', '', '| Policy | Command | Mode | USING | WITH CHECK |', '| --- | --- | --- | --- | --- |']
    matrix += [f'| `{p["policyname"]}` | {p["cmd"]} | {p["permissive"]} | {inline(p["qual"] or "—")} | {inline(p["with_check"] or "—")} |' for p in r['policies'] or []]
    if not r['policies']:matrix += ['| No policy | — | Denied | — | — |']
    matrix += ['']
matrix += ['### Storage policies', '', '| Policy | Command | Mode | USING | WITH CHECK |', '| --- | --- | --- | --- | --- |']
matrix += [f'| `{p["policyname"]}` | {p["cmd"]} | {p["permissive"]} | {inline(p["qual"] or "—")} | {inline(p["with_check"] or "—")} |' for p in catalog['storage_policies'] or []]
Path('docs/RLS_MATRIX.md').write_text(existing+'\n'.join(matrix)+'\n')
Path('/tmp/horus-audit-counts.json').write_text(json.dumps(counts,indent=2))
print(json.dumps(counts))
