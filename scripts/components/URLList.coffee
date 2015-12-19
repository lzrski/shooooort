React         = require 'react'
map           = require 'lodash.map'
Moment        = require 'moment'
config        = require './config'
{ dispatch }  = require '../store'
URL           = require 'url'
{ truncate }  = require 'underscore.string'

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

            <tr key = {key}>
              <td>
                {
                  if shortcode?
                    short = URL.resolve config.api.url, shortcode

                    ###

                    Clipboard magic works thanks to https://zenorocha.github.io/clipboard.js/
                    See also render callback in index module, where the clipboard is setup.

                    ###
                    <a
                      className = "url"
                      href      = { short }
                      data-clipboard-text = { short }
                      onClick   = { (event) -> do event.preventDefault }
                    >
                      <label>click to copy this link</label>
                      <div className = 'shortened'>
                        {config.api.url}
                        <strong>{shortcode}</strong>
                      </div>
                      <div className = "original">{ truncate url, 48 }</div>
                    </a>
                  else
                    <div className = "loading">Shortening</div>
                }
                <a

                  href      = { url }
                  target    = "_blank"
                >
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
