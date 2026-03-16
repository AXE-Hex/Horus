import re

with open('lib/core/router/app_router.dart', 'r') as f:
    content = f.read()

# Remove triple/quadruple newlines introduced by the previous script
content = re.sub(r'\n\s*\n\s*\n+', '\n\n', content)

with open('lib/core/router/app_router.dart', 'w') as f:
    f.write(content)
