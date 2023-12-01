extends Node


func _ready():
	var file = FileAccess.open("res://day1.txt", FileAccess.READ)
	var content = file.get_as_text()
	file.close()

	first(content)
	second(content)


func first(content: String):
	var split := content.split("\n")
	var number_regex := RegEx.new()
	number_regex.compile("\\d")
	
	var final_result := 0
	
	for line in split:
		if line == "":
			continue
		var result := number_regex.search(line)
		var first_number := result.get_string()
		
		result = number_regex.search(reverse_line(line))
		var last_number := result.get_string()
		
		var number := int(first_number + last_number)
		final_result += number
		
	print("Result of day 1-1: %d" % final_result)
	

func second(content: String):
	var split := content.split("\n")
	var number_regex := RegEx.new()
	# hacky solution get reverse numbers for identify in reverse line
	number_regex.compile("(one|two|three|four|five|six|seven|eight|nine|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin|\\d)")
	
	var lookup_number = {
		"one": "1",
		"two": "2",
		"three": "3",
		"four": "4",
		"five": "5",
		"six": "6",
		"seven": "7",
		"eight": "8",
		"nine": "9",
		# hacky solution
		"eno": "1",
		"owt": "2",
		"eerht": "3",
		"ruof": "4",
		"evif": "5",
		"xis": "6",
		"neves": "7",
		"thgie": "8",
		"enin": "9",
	}
	
	var final_result := 0
	
	for line in split:
		if line == "":
			continue
		var result := number_regex.search(line)
		var result_string := result.get_string()
		var first_number: String = lookup_number.get(result_string, result_string)
		
		result = number_regex.search(reverse_line(line))
		result_string = result.get_string()
		var last_number: String = lookup_number.get(result_string, result_string)
		
		var number := int(first_number + last_number)
		final_result += number
	
	print("Result of day 1-2: %d" % final_result)


func reverse_line(line: String) -> String:
	var reversed := PackedStringArray()
	for c in line:
		reversed.append(c)
	reversed.reverse()
	return "".join(reversed)
