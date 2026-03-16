import os
import re
import json

LIB_DIR = "lib"
EN_JSON_PATH = "assets/translations/en.i18n.json"
AR_JSON_PATH = "assets/translations/ar.i18n.json"

def snake_case(s):
    s = re.sub(r'[^\w\s]', '', s)
    s = re.sub(r'\s+', '_', s.strip()).lower()
    return s

def load_json(path):
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)

def save_json(path, data):
    with open(path, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

en_data = load_json(EN_JSON_PATH)
ar_data = load_json(AR_JSON_PATH)

if 'extracted' not in en_data: en_data['extracted'] = {}
if 'extracted' not in ar_data: ar_data['extracted'] = {}

# Match isArabic ? '...' : '...'
# handles both single and double quotes, and optional spaces
pattern = re.compile(r"isArabic\s*\?\s*(['\"])(.*?)\1\s*:\s*(['\"])(.*?)\3")

extracted_count = 0

for root, _, files in os.walk(LIB_DIR):
    for filename in files:
        if filename.endswith(".dart"):
            filepath = os.path.join(root, filename)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            matches = pattern.findall(content)
            if not matches: continue

            new_content = content
            needs_i18n_import = False

            for match in matches:
                text_ar = match[1]
                text_en = match[3]

                key = snake_case(text_en)
                if not key: key = "extracted_" + str(extracted_count)
                
                original_key = key
                counter = 1
                while key in en_data['extracted'] and en_data['extracted'][key] != text_en:
                    key = f"{original_key}_{counter}"
                    counter += 1

                en_data['extracted'][key] = text_en
                ar_data['extracted'][key] = text_ar
                extracted_count += 1

                # Construct regex to replace the exact match
                exact_match = f"isArabic\\s*\\?\\s*{match[0]}{re.escape(text_ar)}{match[0]}\\s*:\\s*{match[2]}{re.escape(text_en)}{match[2]}"
                new_str = f"t.extracted.{key}"
                
                new_content = re.sub(exact_match, new_str, new_content)
                needs_i18n_import = True

            if needs_i18n_import and "package:hue/core/i18n/strings.g.dart" not in new_content:
                import_stmt = "import 'package:hue/core/i18n/strings.g.dart';\n"
                last_import_idx = new_content.rfind('import ')
                if last_import_idx != -1:
                    end_of_line = new_content.find('\n', last_import_idx)
                    new_content = new_content[:end_of_line+1] + import_stmt + new_content[end_of_line+1:]
                else:
                    new_content = import_stmt + new_content

            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(new_content)

save_json(EN_JSON_PATH, en_data)
save_json(AR_JSON_PATH, ar_data)

print(f"Extracted {extracted_count} strings.")
