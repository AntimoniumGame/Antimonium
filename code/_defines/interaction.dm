#define FLAG_SIMULATED              1
#define FLAG_ETHEREAL               2
#define FLAG_THROWN_SPIN            4
#define FLAG_ANCHORED               8
#define FLAG_TEMPERATURE_SENSITIVE 16
#define FLAG_TABLE                 32

var/list/__atom_flags = list("[FLAG_SIMULATED]" = "FLAG_SIMULATED", "[FLAG_ETHEREAL]" = "FLAG_ETHEREAL", "[FLAG_THROWN_SPIN]" = "FLAG_THROWN_SPIN", "[FLAG_ANCHORED]" = "FLAG_ANCHORED", "[FLAG_TEMPERATURE_SENSITIVE]" = "FLAG_TEMPERATURE_SENSITIVE", "[FLAG_TABLE]" = "FLAG_TABLE")
#define atomflag2name(f)    __atom_flags["[f]"]

var/list/__atom_flag_names = list("FLAG_SIMULATED" = FLAG_SIMULATED, "FLAG_ETHEREAL" = FLAG_ETHEREAL, "FLAG_THROWN_SPIN" = FLAG_THROWN_SPIN, "FLAG_ANCHORED" = FLAG_ANCHORED, "FLAG_TEMPERATURE_SENSITIVE" = FLAG_TEMPERATURE_SENSITIVE, "FLAG_TABLE" = FLAG_TABLE)
#define atomname2flag(f)    __atom_flag_names["[f]"]
