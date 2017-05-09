//Sleep defines for continuous looping procs
// T = ticks
// S = seconds
// e.g. WAIT_2T will sleep the proc for 2 ticks, whereas WAIT_2S will sleep the proc for 2 seconds
#ifdef DEBUG
//automatic defines with a little extra overhead (should be minimal) for debug builds
var/tick_one			= world.tick_lag
var/tick_two			= world.tick_lag * 2
var/tick_one_s			= world.tick_lag * world.fps
var/tick_two_s			= tick_one_s * 2

#define WAIT_1T		sleep(tick_one)
#define WAIT_2T		sleep(tick_two)
#define WAIT_1S		sleep(tick_one_s)
#define WAIT_2S		sleep(tick_two_s)

#else
//manual defines for release builds - these will need to be updated if you change your world.fps
//1 tick = 0.00625 * fps
#define WAIT_1T		sleep(0.375)
#define WAIT_2T		sleep(0.75)
#define WAIT_1S		sleep(22.5)
#define WAIT_2S		sleep(45)

#endif