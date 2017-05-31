/client/New()
	. = ..()
	clients += src
	DoClientWelcome(src)

/client/Del()
	. = ..()
	clients -= src

/proc/DoClientWelcome(var/client/player)

	for(var/line in File2List("data/motd.txt"))
		to_chat(player, line)

	// todo: news, messages, alerts, etc.

	to_chat(player, "<table>")
	if(config["rules_url"])
		to_chat(player, "<tr><td>Server rules:</td><td><b><a href='[config["rules_url"]]'>here</a></b></td></tr>")
	if(config["wiki_url"])
		to_chat(player, "<tr><td>Game Wiki:</td><td><b><a href='[config["wiki_url"]]'>here</a></b></td></tr>")
	if(config["discord_url"])
		to_chat(player, "<tr><td>Discord:</td><td><b><a href='[config["discord_url"]]'>here</a></b></td></tr>")
	to_chat(player, "</table>")
	to_chat(player, "Type <b>/help</b> for a list of chat commands!")

	if(game_state)
		game_state.OnLogin(player)
