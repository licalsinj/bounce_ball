# TODO

## Goal/Objective

A simple one button game where
a colored ball has to be sorted
into different colored buckets.

## Personal Goals

Complete a game dev cycle and deploy a simple but finished game.

## Game Cycle

Here's how the game should play out

- Ball is generated in the top center. It moves left/right randomly as a set speed
- The player waits for the ball to be above the right bucket
- The player presses a button to drop the ball
- The ball falls
- If it lands in the right bucket
  - the user gets a point
  - another ball (with a random color & direction)
  - faster speed
- If it lands in the wrong bucket
  - the user loses
  - the score is presented
  - then they can start a new game

### Stretch Goals

- Add sounds that are related to different colors
- Add multiple colored buckets/balls as the speed progresses

## Enhancements

- [x] Generate a ball
- [x] Allow the ball to drop
- [x] Make the ball a random color
- [x] Make a ball go a random direction
- [x] Create buckets/columns for the ball to land in
- [x] Check if the ball landed in the right color bucket
- [x] Add more colored buckets at the bottom
- [x] Add some useful comments
- [x] Make a function that resets Ball
- [x] Add a pause button
- [x] Get New Buckets to appear in the center of the list
- [x] Figure out how to break this into smaller files. I'm getting lost in main.lua
- [x] Add a Dark Mode
- [x] Understand how to link screen size with constants
- [ ] Add sounds
- [ ] Enable it to work with a mouse and touch
  - Left click is drop unless you hit the pause button.
- [ ] Store and save high scores
- [ ] Splash Screen
- [ ] Improve Game Over and Pause images
- [ ] Add background music
- [ ] Menu Options

### Add Sounds

This is big enhancement so I'm breaking it up into sub tasks:

- [x] Get sounds to play
- [x] Get sound to play when bounces off walls
  - Probably want this to be based on change in direction
- [ ] Get new ball sound to ALWAYS play
- [ ] Get different notes to play depending on which border/region it's hovering over
  - Border and region are two different ideas. I think I want the note associated with the border not the region
  - However that might mess with the xylophone effect
  - This is implemented poorly right now. Needs a second/closer look!

### Menu Options

This is a big enhancement so I'm breaking it up into sub tasks:

- [ ] Set Light/Dark Mode
- [ ] Quit/Reset mid game
- [ ] Sound management
  - Toggle Background music
  - Toggle Sound Effects
  - Volume level of BG music
  - Volume Level of Sound Effects

## NOT Doing

- Make the background more interesting with shaders
- Add Momentum to Falling
- Make the point system more complex
  - Like you lose points for bouncing off the walls or crossing boundaries unnecessarily?
- Customize Colors and Sounds?
- Add more color modes
- Add custom art to balls/buckets/background

## Bugs

- [x] I'm confident I'm not doing Defaults right in Lua
  - I'm now using functions to reset, which is at least consistent
      and not duplicating code
- [x] Reset after Game Over immediately drops ball
- [x] When the ball drops close to the edge you get a game over
        even if it's the right color
        - This was caused by the speed overshooting the edge of the frame
- [x] Switching Color Modes mid game does not change the color of the buckets

## Colors

### Dark Mode

- Dark Red - #B12732
- Dark Orange - #B86829
- Dark Yellow - #B8A928
- Dark Green - #30B729
- Dark Blue - #37359F
- Dark Purple - #74248F

### Light Mode

- Light Red - #B2676D
- Light Orange - #E78358
- Light Yellow - #C0B86B
- Light Green - #91C083
- Light Blue - #5169A0
- Light Purple - #8B73A2

- Dark Grey - #424242
- Light Grey - #CECECE
