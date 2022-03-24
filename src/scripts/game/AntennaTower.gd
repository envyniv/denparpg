extends Control


export(Color) var inSight = Color(0.572549, 0.388235, 0.670588)

onready var world=$ViewportContainer/Viewport/Spatial
onready var Crosshair=$Crosshair
onready var Name=$HBoxContainer/Name
onready var Level=$HBoxContainer/Level
onready var Antenna=$HBoxContainer/Antenna
onready var Catchable=$Catchable/Label
onready var View=$ViewportContainer/Viewport

onready var Radar       = $Control/Radar
onready var Sight       = $Control/Radar/Sight
onready var Denpas      = $Control/Radar/Denpas
onready var InkSplashes = $InkSplashes


var Dot = preload("res://assets/point.png")
var inksplash = preload("res://scenes/InkSplash.tscn")

func _ready() -> void:
  world.player.connect("available", self, "on_available")
  world.player.connect("not_available", self, "on_gone")
  world.connect("update_denpa", self, "on_update_denpa")
  world.connect("you_got_splashed", self, "add_splash")
  
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
  if Denpas:
    Denpas.rect_rotation = world.player.rotation_degrees.y
  if View:
    View.size=OS.get_window_size()
  return

func on_update_denpa(id : int, dddpos: Vector3) -> void:
  var ddpos = Vector2(dddpos.x/30*90.5-4, dddpos.z/30*90.5-4) #2d position
  if !Denpas.has_node(str(id)):
    var tex=TextureRect.new()
    tex.texture=Dot
    tex.rect_size=Vector2(8, 8)
    Denpas.add_child(tex)
    Denpas.get_child(id).name=str(id)
  Denpas.get_node(str(id)).rect_position=ddpos
  return

func add_splash(Position : Vector2, Clr : Color) -> void:
  var ink=inksplash.instance()
  InkSplashes.add_child(ink)
  var win_h = OS.get_window_size().y
  ink.rect_size     = Vector2(win_h, win_h)
  ink.modulate      = Clr
  ink.rect_position = (Position - ink.rect_size/2)
  yield(get_tree().create_timer(6), "timeout")
  ink.queue_free()
  return
