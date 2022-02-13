extends Spatial

var denpa_base = preload("res://scenes/DenpaBase.tscn")
var handheld_mode = false

onready var d = $Denpas

func _process(_delta) -> void:
  var denpa_num = d.get_child_count()

  if denpa_num <= 14:
    var denpa = generate()
    d.add_child(denpa)
    denpa.global_transform.origin = Vector3( rand_range(-10, 10), rand_range(-10, 10), rand_range(-10, 10))
  else:
    pass # this is where you would queue free some random denpa
  return

func generate() -> Node:
  var denpa = null
  if handheld_mode:
    #scan wifis, do some tomfoolery
    pass
  else:
    denpa = denpa_base.instance()
    denpa.chosen_name = str(randi() % 100) #get name from array of names
    #get player level and use as base for level
    denpa.antenna = randi() % 100
  return denpa
