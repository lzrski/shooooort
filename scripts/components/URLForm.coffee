React         = require 'react'
{ dispatch }  = require '../store'

module.exports = () ->
  input   = null
  button  = null

  <form
    onSubmit = { (event) =>
      do event.preventDefault

      url         = input.value
      input.value = ""
      button.disabled = yes
      dispatch  { type: 'shorten', url }
    }
  >
    <input
      type        = 'text'
      ref         = { (element) -> input = element }
      placeholder = 'Paste the link you want to shortened here'
      onChange    = { (event) =>
        button.disabled = not input.value.trim().length
      }
    />
    <button
      disabled = { yes }
      ref      = { (element) -> button = element }
    >
      Shorten this link
    </button>
  </form>
