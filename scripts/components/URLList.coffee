React         = require 'react'
map           = require 'lodash.map'

module.exports = (props) ->
  { urls } = props
  <div>
  {
    map urls, (item, key) ->
      { url, shortcode } = item
      console.log { key, url, shortcode }
      <p key = {key}>{shortcode} -- {url}</p>
  }
  </div>
