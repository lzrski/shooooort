React         = require 'react'
URLForm       = require './URLForm'
URLList       = require './URLList'
# config        = require '../config'

module.exports = (props) ->
  { urls } = props
  <div>
    <URLForm />
    <URLList urls = { urls } />
  </div>
