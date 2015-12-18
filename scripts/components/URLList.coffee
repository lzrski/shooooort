React         = require 'react'
map           = require 'lodash.map'
Moment        = require 'moment'
config        = require './config'

module.exports = (props) ->
  { urls } = props
  <table>
    <thead>
      <tr>
        <th>Link</th>
        <th>Visits</th>
        <th>Last visited</th>
      </tr>
    </thead>
      {
        map urls, (item, key) ->
          {
            url
            shortcode
            lastSeenDate
            redirectCount
          }     = item
          short = "#{config.api.url}/#{shortcode}"

          <tr key = {key}>
            <td>
              <a href = {short} target="_blank">{short}</a>
              <br />
              {url}
            </td>
            <td>
              {redirectCount}
            </td>
            <td>
              {
                if lastSeenDate then (Moment lastSeenDate).fromNow()
                else "Not visited yet."
              }
            </td>
          </tr>
      }
    <tbody>
    </tbody>
  </table>
