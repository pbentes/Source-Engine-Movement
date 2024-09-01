# Source Engine Movement
 
A godot 4 implementation of the quake and source engine style of movement built around a state machine.

This implementation utilizes an architecture which separates systems from the actors who use them. So, for instance, the player actor uses the state machine and the locomotion systems for handling player control but these same systems can be reused by an NPC actor.

As of yet I'm aiming to implement the main movement mechanics from CS2

## Project structure

- The levels folder contains playable levels and currently contains only a devtest level;

- The modules folder contains the actors and systems folders;

    - The actors folder contains the player actor;

    - The systems folder contains the locomotion and the state machine systems;

- The script_templates folder currently contains only a template for quickly creating a state script.

## Features

- [x] Running
- [x] Walking
- [x] Crouching
- [x] Airborne
- [ ] Ladder