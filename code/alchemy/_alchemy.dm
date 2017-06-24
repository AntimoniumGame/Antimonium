/*
Traded:
	coal - fuel, steelmaking
	sulfur - gunpowder component
	gold coins

Mixed:
	aqua fortis -      strong acid     - 2 parts saltpetre, 1 part oil of vitriol
	auric hydroxide -  gating material - 1 part gold, 2 parts oil of vitriol
	fulminating gold - explosive       - 2 parts ammonia, 1 part auric hydroxide
	lunar caustic -    disinfectant    - 1 part silver, 2 parts aqua fortis
	blackpowder -      explosive       - 1 part saltpetre, 1 part charcoal/coal, 1 part brimstone

Distillery
	aqua vitae -       pure ethanol    - 2 parts alcohol
	sal volatile -     medicine base   - 2 parts bones or horns

Oven:
	saltpetre -        gating material - 1 part guano, 1 part coal
	oil of vitriol -   weak acid       - 1 part green vitriol, 1 part blue vitriol
	verdigris -        plant killer    - 1 part copper, 1 part charcoal
	aqua tofani -      strong poison   - 1 part galena

Kiln:
	charcoal -         fuel            - 3 parts wood

Crucible:
	silver -           basic material  - 1 part native silver ore
	copper -           basic material  - 1 part native copper ore
	gold -             basic material  - 1 part native gold ore
	pig iron -         gating material - 1 part hematite ore
	lead -             basic material  - 1 part galena
	antimonium         gating material - 1 part antimony sulfide, 1 part iron

Furnace:
	iron -             basic material  - 1 part pig iron
	steel -            basic material  - 3 parts pig iron
*/

/proc/AddReagent(var/obj/holder, var/supplied_reagent_material = /datum/material/water, var/supplied_amount = 1)
	if(!holder || !holder.IsReagentContainer() || !holder.HasRoomForReagents(supplied_amount))
		return FALSE
	holder.PutReagentInside(new /obj/item/stack/reagent(null, supplied_reagent_material, supplied_amount, holder))
	return TRUE
