import sys
import re

def process_text(input_text):
    lines = input_text.split('\n')
    processed_lines = []

    for line in lines:
        if line.startswith("-speak"):
            processed_lines.append(line)
            currentSpeaker = line
        else:
            if '”' in line:
                line = line.replace("”", "\"")
            if "“" in line:
                line = line.replace("“", "\"")
            if '"' in line:
                parts = [part for part in re.split('(")', line) if part]
                print(parts)
                if len(parts)==3:
                    processed_lines.append(parts[1])
                else:
                    if parts[0] == "\"":
                        parts = parts[1:-1]
                    print(parts)
                    if parts[-1] == "\"":
                        parts = parts[0:-1]
                    for part in parts:
                        if part == '"':
                            processed_lines.append(currentSpeaker)
                        else:
                            processed_lines.append(part.lstrip())
            else:
                processed_lines.append(line)
    return '\n'.join(processed_lines)

def reformat_transcript(file_path):
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
    reformat_transcript(input_file_path)
