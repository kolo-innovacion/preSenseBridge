import com.dhchoi.*;

CountdownTimer timerEntry;
CountdownTimer timerExit;

int dispDur=400;
void timerSetup() {
  timerEntry = CountdownTimerService.getNewCountdownTimer(this).configure(100, dispDur);
  timerExit = CountdownTimerService.getNewCountdownTimer(this).configure(100, dispDur);
}

void onTickEvent(CountdownTimer t, long timeLeftUntilFinish) {
  //timerCallbackInfo = "[tick] - timeLeft: " + timeLeftUntilFinish + "ms";
}

void onFinishEvent(CountdownTimer t) {
  //timerCallbackInfo = "[finished]";
  int index=t.getId();
  //println(index);
  switch(index) {
  case 0:
    //println("OoO");
    //entry case
    currentImg=present;
    break;
  case 1:
    //println("LlLl");
    currentImg=absent;
    break;
  }
}
