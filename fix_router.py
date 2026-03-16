import re

with open('lib/core/router/app_router.dart', 'r') as f:
    content = f.read()

pattern = r"(\s*)final\s+(\w+)\s*=\s*state\.extra\s*as\s+([A-Za-z0-9_<>,\s]+?);"

def replacer(match):
    indent = match.group(1)
    var_name = match.group(2)
    type_name = match.group(3)
    
    # If the type already has a question mark or it has a fallback, skip it
    if type_name.strip().endswith('?'):
        return match.group(0)
    
    return f"{indent}final {var_name} = state.extra as {type_name}?;\n{indent}if ({var_name} == null) {{\n{indent}  return const Scaffold(\n{indent}    body: Center(child: Text('Navigation error: missing data')),\n{indent}  );\n{indent}}}"

new_content = re.sub(pattern, replacer, content)

with open('lib/core/router/app_router.dart', 'w') as f:
    f.write(new_content)
