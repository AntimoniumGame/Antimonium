/proc/DoClientWelcome(var/client/player)

	for(var/line in File2List("data/motd.txt"))
		to_chat(player, "<span class='notice'>[line]</span>")

	// todo: news, messages, alerts, etc.

	to_chat(player, "<table>")
	if(config["rules_url"])
		to_chat(player, "<tr><td><span class='alert'>Server rules:</span></td><td><b><a href='[config["rules_url"]]'>here</a></b></td></tr>")
	if(config["wiki_url"])
		to_chat(player, "<tr><td><span class='alert'>Game Wiki:</span></td><td><b><a href='[config["wiki_url"]]'>here</a></b></td></tr>")
	if(config["discord_url"])
		to_chat(player, "<tr><td><span class='alert'>Discord:</span></td><td><b><a href='[config["discord_url"]]'>here</a></b></td></tr>")
	to_chat(player, "</table>")
	to_chat(player, "<span class='notice'>Type <span class='alert'><b>/help</b></span> for a list of chat commands!</span>")

	if(game_state)
		game_state.OnLogin(player)
