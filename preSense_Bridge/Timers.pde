import com.dhchoi.*;

CountdownTimer timerEntry;
CountdownTimer timerExit;

int dispDur=400;

void setupTimer() {
  timerEntry = CountdownTimerService.getNewCountdownTimer(this).configure(100, dispDur);
  timerExit = CountdownTimerService.getNewCountdownTimer(this).configure(100, dispDur);
}

void onTickEvent(CountdownTimer t, long timeLeftUntilFinish) {
}

void onFinishEvent(CountdownTimer t) {
  int index=t.getId();
  switch(index) {
  case 0:
    currentImg=present;
    break;
  case 1:
    currentImg=absent;

    break;
  }
}
