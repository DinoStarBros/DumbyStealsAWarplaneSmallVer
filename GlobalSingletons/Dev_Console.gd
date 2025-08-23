extends Control

var expression : Expression = Expression.new()

func _ready() -> void:
	g.game = self # for testing purposes
	
	%CommandLine.text_submitted.connect(_on_text_submitted)

func _on_text_submitted(command : String) -> void:
	var error : = expression.parse(command)
	if error != OK:
		print(expression.get_error_text())
		return
	var result = expression.execute()
	
	if not expression.has_execute_failed():
		print(result)
