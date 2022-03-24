extends Spatial

var denpa_base = preload("res://scenes/DenpaBase.tscn")
var handheld_mode = true

var throwQueue := []

onready var env = $Privacy
onready var d = $Denpas
onready var player = $Player
onready var timer = $Timer

signal update_denpa
signal you_got_splashed

func _ready() -> void:
  timer.connect("timeout", self, "ticket_eval")
  return

func _process(_delta) -> void:
  var denpa_num = d.get_child_count()
  if denpa_num <= 14:
    var denpa = generate()
    d.add_child(denpa)
    var rand_scale = rand_range(1, 3)
    denpa.scale    = Vector3(rand_scale, rand_scale, rand_scale)
    denpa.connect("lemmeThrow", self, "add_throw_queue")
    denpa.connect("spawned_ball", self, "_on_inkball")
    denpa.connect("imLeaving", self, "rm_throw_queue")
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
    var data = get_bssid()
    var _temp
    for device in data:
      denpa = denpa_base.instance()
      print(device)
      denpa.chosen_name= str(("0x"+device[5]).hex_to_int())
      denpa.antenna=("0x"+device[5]).hex_to_int()
      denpa.color= ("0x"+device[5]).hex_to_int()/SceneMan.colors.size()-SceneMan.colors.size()
  else:
    denpa = denpa_base.instance()
    denpa.chosen_name = str(randi() % 100) #get name from array of names
    #get player level and use as base for level
    denpa.antenna     = randi() % 100
    var _temp = SceneMan.get_random(SceneMan.colors)
    while (_temp == "GOLD" || _temp == "SILVER" || _temp == "PINK" ):
      _temp = SceneMan.get_random(SceneMan.colors)
    denpa.color = _temp
  return denpa
  
func get_bssid() -> Array: #get nearby devices' mac address
  var output : Array = []
  var devices : Array = [] 
  var values : Array = [] #array of arrays, essentially a matrix
  
  if OS.get_name()=="Windows":
    return []
  else:
    OS.execute(
      "nmcli",
      ["-t", "-f", "BSSID", "dev", "wifi"],
      true,
      output
      ) #scan nearby wifis
  
  devices = output[0].split("\n")
  #print(output)
  for line in devices:
    if !line.empty():
      values.append(line.split("\\:"))
  return values

func rnd_pos() -> Vector3: #method for denpas to reference to
  return player.cam.project_position(
        Vector2(
          rand_range(0, OS.get_window_size().x),
          rand_range(0, OS.get_window_size().y)
          ),
        rand_range(5, 25)
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

func add_throw_queue(addWho) -> void:
  if throwQueue.find(addWho):
    throwQueue.erase(addWho)
  throwQueue.append(addWho)
  timer.wait_time=rand_range(3, 15)
  if timer.is_stopped():
    timer.start()
  return

func rm_throw_queue(rmWho) -> void:
  if throwQueue.find(rmWho):
    throwQueue.erase(rmWho)

func ticket_eval() -> void:
  var ticket = throwQueue.pop_front()
  ticket.Throw()
  return
