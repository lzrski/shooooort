React         = require 'react'
{ dispatch }  = require '../store'

###

Must this component must stateful?

###

module.exports = class URLForm extends React.Component
  render: ->
    <form
      onSubmit = { (event) =>
        do event.preventDefault

        { input }   = @refs
        url         = input.value
        input.value = ""
        dispatch  { type: 'shorten', url }
      }
    >
      <input
        type        = 'text'
        ref         = 'input'
        placeholder = 'please enter URL to be shortened here'
      />
      <button>Shorten</button>
    </form>
