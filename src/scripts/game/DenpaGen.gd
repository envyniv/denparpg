extends Spatial

var denpa_base = preload("res://scenes/DenpaBase.tscn")
var previewScenery = preload("res://scenes/RenderMugShot.tscn")
var handheld_mode = false

onready var d = $Denpas
onready var camera = $Player

signal update_denpa

func _process(_delta) -> void:
  var denpa_num = d.get_child_count()
  if denpa_num <= 14:
    var denpa = generate()
    d.add_child(denpa)
    denpa.global_transform.origin = Vector3( rand_range(-20, 20), rand_range(-10, 10), rand_range(-20, 20))
    #warning-ignore:return_value_discarded
    connect("update_denpa", denpa, "Spawn")
    emit_signal("update_denpa", denpa.get_index(), denpa.global_transform.origin)
    disconnect("update_denpa", denpa, "Spawn")
  else:

    pass # this is where you would queue free some random denpa
  for i in denpa_num:
    emit_signal("update_denpa", i, d.get_child(i).global_transform.origin)
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
    denpa.antenna     = randi() % 100
    denpa.preview     = preview(denpa)
  return denpa

func preview(of_who) -> PoolByteArray:
  var new = Viewport.instance()
  add_child(new)
  
  var img = get_viewport().get_texture().get_data()
  return img
