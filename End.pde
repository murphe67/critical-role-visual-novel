class End {
  float alpha;
  float prevFrameTime;


  void StartEnd() {
    endFlag = true;
    alpha = 0;
    prevFrameTime = millis();
  }

  void Run() {
    if (globalSkipText) {
      exit();
    }
    fill(0, alpha);
    rectMode(CORNER);
    rect(0, 0, width, height);

    alpha += ((millis() - prevFrameTime) * 60 / 1000) * 0.2;
    prevFrameTime = millis();

    if (alpha > 100) {
      exit();
    }
  }
}
