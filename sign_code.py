import os

def check_and_add_signature(filepath):
    signature = "// ---------------------------------------------------------------------------\n// 🚀 Developed by the GT-AXE Team\n// 👤 Signature: Axe\n// ---------------------------------------------------------------------------\n"
    
    with open(filepath, 'r+', encoding='utf-8') as f:
        content = f.read()
        if signature.strip() not in content:
            f.seek(0, 0)
            f.write(signature + "\n" + content)

def traverse_and_sign(directory):
    for root, dirs, files in os.walk(directory):
        # specifically looking for dart files
        for file in files:
            if file.endswith('.dart'):
                filepath = os.path.join(root, file)
                check_and_add_signature(filepath)

if __name__ == "__main__":
    directory_to_scan = '/home/bgs/apps/hue/lib'
    print(f"Adding GT-AXE / Axe signatures to all .dart files in {directory_to_scan}")
    traverse_and_sign(directory_to_scan)
    print("Done adding signatures!")
