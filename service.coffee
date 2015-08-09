R = require 'ramda'
hue = require 'node-hue-api'
somata = require 'somata'

{host, user} = require './config'

state_keys = 'on bri hue sat'.split(' ') # What to maintain during a pulse

api = null
connect = ->
    api = new hue.HueApi(host, user)
connect()
setInterval connect, 1000*60*60

showGot = (tag) -> (got) -> console.log "[#{tag}]", got

lights = (cb) -> api.lights().then (response) -> cb null, response.lights

fullState = (cb) ->
    api.fullState().then (response) ->
        cb(null, response)
    .fail (err) -> console.log '[ERROR]', err

getState = (n, cb) ->
    api.lightStatus(n).then (response) ->
        cb(null, response.state)

setState = (n, state, cb) ->
    api.setLightState(n, state).then -> cb()
    hue_service.publish 'changeState', {id: n, state}

pulseState = (n, state, t, cb) ->
    api.lightStatus(n).then (response) ->
        revert = -> setState n, R.pick(state_keys)(response.state), cb
        setState n, state, -> setTimeout revert, t

turnOn = (n, cb) ->
    setState n, {on: true}, cb

turnOff = (n, cb) ->
    setState n, {on: false}, cb

setRGB = (n, r, g, b, cb) ->
    setState n, {on: true, rgb: [r, g, b]}, cb

pulseRGB = (n, r, g, b, t, cb) ->
    pulseState n, {on: true, rgb: [r, g, b]}, t, cb

hue_service = new somata.Service 'maia:hue', {
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
