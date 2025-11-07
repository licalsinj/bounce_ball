# TODO

## Goal/Objective

A simple one button game where
a colored ball has to be sorted
into different colored buckets.

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
- [x] Add some useful comments
- [x] Make a function that resets Ball
- [x] Add a pause button
- [ ] Understand how to link screen size with constants

- [ ] Get New Buckets to appear in the center of the list

### Stretch Enhancements

- [ ] Add more colors
- [ ] Add sounds
- [ ] Make the background more interesting
- [ ] Add Momentum to Falling
- [ ] Enable it to work with a mouse
  - Left click is drop unless you hit the pause button.
- [ ] Store and save high scores
- [ ] Make the point system more complex
  - Like you lose points for bouncing off the walls or crossing boundaries unnecessarily?
- [ ] Customize Colors and Sounds?
- [ ] Splash Screen
- [ ] Improve Game Over and Pause images

## Bugs

- [x] I'm confident I'm not doing Defaults right in Lua
  - I'm now using functions to reset, which is at least consistent
      and not duplicating code
- [x] Reset after Game Over immediately drops ball
- [x] When the ball drops close to the edge you get a game over
        even if it's the right color
        - This was caused by the speed overshooting the edge of the frame

## Colors

### Dark Mode

- Dark Red - #B12732
- Dark Orange - #B86829
- Dark Yellow - #B8A928
- Dark Green - #30B729
- Dark Blue - #1C1B55
- Dark Purple - #74248F

### Light Mode

- Light Red - #B3666C
- Light Orange - #B88257
- Light Yellow - #C0B769
- Light Green - #50F047
- Light Blue - #5856E6
- Light Purple - #CD3AFF

- Dark Grey - #424242
- Light Grey - #CECECE
