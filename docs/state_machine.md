# Finite-State Machine

## Overview
A Finite-State Machine (FSM) is a computational model used to design logic systems where an object can be in one of a finite number of states at any given time. 
Transitions between states are triggered by events or conditions, and the FSM ensures that only valid state transitions occur. 
FSMs are widely used in game development, robotics, UI systems, and many other fields where predictable behavior based on states is required.

## Key Concepts
### States
A State is a condition or situation that an entity can be in. At any point, the FSM is in one of the predefined states. States can represent different modes or phases, such as:

- Idle: A neutral or waiting state.
- Attacking: The entity is performing an attack.
- Blocking: The entity is defending against attacks.
- Stunned: The entity is unable to perform actions.

### Transitions
A Transition occurs when an FSM moves from one state to another due to an event, input, or condition. Transitions are often governed by a transition table, which defines the valid paths between states.

Example:

- From Idle, the entity can transition to Attacking or Blocking.
- From Attacking, the entity can transition back to Idle or be Stunned.
- Events and Inputs
- Events or inputs trigger state transitions. In games, these could be user inputs (such as key presses) or in-game events (such as getting hit by an enemy).

## FSM Workflow

1. Start in an initial state: The FSM begins in a predefined state i.e. `"Idle"`.
2. Process to events or inputs: The FSM listens to events like`UserInputService.InputBegan' and `UserInputService.InputEnded`.
3. Check for valid transitions: When an event occurs, the FSM checks if a transition is valid from the current state to the target state.
4. Update state: If the transition is valid, the FSM changes to the new state.
5. Repeat: The FSM continues to monitor inputs and process transitions.

[Examples](https://github.com/alpluspluss/roblox-fsm-tutorial/blob/main/file/state_machine.rbxl)

##### Note: This article is written by ChatGPT and revised by [Al](https://github.com/alpluspluss)