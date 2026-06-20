extends Resource
## Resource for what enemies spawn in a level, how much, how often, etc.
class_name LevelEnemySpawns

@export var enemies : Array[EnemyStats] ## The list of enemies you want spawned in that wave

@export var starting_spawn_time : float = 1.5 ## Where the spawn timer starts
@export var minimum_spawn_time : float = 0.05 ## The spawn time will be limited down to this
@export var spawn_time_increment : float = 0.01 ## How much the spawn time decreases everytime, making it quicker overtime

@export var enemy_limit : float = 20 ## Limits the amount of enemies available on at a time, to reduce lag

@export var min_enemy_spawn_amount : int = 1 ## The minimum amount of enemies it'll spawn at a single instance
@export var max_enemy_spawn_amount : int = 1 ## The maximum amount of enemies it'll spawn at a single instance
