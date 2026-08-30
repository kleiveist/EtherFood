---
title: Reconstruction System
status: draft-design
updated: 2026-08-30
---
<!-- AUTO-GENERATED:backlink START -->
[← Back](40-world-systems.md)
<!-- AUTO-GENERATED:backlink END -->
# Reconstruction System

## Purpose

The reconstruction system translates the liberation of monster lairs into visible, playable changes to the world. It is the most important connection between combat and world restoration.

## Reconstruction Units

Each region can be divided into restorable units:

- a section of terrain;
- a nature node;
- a group of inhabitants or souls;
- a building or city function;
- a memory node;
- an ability or ability upgrade.

## Triggers

Reconstruction may be triggered by:

- defeating a lair core;
- closing a seal;
- cleansing several interconnected monster sources;
- completing a memory task;
- protecting a soul that has returned;
- defeating a regional boss.

## Presentation

Whenever possible, the change should be visible directly within the game space. Suitable forms include:

- the landscape rebuilding itself before the player's eyes;
- color, light, and sound returning;
- new routes growing into place or being uncovered;
- inhabitants occupying concrete locations rather than appearing only as abstract menu entries;
- a city developing through several recognizable stages.

## Technical Consequence

The world requires persistent states for every reconstruction unit. Quests, collision, enemies, navigation, dialogue, and music must be able to react to these states. The system should be data-driven so that regions do not have to be built exclusively through one-off scripts.
