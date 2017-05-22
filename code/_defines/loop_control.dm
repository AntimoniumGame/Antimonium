//Sleep defines for continuous looping procs
// T = ticks
// S = seconds
// e.g. WAIT_2T will sleep the proc for 2 ticks, whereas WAIT_2S will sleep the proc for 2 seconds
#ifdef DEBUG
//automatic defines with a little extra overhead (should be minimal) for debug builds
//please do not use these global vars anywhere as they will only work in a debug build
var/tick_one        = world.tick_lag
var/tick_two        = world.tick_lag * 2

#define WAIT_1T     sleep(tick_one)
#define WAIT_2T     sleep(tick_two)

//wait for n ticks
#define WAIT_NT(n)  sleep(tick_one * n)

#else
//manual defines for release builds - these will need to be updated if you change your world.fps
//1 tick = 10 / fps
#define WAIT_1T     sleep(0.25)
#define WAIT_2T     sleep(0.5)

//wait for n ticks
#define WAIT_NT(n)  sleep(0.25 * n)

#endif

//wait for seconds
#define WAIT_1S     sleep(10)
#define WAIT_2S     sleep(20)
#define WAIT_NS(n)  sleep(10 * n)

//push this to the end of the queue
#define QUEUE_END   sleep(0)
