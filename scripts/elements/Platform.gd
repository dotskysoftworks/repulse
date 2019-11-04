extends Spatial

export (int) var platformId = 0
export (bool) var enabledOnStart = false
export (float) var xTarget = 0
export (float) var yTarget = 0
export (float) var zTarget = 0
export (float) var attack = 0.3
export (float) var release = 0.3

onready var target = Vector3(xTarget, yTarget, zTarget)
var enabled = false
var next = Vector3()
var interpolation: float