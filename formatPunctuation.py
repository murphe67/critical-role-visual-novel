import sys

def reformat_transcript(file_name):
    try:
        with open(file_name, 'r') as file:
            content = file.read()

        # Add a newline after every '.', '!', or '?', and remove whitespace after them
        new_content = ''
        skip_whitespace = False
        for char in content:
            if skip_whitespace and char.isspace():
                continue
            new_content += char
            if char in ['.', '!', '?']:
                new_content += '\n'
                skip_whitespace = True
            else:
                skip_whitespace = False

        with open(file_name, 'w') as file:
            file.write(new_content)

        print(f"File '{file_name}' has been rewritten with newlines and removed whitespace after punctuation.")

    except FileNotFoundError:
        print(f"Error: File '{file_name}' not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <file_name>")
    else:
        file_name = sys.argv[1]
        reformat_transcript(file_name)
