# maia-hue

Maia service for Philips Hue lights. Mostly a wrapper around [node-hue-api](https://github.com/peter-murray/node-hue-api)

## Methods

```
maia:hue.{
    lights
    fullState
    getState
    setState
    pulseState
    turnOn
    turnOff
    setRGB
    pulseRGB
}
```

### `lights`

List of all lights.

### `fullState`

Full available Hue hub state: all lights, group, config, schedules, scenes, rules, and sensors. See [relevant node-hue-api documentation](https://github.com/peter-murray/node-hue-api#obtaining-the-complete-state-of-the-bridge) for more details.

### `getState [n]`

Returns a JSON object representing the state of light `n`.

### `setState [n] [state]`

Set the state of light `n` as a JSON object. See the output of `getState` for values you can set.

### `pulseState [n] [state] [t]`

Apply `setState` for `t` milliseconds

### `turnOn [n]`

Turn on light `n`.

### `turnOff [n]`

Turn off light `n`.

### `setRGB [n] [r] [g] [b]`

Set RGB value of light `n`.

### `pulseRGB [n] [r] [g] [b] [t]`

Set RGB value of light `n` for `t` milliseconds.
