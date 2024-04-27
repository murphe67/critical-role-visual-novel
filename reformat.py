import formatSpeak
import formatQuotes
import formatPunctuation
import sys

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py episodeNumber")
        sys.exit(1)

    input_file_path = f"episodes/CR_C1_E{sys.argv[1]}/transcript.txt"

    formatSpeak.reformat_transcript(input_file_path)
    formatQuotes.reformat_transcript(input_file_path)
    formatPunctuation.reformat_transcript(input_file_path)
    print(f"Transcript reformatted and saved to {input_file_path}")
