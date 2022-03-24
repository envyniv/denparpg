extends KinematicBody

var inkball = preload("res://scenes/InkBall.tscn")

onready var animplayer   = $AnimationPlayer
onready var colshp       = $CollisionShape
onready var body         = $Body
onready var head         = $Body/Head
onready var vis_antenna  = $Body/Head/Antenna
onready var antenna_ring = $Body/Head/Antenna/All


export(String) var chosen_name = ""
export(int) var level = 90

export(int) var color = 0
export(int) var antenna = 0 #possibly enum

#export(int) var head = SceneMan.heads.ROUND    #possibly enum
export(int) var face = 0    #possibly enum
export(int) var hair = 0    #possibly enum
export(int) var eyes = 0    #possibly enum
export(int) var mouth = 0    #possibly enum
export(int) var nose = 0    #possibly enum
export(int) var glasses = 0    #possibly enum

export(int) var height = 0

export(int) var ATK = 0
export(int) var DEF = 0
export(int) var SPD = 0
export(int) var EVA = 0
export(int) var mHP = 0
export(int) var mAP = 0

export(PoolByteArray) var preview = null

export(String) var origin = "" #for wifi generation

enum {IDLE, THROW, WANDER, FOLLOW}

var _current_state = IDLE
var point = null

signal spawned_ball
signal lemmeThrow
signal imLeaving

func _physics_process(_delta):

  match _current_state:
    IDLE:
      Idle()
    THROW:
      BeginThrow()
    WANDER:
      Wander()
  return

func Wander() -> void:
  var direction
  point = get_parent().get_parent().rnd_pos()
  if point.distance_to(transform.origin) > 0.05:
    direction = point - transform.origin
    direction = direction.normalized() * 5
  else:
    direction = point - transform.origin
    _current_state=IDLE
  #warning-ignore:return_value_discarded
  move_and_slide(direction)
  return

func BeginThrow() -> void:
  emit_signal("lemmeThrow", self)
  _current_state = IDLE
  return

func Throw() -> void:
  var ball = inkball.instance()
  ball.color=color #give it your color
  get_parent().get_parent().add_child(ball) #spawn ball
  ball.global_transform.origin = global_transform.origin #make it look like you spawned it 
  #yield(animplayer.play("Throw"), "finished")
  emit_signal("spawned_ball", ball)
  _current_state=IDLE
  return

func Idle() -> void:
  if !(animplayer.is_playing()):
    match randi() % 6:
      0:
        #play sitting anim
        pass
      1:
        #play look around
        pass
      3:
        _current_state=WANDER
      4:
        #if timer.is_stopped():
        #  timer.start()
        #  yield(timer, "timeout")
        _current_state=THROW
      5:
        pass # nothing
  return

func nuclearize() -> void:
  #play animation to dissolve and show particles
  emit_signal("imLeaving", self)
  hide()
  queue_free()
  return

func Spawn(_throwthese, _inthetrash) -> void:
  colshp.disabled=false
  show()
  #play animation to fade in and show water thingy
  return

func _ready() -> void:
  var mat=SceneMan.denpamaterial.duplicate()
  mat.albedo_color=SceneMan.colors_alpha[color]
  mat.emission=SceneMan.colors_alpha[color]
  body.material=mat
  body.material.flags_transparent=true
  head.material=mat
  head.material.flags_transparent=true
  return
