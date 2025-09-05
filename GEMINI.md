# GEMINI.md

This file provides a comprehensive guide for developing the Slingshot Rage Game, a 2D platformer built with the Godot Engine. It outlines project-specific conventions, GDScript best practices, and troubleshooting methods to ensure a smooth and efficient development process.

## Project Overview

**Slingshot Rage Game** is a 2D platformer where the player controls a character that must be slingshotted up a challenging map. The game is inspired by difficult platformers like Jump King and Pogostuck, with a focus on precision and perseverance.

*   **Engine:** Godot 4.4
*   **Language:** GDScript
*   **Target Platform:** Mobile

## Getting Started

To run the project, open it in the Godot Engine (version 4.2 or later) and press the "Play" button. The main scene is configured to launch automatically.

## GDScript Style Guide

This style guide is based on the official Godot documentation and community best practices to ensure code is clean, readable, and consistent across the project.

### Formatting

*   **Indentation:** Use tabs for indentation.
*   **Line Length:** Keep lines of code under 120 characters.
*   **Blank Lines:**
    *   Use two blank lines to separate functions and logical blocks of code.
    *   Use one blank line to separate class members.
*   **Trailing Commas:** Use trailing commas for the last element in arrays and dictionaries. This makes version control diffs cleaner when adding new elements.
*   **Statements:** Use one statement per line.

### Naming Conventions

| Element | Case | Example |
| --- | --- | --- |
| Classes/Nodes | `PascalCase` | `PlayerController` |
| Functions & Variables | `snake_case` | `move_player()` |
| "Private" members | `_snake_case` | `_internal_variable` |
| Constants & Enums | `CONSTANT_CASE` | `MAX_SPEED` |
| Signals | Past Tense `snake_case` | `player_died` |

### Code Order

1.  `class_name` (if applicable)
2.  `extends`
3.  Docstring (`##` for class documentation)
4.  Signals
5.  Enums
6.  Constants
7.  Exported variables
8.  Public variables
9.  Private variables (prefixed with an underscore)
10. `onready` variables
11. Built-in virtual methods (e.g., `_ready`, `_process`)
12. Public methods
13. Private methods (prefixed with an underscore)

### Static Typing

*   **Use Type Hints:** Always use type hints for variables, function arguments, and return values. This improves code completion, error checking, and code clarity.
*   **Type Inference:** Use type inference (`:=`) when the type is clear from the context.

### Comments and Documentation

*   **Docstrings:** Use `##` for multi-line docstrings for classes and functions to enable auto-generated documentation.
*   **Comments:** Use `#` for single-line comments to explain complex logic.
*   **Self-Documenting Code:** Prefer writing clear, self-documenting code over adding excessive comments.

## Best Practices

*   **Scene Independence:** Each scene should be runnable on its own without errors. This promotes encapsulation and makes scenes easier to test and reuse.
*   **File and Directory Naming:** Use `PascalCase` for directories, scripts, and scenes. Name a script and its corresponding scene after the scene's root node to make searching for files easier.
*   **Signal Connections:** Connect signals in code (`my_node.some_signal.connect(my_function)`) instead of using the editor. This is less brittle and easier to refactor.
*   **Composition over Inheritance:** Favor creating complex objects by instancing scenes (composition) rather than relying heavily on scene inheritance.
*   **Use `class_name`:** Use the `class_name` keyword at the top of a script to register it as a new type in the Godot editor.

## Troubleshooting

### 1. Use the Debugger

Godot has a built-in debugger that is a powerful tool for finding and fixing problems in your code.

*   **Set Breakpoints:** Click in the margin to the left of the line numbers in the script editor to set a breakpoint.
*   **Inspect Variables:** While the game is paused, you can inspect the values of variables in the "Debugger" panel.
*   **Step Through Code:** Use the debugger's "Step Over" (F10), "Step Into" (F11), and "Continue" (F12) buttons to follow the flow of your script.

### 2. Print to the Console

Use the `print()` function to output the values of variables to the console to see what's happening in your script as it runs.

```gdscript
func _process(delta):
  var player_position = get_node("Player").position
  print("Player position: ", player_position)
```

### 3. Check the Output and Errors Tabs

Keep an eye on the "Output" and "Errors" tabs at the bottom of the Godot editor. Godot will report any errors or warnings here.

### 4. Use the Remote Scene Tree

When your game is running, the "Remote" tab above the scene tree shows the live scene tree of your running game. You can select nodes in the remote tree and inspect their properties in the "Inspector" in real-time.

- Do not edit the project.godot if something has to be done in the editor please give me step by step instructions on how to accomplish the task using the Godot Documentation. I will then complete the steps and let you know when i have completed the task.

## State Machines

### Use Node Based State Machines.

Please use node based state machines, to help keep the code cleaner and more managable for the future.

* You can find information about this at the the link below.:
 https://shaggydev.com/2023/10/08/godot-4-state-machines/
* When making the state machines, you will not be able to make the nodes in the Godot editor. Please go ahead and make the scripts, and i will make the nodes and attach them with your step bt step directions.