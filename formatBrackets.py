import sys
import re

def process_text(input_text):
    lines = input_text.split('\n')
    processed_lines = []

    currentSpeaker = ""
    for line in lines:
        if line.startswith("-speak"):
            processed_lines.append(line)
            currentSpeaker = line
        else:
            if '(' in line:
                parts = [part.strip() for part in re.split('(\([^)]*\))', line) if part]
                justNarrated = False
                for part in parts:
                    if "(" in part:
                        processed_lines.append(f"-narrate")
                        processed_lines.append(part)
                        justNarrated = True
                    else:
                        if justNarrated:
                            justNarrated = False
                            processed_lines.append(currentSpeaker)
                        processed_lines.append(part)
            else:
                processed_lines.append(line)

    return '\n'.join(processed_lines)

def rewrite_file(file_path):
    with open(file_path, 'r') as file:
        content = file.read()

    processed_content = process_text(content)
    with open(file_path, 'w') as file:
        file.write(processed_content)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <input_file_path>")
        sys.exit(1)

    input_file_path = sys.argv[1]
    rewrite_file(input_file_path)