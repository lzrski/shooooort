React         = require 'react'
URLForm       = require './URLForm'
URLList       = require './URLList'
# config        = require '../config'

module.exports = (props) ->
  { urls } = props
  <div>
    <header>
      <h1>Shooooort</h1>
      <h2>The link shortener with a long name</h2>
    </header>
    <URLForm />
    <URLList urls = { urls } />
  </div>
