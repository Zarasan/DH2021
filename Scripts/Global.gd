extends Node

var currentround = 0
var misses = 0
var allowed = 0
var denied = 0
var bribes = 0
var points = 0


var RoundOrder = [
	'VaccineCard',
	'VaccineCardRick',
	'VaccineCard',
	'VaccineCardWrongDate',
	'VaccineCard',
	]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Name = ['Mark Marksberg', 'Aaron Smithson', 'Blair Burch', 'Andrea Mcgregor', 'Jacque Gibson', 'Dixie Fulton', 'Nikola Merritt']
var BirthDate = [
	{
		'day' : 5,
		'month' : 5,
		'year' : 1998
	}
]
var Date = [
	{
		'day' : 3,
		'month' : 5,
		'year' : 2021
	},
	{
		'day' : 3,
		'month' : 3,
		'year' : 2020
	},
		{
		'day' : 1,
		'month' : 4,
		'year' : 2021
	},
	{
		'day' : 2,
		'month' : 4,
		'year' : 2021
	},
]
var Vaccine = [
	{
		'Name' : 'Pfizer',
		'Delay' : 21
	}
]

func random(arr):
	return arr[randi()%arr.size()]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
