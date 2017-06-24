// constants
#define PI       3.14159265359
#define INFINITY 1.#INF

//rounding
#define Clamp(x, y, z) 	(x <= y ? y : (x >= z ? z : x))
#define floor(x)		round(x)
#define ceil(x)			(-round(-(x)))
#define sign(x)			(x ? x / abs(x) : 0) //returns 0 if 0, else either 1 or -1

//trigonometry
#define tan(x)				(sin(x) / cos(x))
#define cot(x)				(1 / tan(x))
#define arctan(a)			(arccos(1 / sqrt(1 + (a)**2))
#define arccot(a)			(arcsin(1 / sqrt(1 + (a)**2))
#define hypotenuse(x, y)	sqrt((x ** 2) + (y ** 2))
