# Godot - Asteroids Game For Complete Beginners: 4

## Warning, this article is still in development! Do not use for learning yet!

## Introduction

This is part 4 of the tutorial series for making an asteroids style game in
Godot, designed for absolute beginners with little to no experience in
programming.

This article will cover:

1. Making a score counter user interface for the game.
2. Making the score counter increment when the player shoots a meteor.
3. Making the score counter reset when the player ship gets hit by a meteor.

Before going through this article, it is recommended following the steps
outlined in the previous parts of this tutorial series.

## Basics of Godot's UI Nodes

Creating user interfaces in Godot is identical to creating 2D scenes, your user
interface elements are nodes, you have a root node that has child nodes that
form either a single piece of UI or a system, depending on the design decisions
taken. All UI nodes in Godot extend from a derived node of the `Control` node
or extend from the `Control` node directly. The `Control` node implements the
base features that are required in order for a UI node to function. 

## Godot Singleton Nodes

In Godot, when a scene is loaded, the previous scene's information is lost, so
storing the player high score is impossible without the use of singleton nodes.
Singleton nodes exist outside of the scene and can be used to store data that we
want to be persistent. When the player dies and we reset the scene (that is, we
load the same scene again, throwing away the old instance of the scene), the
high score will be lost if it is stored on a normal node. This is why singleton
nodes exist, they are loaded at the very start of the game, and persist
throughout until the game is closed, this allows us to use them to store
information between scenes.

## Making the UI

Creating a UI scene is similar to a 2D scene, on the top-left menu bar of the
editor window, click on `Scene -> New Scene`, however, instead of clicking on
`2D Scene` in the Scene panel, click on `User Interface`, this will create a new
scene, however, instead of the root node being a `Node2D` type of node, it is
now a `Control` node, which is the base building _block_ of UI nodes. Rename the
root node to `HUD` using the Scene panel. Save the scene as `HUD.tscn` in the
`objects` folder.

### Label Node

Godot has a UI node called `Label` that allows you to display information, we
can use it to display our score of destroyed asteroids.

### Godot Signals

## Incrementing the Score Counter

## Reseting the Score Counter

## Project Files

## What's Next

## Useful Links

1. [Godot UI Basics](https://docs.godotengine.org/en/stable/getting_started/step_by_step/ui_introduction_to_the_ui_system.html#)
2. [Singleton Nodes](https://docs.godotengine.org/en/stable/getting_started/step_by_step/singletons_autoload.html)
