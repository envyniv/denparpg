extends Node
#handles saves, antennas, places, etc

var data = SaveClass.new()

var save="user://save.res"

var places = {
  "catch":"res://scenes/game/CatchScrn.tscn"
}

func _ready():
  var f = File.new()
  if f.file_exists(save):
    data=load(save)

func change_scene(target:String, delay=0.5):
  yield(get_tree().create_timer(delay), "timeout")
  assert(get_tree().change_scene(places[target]) == OK)
  return

func add_caught(target):
  var scene=PackedScene.new()
  data.caught.append(scene.pack(target))
  return
