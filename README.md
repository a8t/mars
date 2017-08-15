# mars

Things I've implemented:

Rover, Plateau, MissionControl classes

- declare Plateau object with x, y size
- includes methods for testing if rovers are at the edge or about to collide with other rovers on the same plateau

- declare Rover object with initial x, y coords and initial direction and which plateau it's on
- includes method for turning, moving (including checking for edge/collision before moving), and for parsing instruction strings e.g. "LLMMMRMRLMRML"

- MissionControl simply contains a send_instructions method that takes an array of instruction strings and an array of target rovers. If only one instruction string is given, all rovers follow the same directions; otherwise, each rover follows the corresponding instructions.
