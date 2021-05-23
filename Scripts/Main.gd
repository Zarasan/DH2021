extends Control

var QRCode = preload("res://Scenes/QRCode.tscn")
var ID = preload("res://Scenes/IDCard.tscn")
var bribe = preload("res://Scenes/BribeSticker.tscn")

var lifes = 4
var hours = 8
var minutes = 00
var game_started = true
var round_type = ''
var round_timer = 0.1

func _physics_process(delta):
	if game_started:
		minutes += delta
		round_timer += delta
		if minutes > 60:
			minutes = 0
			hours+=1
		$"Round Info/HBoxContainer/Panel2/Panel/Timer".text = '%02d:%02d'%[hours, minutes]
		if hours > 19:
			end_game('time')

func start_round(type):
	Global.currentround += 1
	round_type = type
	match type:
		'VaccineCard':
			spawn_cards('VaccineCard')
		'VaccineCardWrongDate':
			spawn_cards('VaccineCardWrongDate')
		'VaccineCardWrongDateBribe':
			spawn_cards('VaccineCardWrongDateBribe')
		'VaccineCardRick':
			spawn_cards('VaccineCardRick')

func end_game(type):
	$"Panel".show()
	match type:
		'lifes':
			$"Panel/VBoxContainer/Label".visible = true
		'time':
			$"Panel/VBoxContainer/Label4".visible = true
	$"Panel/VBoxContainer/Label2".text = 'Allowed Inside: ' + str(Global.allowed)
	$"Panel/VBoxContainer/Label5".text = 'Missed Errors: '  + str(Global.misses)
	$"Panel/VBoxContainer/Label3".text = 'Denied Access: ' + str(Global.allowed)
	#$"Panel/VBoxContainer/Label6".text = 'Allowed Inside: ' + str(Global.allowed)
	pass


func finish_round():
	$Tween.interpolate_property(get_node('QRCode'),'rect_position', get_node('QRCode').rect_position, Vector2(-600,-600), 1,Tween.TRANS_EXPO)
	$Tween.interpolate_property(get_node('IDCard'),'rect_position', get_node('QRCode').rect_position, Vector2(-600,-600), 1,Tween.TRANS_EXPO)
	$Tween.start()
	yield(get_tree().create_timer(0.5), "timeout")
	get_node('QRCode').hide()
	get_node('QRCode').queue_free()
	get_node('IDCard').hide()
	get_node('IDCard').queue_free()
	yield(get_tree().create_timer(0.2), "timeout")
	if Global.misses != 4:
		start_round(Global.RoundOrder[Global.currentround % Global.RoundOrder.size()])
	pass


func _on_Accept_pressed():
	match round_type:
		'VaccineCard':
			Global.allowed += 1
			Global.points += 70 + 100/floor(round_timer)
		'VaccineCardWrongDate':
			print('VaccineCardWrongDate')
			Global.misses += 1
			if Global.misses == 4:
				end_game('lifes')
			$"Round Info/Panel/Panel/HBoxContainer".get_node('Panel' + str(Global.misses)).self_modulate = Color('dfff0012')
			#Global.points += 70 + 100/floor(round_timer)
		'VaccineCardRick':
			$"PhoneMockup".get_node("PhoneBackground/VideoPlayer").stop()
			$"PhoneMockup".get_node("PhoneBackground/VideoPlayer").visible = false
			Global.misses += 1
			if Global.misses == 4:
				end_game('lifes')
			$"Round Info/Panel/Panel/HBoxContainer".get_node('Panel' + str(Global.misses)).self_modulate = Color('dfff0012')
		_:
			print(round_type)
	$"PhoneMockup".get_node("PhoneBackground/VBoxContainer").visible = false
	finish_round()

	pass # Replace with function body.

func spawn_cards(type):
	var Name = Global.random(Global.Name)
	var card = QRCode.instance()
	card.Type = Global.random(Global.Vaccine)
	card.Name = Global.random(Global.Name)
	card.StartDate = Global.random(Global.Date)
	card.ButType = type
	card.connect("clicked_qrcode", self, 'show_data')
	if type == 'VaccineCardWrongDate' or type == 'VaccineCardWrongDateBribe':
		card.DateOffset = floor(rand_range(1, 20))
	var id = ID.instance()
	id.Name = Global.random(Global.Name)
	id.BirthDate = Global.random(Global.BirthDate)
	add_child_below_node($PhoneMockup,card)
	add_child_below_node($PhoneMockup,id)
	if type == 'VaccineCardWrongDateBribe':
		var bribe = bribe.instance()
		add_child_below_node($PhoneMockup,bribe)
	yield(get_tree().create_timer(0.1), "timeout")
	$Tween.interpolate_property(get_node('QRCode'),'rect_position', Vector2(-600,-600), rect_size/2, 1,Tween.TRANS_EXPO)
	$Tween.interpolate_property(get_node('IDCard'),'rect_position', Vector2(-600,-600), rect_size/2, 1,Tween.TRANS_EXPO)
	$Tween.start()
	card.show()
	id.show()
	yield(get_tree().create_timer(0.5), "timeout")


func _on_Button_pressed():
	get_tree().quit()
	pass # Replace with function body.

func show_data(but):
	print(but)
	match but.ButType:
		'VaccineCard', 'VaccineCardWrongDate':
			$"PhoneMockup".get_node("PhoneBackground/VBoxContainer").visible = true
			$"PhoneMockup".get_node("PhoneBackground/VBoxContainer/Label").text = 'Name: ' + but.Name
			$"PhoneMockup".get_node("PhoneBackground/VBoxContainer/Label2").text = 'First Vaccine: ' + '%02d/%02d/%02d'%[but.StartDate.day,but.StartDate.month,but.StartDate.year]
			$"PhoneMockup".get_node("PhoneBackground/VBoxContainer/Label3").text = 'Second Vaccine: ' + '%02d/%02d/%02d'%[but.EndDate.day,but.StartDate.month,but.EndDate.year]
			pass
		'VaccineCardRick':
			print('test')
			$"PhoneMockup".get_node("PhoneBackground/VideoPlayer").visible = true
			$"PhoneMockup".get_node("PhoneBackground/VideoPlayer").play()


func _on_Reject_pressed():
	match round_type:
		'VaccineCard':
			print('VaccineCard')
			Global.points -= 70 + 100/floor(round_timer)
			Global.misses += 1
			if Global.misses == 4:
				end_game('lifes')
			$"Round Info/Panel/Panel/HBoxContainer".get_node('Panel' + str(Global.misses)).self_modulate = Color('dfff0012')
		'VaccineCardRick':
			$"PhoneMockup".get_node("PhoneBackground/VideoPlayer").stop()
			$"PhoneMockup".get_node("PhoneBackground/VideoPlayer").visible = false
			Global.points += 70 + 100/floor(round_timer)
		_:
			Global.denied += 1
			Global.points += 70 + 100/floor(round_timer)
	$"PhoneMockup".get_node("PhoneBackground/VBoxContainer").visible = false
	finish_round()


func _on_Start_pressed():
	$"Panel2".visible = false
	start_round('VaccineCard')
	pass # Replace with function body.
