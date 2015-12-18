React         = require 'react'

###

Must this component must stateful?

###

module.exports = class URLForm extends React.Component
  render: ->
    console.dir @props
    <form
      onSubmit = { (event) =>
        do event.preventDefault

        { input }   = @refs
        url         = input.value
        input.value = ""
        console.log url
      }
    >
      <input
        type        = 'text'
        ref         = 'input'
        placeholder = 'please enter URL to be shortened here'
      />
      <button>Shorten</button>
    </form>
