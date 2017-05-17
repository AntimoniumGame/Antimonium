//Sleep defines for continuous looping procs
// T = ticks
// S = seconds
// e.g. WAIT_2T will sleep the proc for 2 ticks, whereas WAIT_2S will sleep the proc for 2 seconds
#ifdef DEBUG
//automatic defines with a little extra overhead (should be minimal) for debug builds
//please do not use these global vars anywhere as they will only work in a debug build
var/tick_one        = world.tick_lag
var/tick_two        = world.tick_lag * 2
var/tick_one_s      = world.tick_lag * world.fps
var/tick_two_s      = tick_one_s * 2

#define WAIT_1T     sleep(tick_one)
#define WAIT_2T     sleep(tick_two)
#define WAIT_1S     sleep(tick_one_s)
#define WAIT_2S     sleep(tick_two_s)

//wait for n ticks/seconds
#define wait_nt(n)  sleep(tick_one * n)
#define wait_ns(n)  sleep(tick_one_s * n)

#else
//manual defines for release builds - these will need to be updated if you change your world.fps
//1 tick = 0.00625 * fps
#define WAIT_1T     sleep(0.375)
#define WAIT_2T     sleep(0.75)
#define WAIT_1S     sleep(22.5)
#define WAIT_2S     sleep(45)

//wait for n ticks/seconds
#define wait_nt(n)  sleep(0.375 * n)
#define wait_ns(n)  sleep(22.5 * n)

#endif

//push this to the end of the queue
#define QUEUE_END   sleep(0)

#define TICK_USAGE_TO_MS(percent_of_tick_used) (percent_of_tick_used * world.tick_lag)
