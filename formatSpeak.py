import re
import sys

def reformat_transcript(input_file):
    with open(input_file, 'r') as file:
        lines = file.readlines()

    formatted_lines = []
    for line in lines:
        match = re.match(r'^([A-Z]+): (.+)$', line)
        if match:
            name = match.group(1).capitalize()
            content = match.group(2)
            formatted_lines.append(f'-speak {name} \n{content}')
        else:
            formatted_lines.append(line)

    with open(input_file, 'w') as file:
        file.writelines(formatted_lines)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py input_transcript.txt")
        sys.exit(1)

    input_file_path = sys.argv[1]

    reformat_transcript(input_file_path)
    print(f"Transcript reformatted and saved to {input_file_path}")
