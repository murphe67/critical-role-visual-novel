class Input {
  boolean readyToProgress;

  String lines[];
  int index;

  Input() {
    lines = loadStrings("episodes/" + folderToRead + "/main.txt");
    TrimLines();
    index = 0;

    readyToProgress = false;
  }

  void Begin() {
    parser.Parse();
  }

  String PopLine() {
    String line = null;
    if (index < lines.length) {
      line = lines[index];
      index++;
    }
    return line;
  }

  String PeakLine() {
    if(index == lines.length){
      return null;
    }
    return lines[index];
  }

  String PeakLine(int index) {
    if(index == lines.length){
      return null;
    }
    return lines[index];
  }


  void TrimLines() {
    for (int i = 0; i < lines.length; i++) {
      lines[i] = trim(lines[i]);
    }
  }

  void HandleClick() {
    if (readyToProgress) {
      readyToProgress = false;
      parser.Parse();
    }
  }
}
