params
title: Godot - Asteroids Game For Complete Beginners: 5
endparams

## Warning, this article is still in development! Do not use for learning yet!

### [Previous Article: Godot Asteroids Tutorial - Part 4](godot-asteroids-04.html)

## Introduction

This is part 5 of the tutorial series for making an asteroids style game in
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
can use it to display our score of destroyed asteroids. Since we want to display
the score we have, and also the text "Score:" to show that the number shown
represents the score, two `Label` nodes will be required. They can both be
created in the Scene panel, name the one that contains the text "Score:"
`ScoreText`, and name the label that will contain the number `Score`. The nodes
can then be assigned a default text value by using the Inspector panel (in the
`Text` property). `ScoreText` will have the value `Score:` assigned. `Score`
will have the default value `0` assigned as that is going to be the default
value of the score when the game starts.

![](godot-asteroids/godot_25.png)

At this point, you may notice that the two labels are on top of each other,
that's because they are both currently situated at coordinates (0,0) on the
Control node they are a child of. Drag the number score to the right of the
text score node as shown below.

![](godot-asteroids/godot_24.png)

It is time to create and attach a script so that we can link the score to it. In
the Scene panel, right click on the `code` folder and select `New Script`. For
the script name, choose `HUD.gd` and make sure it inherits `Control` node, this
is because the root node is also a control node. Make sure to drag the script
from the FileSystem panel to the root node that is called `HUD` in the Scene
panel in order to attach the script.

## Incrementing the Score Counter

This section will cover how to display the amount of destroyed asteroids on the
HUD. In order to achieve this, the bullet script will need to be modified to
increment the value of the variable that is keeping track of the score, and also
to write the HUD code in order to display and update it. Start by opening
`code/HUD.hd`

## Singletons in Godot

## Signals in Godot

## Reseting the Score Counter

## Project Files

## Useful Links

1. [Godot UI Basics](https://docs.godotengine.org/en/stable/getting_started/step_by_step/ui_introduction_to_the_ui_system.html#)
2. [Singleton Nodes](https://docs.godotengine.org/en/stable/getting_started/step_by_step/singletons_autoload.html)
3. [Signals](https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html)

## What's Next

[_You are at the end of this journey, but a bigger one has just begun!_](https://docs.godotengine.org/en/stable/)