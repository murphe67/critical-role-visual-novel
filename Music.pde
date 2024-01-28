class Music {
  Minim minim;
  AudioPlayer track;

  String newTrack;

  boolean fadeOut;
  boolean fadeIn;
  boolean stop;

  float gain;

  float gainDrop;

  void PlayMusic(String musicName) {
    newTrack = musicName;
    if (track != null) {
      fadeOut = true;
      gainDrop = 0.3;
      gain = 0;
      stop = false;
    } else {
      track = minim.loadFile("music/" + newTrack + ".mp3");
      track.loop();
      fadeIn = true;
      gain = -80;
    }
  }

  void Pause() {
    fadeOut = true;
    gainDrop = 0.5;
    gain = 0;
    stop = true;
  }

  void Unpause() {
    fadeIn = true;
    gain = -80;
  }

  void Run() {
    if (track != null) {
      track.setGain(-80);
      //track.setGain(gain);

      if (fadeOut) {
        gain -= gainDrop;
        if (gain < -80) {
          fadeOut = false;
          if (!stop) {
            fadeIn = true;

            track = minim.loadFile("music/" + newTrack + ".mp3");
            track.loop();
            track.setGain(gain);
          }
        }
      } else if (fadeIn) {
        gain += 3;
        if (gain > 0) {
          gain = 0;
          fadeIn = false;
          track.setGain(gain);
        }
      }
    }
  }
}
