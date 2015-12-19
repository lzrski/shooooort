# Required by request/combined-stream/deleyed-stream
proto = Object.prototype

# TODO: Better use Object.defineProperty proto, '__define_getter__', {...}

if not proto.__defineGetter__? then proto.__defineGetter__ = (name, func) ->
  descriptor = Object.getOwnPropertyDescriptor this, name
  new_descriptor =
    get         : func
    configurable: true

  if descriptor?
    console.assert descriptor.configurable, "Cannot set getter"
    # COPY OLD SETTER
    if descriptor.set? then new_descriptor.set = descriptor.set

  Object.defineProperty this, name, new_descriptor

if not proto.__defineSetter__? then proto.__defineSetter__ = (name, func) ->
  descriptor = Object.getOwnPropertyDescriptor this, name
  new_descriptor =
    set         : func
    configurable: true
  if descriptor?
    console.assert descriptor.configurable, "Cannot set setter"
    # COPY OLD GETTER
    if descriptor.get? then new_descriptor.get = descriptor.get

  Object.defineProperty this, name, new_descriptor
