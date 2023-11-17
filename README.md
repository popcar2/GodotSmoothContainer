# Godot Smooth Container

Godot smooth container is a custom flow container that smoothly Tweens nodes into place, rather than snap them with no animation. It's a bit thrown together and was made in an afternoon, but it may still be useful to someone out there trying to achieve the same effect.

⚠️Be aware that using this can be taxing on performance if you have too many children (~100+)⚠️

https://github.com/popcar2/GodotSmoothContainer/assets/16920817/cd93e8d2-cd3d-4a4c-b614-6be4a3480b25

## How to use

1. Attach `SmoothContainer.gd` to a Control node, make sure to set the anchor properly.
2. Change the signal in the `_ready()` function to whenever you'd like to update the position of children, or call `update_positions()` yourself.
3. Add a ScrollContainer as a parent if you need scroll bars to appear when nodes overflow out of bounds.
4. Adjust the `poll rate` if needed, but beware that calling the function every 0.1 seconds or less can be very performance taxing.

## Why isn't this an actual container?

From what I understand containers in Godot can't move or Tween children freely, everything has to click into place, which stops animations like this one from being possible.

---

Loved the project? [Consider buying me a cup of Ko-Fi!](https://ko-fi.com/popcar2)
