import json
import re
import os

EN_JSON = 'assets/translations/en.i18n.json'
AR_JSON = 'assets/translations/ar.i18n.json'
LIB_DIR = 'lib'

def sanitize_param(p):
    # Remove ${ and }
    p = p.replace('${', '').replace('}', '').replace('$', '')
    # Replace . with _
    p = p.replace('.', '_')
    # Remove other non-alphanumeric chars
    p = re.sub(r'[^a-zA-Z0-9_]', '_', p)
    # Ensure it doesn't start with a number
    if p and p[0].isdigit():
        p = 'arg_' + p
    return p

def fix_json(path):
    if not os.path.exists(path): 
        print(f"File not found: {path}")
        return {}
    with open(path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    param_map = {} # key -> list of (original_expression, sanitized_param)

    def recursive_update(node, prefix=''):
        if isinstance(node, dict):
            for k, v in node.items():
                node[k] = recursive_update(v, f"{prefix}{k}.")
        elif isinstance(node, str):
            # Find all ${...} and $var
            matches = re.findall(r'(\$\{[^}]+\}|\$[a-zA-Z0-9_]+)', node)
            if matches:
                 key = prefix.rstrip('.')
                 if key not in param_map: param_map[key] = []
                 new_str = node
                 for m in matches:
                     sanitized = sanitize_param(m)
                     new_str = new_str.replace(m, f'{{{sanitized}}}')
                     param_map[key].append((m, sanitized))
                 return new_str
        return node

    data = recursive_update(data)
    
    with open(path, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    
    return param_map

print("Fixing JSON files...")
en_params = fix_json(EN_JSON)
ar_params = fix_json(AR_JSON)

# Combine params
all_params = {}
for k, v in en_params.items():
    all_params[k] = v
for k, v in ar_params.items():
    if k not in all_params:
        all_params[k] = v

print(f"Found {len(all_params)} keys with parameters.")

# Fix Dart files
print("Fixing Dart files...")
for root, _, files in os.walk(LIB_DIR):
    for filename in files:
        if filename.endswith(".dart"):
            filepath = os.path.join(root, filename)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            orig_content = content
            # Process in reverse length order of keys to avoid partial replacements
            sorted_keys = sorted(all_params.keys(), key=len, reverse=True)
            for key in sorted_keys:
                params = all_params[key]
                dart_key = f"t.{key}"
                if dart_key in content:
                    args = []
                    seen_sanitized = set()
                    for orig, sanitized in params:
                        if sanitized in seen_sanitized: continue
                        seen_sanitized.add(sanitized)
                        expr = orig.replace('${', '').replace('}', '').replace('$', '')
                        args.append(f"{sanitized}: {expr}")
                    
                    arg_str = ", ".join(args)
                    # Replace t.key with t.key(args) only if not already called with parens
                    pattern = re.compile(re.escape(dart_key) + r'(?!\()')
                    content = pattern.sub(f"{dart_key}({arg_str})", content)

            if content != orig_content:
                print(f"Updated {filepath}")
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)

print("Done.")
