extends Node

#Make sure to add CollisionShape2D
#https://docs.godotengine.org/en/stable/tutorials/physics/physics_introduction.html


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
			for child in $Players.get_children():
			for i in child.get_slide_collision_count():
				var collision = child.get_slide_collision(i)
				#print("I collided with ", collision.get_collider().name)
				#print(collision.get_collider().get_class())
				#print(collision.get_collider().get_parent().get_class())
				if(not child.playerType):
					#print("seeker collided")
					#print(collision.get_collider())
					if(collision.get_collider().get_class() == "CharacterBody2D"):
						#print("seeker collided with hider")
						#print(child.name)
						print(hiders)
						tag.emit(child)
