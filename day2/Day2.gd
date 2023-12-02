extends Node


func _ready():
	var file := FileAccess.open("res://day2/day2.txt", FileAccess.READ)
	var lines := []
	while file.get_position() < file.get_length():
		var line := file.get_line()
		if line != "":
			lines.append(line)
	file.close()

	var valid_games := 0
	var sum_of_powers := 0

	for line: String in lines:
		var split := line.split(":")
		var game := split[0]
		var plays := split[1].split(";")

		var cube_count = {
			"blue": 0,
			"red": 0,
			"green": 0,
		}

		for play_set in plays:
			var reveals := play_set.split(",")
			for reveal in reveals:
				reveal = reveal.strip_edges()
				var reveal_split := reveal.split(" ")
				var cube_number := int(reveal_split[0].strip_edges())
				var cube_color := reveal_split[1].strip_edges()
				match cube_color:
					"blue":
						cube_count["blue"] = max(cube_count["blue"], cube_number)
					"red":
						cube_count["red"] = max(cube_count["red"], cube_number)
					"green":
						cube_count["green"] = max(cube_count["green"], cube_number)
					var error:
						assert(false, "Invalid value %s" % error)

		var game_id := int(game.split(" ")[1])
		if cube_count["red"] <= 12 and  cube_count["green"] <= 13 and  cube_count["blue"] <= 14:
			valid_games += game_id

		var power = cube_count["red"] * cube_count["green"] * cube_count["blue"]
		sum_of_powers += power

	print("Result of day 2-1: %d" % valid_games)
	print("Result of day 2-2: %d" % sum_of_powers)
