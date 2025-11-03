# TODO 

## Goal/Objective

A simple one button game where a colored ball has to be sorted into different colored buckets.

## Game Cycle
Here's how the game should play out
- Ball is generated in the top center. It moves left/right randomly as a set speed
- The player waits for the ball to be above the right bucket
- The player presses a button to drop the ball
- The ball falls
- If it lands in the right bucket the user gets a point, another ball (with a random color & direction), faster speed
- If it lands in the wrong bucket the user loses and the score is presented, then they can start a new game

### Stretch Goals
- Add sounds that are related to different colors
- Add multiple colored buckets/balls as the speed progresses

## Enhancements
- [ ] Generate a ball
- [ ] Allow the ball to drop
- [ ] Make the ball a random color
- [ ] Make a ball go a random direction
- [ ] Create buckets/columns for the ball to land in
- [ ] Check if the ball landed in the right color bucket

## Bugs
- [ ] I'm confident I'm not doing Defaults right in Lua
