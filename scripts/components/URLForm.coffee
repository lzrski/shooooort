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
        @setState valid: no
        dispatch  { type: 'shorten', url }
      }
    >
      <input
        type        = 'text'
        ref         = 'input'
        placeholder = 'Paste the link you want to shortened here'
        onChange    = { (event) =>
          @setState valid: Boolean @refs.input.value.trim().length
        }
      />
      <button disabled = { not @state.valid }>Shorten this link</button>
    </form>

  constructor: (props) ->
    super props

    @state = valid: no
