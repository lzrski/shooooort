React         = require 'react'
map           = require 'lodash.map'
Moment        = require 'moment'
config        = require './config'
{ dispatch }  = require '../store'
URL           = require 'url'

module.exports = (props) ->
  { urls } = props
  <div className = "url-list">
    <header>
      <h3>Previously shortened by you</h3>
      <button
        className = "reset"
        onClick   = { ->
          # TODO: Confirmation dialog?
          dispatch type: 'reset'
        }
      >
        Clear history
      </button>
    </header>

    <table>
      <thead>
        <tr>
          <th>Link</th>
          <th>Visits</th>
          <th>Last visited</th>
        </tr>
      </thead>
      <tbody>
        {
          map urls, (item, key) ->
            {
              url
              shortcode
              lastSeenDate
              redirectCount
            }     = item
            short = URL.resolve config.api.url, shortcode
            # TODO: Investigate https://zenorocha.github.io/clipboard.js/

            <tr key = {key}>
              <td>
                {
                  if shortcode?
                    <a
                      className = 'shortened'
                      href      = ''
                      data-clipboard-text = { short }
                    >
                      {config.api.url}<strong>{shortcode}</strong>
                      <label>click to copy this link</label>
                    </a>
                  else
                    <div className = "loading">Shortening</div>
                }
                <a
                  className = "original"
                  href      = { url }
                  target    = "_blank"
                >
                  { url }
                </a>
              </td>
              <td>
                {redirectCount}
              </td>
              <td>
                {
                  if lastSeenDate then (Moment lastSeenDate).fromNow()
                }
              </td>
            </tr>
        }
      </tbody>
    </table>
  </div>
