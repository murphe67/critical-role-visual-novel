import sys

def check_lines(file_name):
    try:
        with open(file_name, 'r') as file:
            lines = file.readlines()

        for i in range(1, len(lines)):
            current_line = lines[i].strip()
            previous_line = lines[i - 1].strip()

            if current_line.startswith('-end'):
                print("Check terminated at line {}: '{}' starts with '-end'.".format(i + 1, current_line))
                break

            if not current_line.startswith('-') and \
              previous_line.startswith('-') and \
              not previous_line.startswith(('-speak', '-continue', '-narrate')):
                print(f"Line {i + 1}: {current_line}")

        print("Check completed.")

    except FileNotFoundError:
        print(f"Error: File '{file_name}' not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <file_name>")
    else:
        file_name = sys.argv[1]
        check_lines(file_name)
