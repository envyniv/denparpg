extends Control


export(Color) var inSight = Color(0.572549, 0.388235, 0.670588)

onready var world=$ViewportContainer/Viewport/Spatial
onready var Crosshair=$Crosshair
onready var Name=$HBoxContainer/Name
onready var Level=$HBoxContainer/Level
onready var Antenna=$HBoxContainer/Antenna
onready var Catchable=$Catchable/Label

onready var Radar=$Radar
onready var Sight=$Radar/Sight
onready var Denpas=$Radar/Denpas

var Dot = load("res://assets/point.png")

func _ready() -> void:
  world.camera.connect("available", self, "on_available")
  world.camera.connect("not_available", self, "on_gone")
  world.connect("update_denpa", self, "on_update_denpa")
  return

func on_available(target = null) -> void:
  Crosshair.modulate=inSight
  if target:
    Name.text = target.chosen_name
    Level.text = "Level: "+str(target.level)
    #Antenna.text =
    Name.show()
    Level.show()
    Antenna.show()

func on_gone() -> void:
  Crosshair.modulate=Color(1,1,1)
  Name.hide()
  Level.hide()
  Antenna.hide()

func _process(_delta) -> void:
  if Sight:
    Sight.rect_rotation = -world.camera.rotation_degrees.y - 37
  return

func on_update_denpa(id : int, dddpos: Vector3) -> void:
  var ddpos = Vector2(dddpos.x/30*90.5, dddpos.z/30*90.5) #2d position
  if !Denpas.has_node(str(id)):
    var tex=TextureRect.new()
    tex.texture=Dot
    tex.rect_size=Vector2(8, 8)
    tex.rect_pivot_offset=Vector2(4, 4)
    Denpas.add_child(tex)
    Denpas.get_child(id).name=str(id)
  Denpas.get_node(str(id)).rect_position=ddpos
  return
