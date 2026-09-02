extends Area2D

signal interacted(interactor: Node)

@export var interaction_prompt := ""
@export var interaction_enabled := true


func get_interaction_prompt() -> String:
	return interaction_prompt


func is_interactable(_interactor: Node) -> bool:
	return interaction_enabled and is_inside_tree()


func interact(interactor: Node) -> bool:
	if not is_interactable(interactor):
		return false
	interacted.emit(interactor)
	return true
