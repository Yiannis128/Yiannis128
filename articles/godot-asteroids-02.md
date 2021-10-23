# Godot - Asteroids Game For Complete Beginners: 2

## Warning, this article is still in development! Do not use for learning yet!

## Introduction

This is part 2 of the tutorial series for making an asteroids style game in
Godot, designed for absolute beginners with little to no experience in
programming.

This article will cover:

1. Creating bullets for the player ship.
2. How to make the player ship shoot bullets.
3. Making the asteroids break when hit by the bullets.

Before going through this article, it is recommended following the steps
outlined in [part 1](godot-asteroids-01.html) of this tutorial series.

## The Bullet Scene

First start by creating a new scene `Scene->New Scene` at the top menu bar, this
scene will be used to represent a single bullet. Once the new scene is created,
in the _Scene_ panel, create a _2D Scene_. Rename the root node from _Node2D_
to _ShipBullet_ and save the scene into the objects folder in the project files.
Like before, change the root node's type to _CharacterBody2D_, this is because
the bullet will need to move. Proceed to add a new node as a child of type
_CollisionShape2D_. In the _Inspector_ panel, click on the `[empty]` value of
the shape property and assign a _New CircleShape2D_.

From the _FileSystem_ panel, the _sprites_ folder, drag the 
_meteorBrown\_tiny1.png_ into the scene to use as the sprite for the bullet.
Like before, make sure to center it to the origin of the scene so it overlaps
with the CollisionShape2D. 

![](godot-asteroids/godot_18.png)

## The Bullet Code

It is time to create a script that will cause the bullet to move forward,
along with assigning it to the scene. 

## Shooting the Bullets

## Breaking the Asteroids

## Project Files

## What's Next

## Useful Links