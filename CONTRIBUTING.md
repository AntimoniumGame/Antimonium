- In general, an effort should be made to adhere to the same style standards as the BYOND documentation. Where something is not specifically covered by this document, assume that the BYOND style is correct.

- Instance/type proc names should be written in PascalCase/Upper CamelCase. ie.

```
/obj/foo/proc/Foo()
	return "bar"
```

- Global procs and preprocessor macros should be written in snake_case or lowercase ie.

```
#define get_turf(A) get_step(A,0)

/proc/foo()
	return "bar"
```

- Constants and preprocessor #defines should be written in UPPERCASE ie.

```
#define FOO "foo"

var/const/FOO = "foo"
```

- Variable names should be written in snake_case or lowercase. 

- Absolute pathing should be used for procs/verbs, and relative pathing should be used for variables. ex.

```
/obj/foo
	var/example = "bar"

/obj/foo/proc/Foo()
	return example
```

- For maintainability, readability, reliability and performance overhead reasons, same-type overrides should be avoided wherever possible. ie.

```
/obj/proc/Foo()
   return "bar"

/obj/Foo()
   . = "foo" + ..()   
```

- Unless an object is going to be directly added to the map, or the object implements specific behavior not covered by other objects, object variation should not be hardcoded. eg. there are not specific object subtypes for heads, groins and chests, but there are 'stance' and 'grasp' subtypes, which are the basis for arms and legs at runtime.

- Under no circumstances should the internal object variables `step_x` or `step_y` be set, either in the code or on the map. Usually if these are set accidentally it is by using the 'nudge' function while mapping. This is to avoid 'chess mode', in which BYOND does not perform full tile movement interpolation, resulting in atoms jumping instantly between turfs.

- If the internal object variables `bound_x`, `bound_y`, `bound_height` or `bound_width`  are used or set, they must be ensured to define an area that is both exactly aligned to the map turfs, and is a multiple of the world icon size (32 at time of writing). This is to avoid 'chess mode' described above.