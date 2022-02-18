extends Spatial

var denpa_base = preload("res://scenes/DenpaBase.tscn")
var handheld_mode = false

onready var env = $Privacy
onready var d = $Denpas
onready var player = $Player

signal update_denpa
signal you_got_splashed

func _process(_delta) -> void:
  var denpa_num = d.get_child_count()
  if denpa_num <= 14:
    var denpa = generate()
    d.add_child(denpa)
    denpa.connect("spawned_ball", self, "_on_inkball")
    denpa.global_transform.origin = (
      player.cam.project_position(
        Vector2(
          rand_range(0,OS.get_window_size().x),
          rand_range(0,OS.get_window_size().y)
          #randf() % OS.get_window_size().x,
          #randf() % OS.get_window_size().y
          ),
        rand_range(3, 18))
      #camera.rotation
      )
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
    denpa = denpa_base.duplicate().instance()
    denpa.chosen_name = str(randi() % 100) #get name from array of names
    #get player level and use as base for level
    denpa.antenna     = randi() % 100
    var _temp = SceneMan.get_random(SceneMan.colors)
    while _temp == "GOLD" || _temp == "SILVER":
      _temp = SceneMan.get_random(SceneMan.colors)
    denpa.color = _temp
  return denpa

func rnd_pos_visible() -> Vector3: #method for denpas to reference to
  return player.cam.project_position(
        Vector2(
          rand_range(0, OS.get_window_size().x),
          rand_range(0, OS.get_window_size().y)
          ),
        rand_range(3, 18)
        )

func _on_inkball(which) -> void:
  which.connect("hit", self, "_inkball_hit") #start listening to inkball
  return

func _inkball_hit(ball) -> void:
  emit_signal(
    "you_got_splashed",
    player.cam.unproject_position(ball.global_transform.origin),
    ball.spr.modulate
    ) #gets where
  return
