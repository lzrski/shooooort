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
          <th className = "link">Link</th>
          <th className = "visits">Visits</th>
          <th className = "last-visited">Last visited</th>
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
              <td className = "link">
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
                      <label>Click to copy this link</label>
                      <div className = 'shortened'>
                        {config.api.url}
                        <strong>{shortcode}</strong>
                      </div>
                      <div className = "original">{ url }</div>
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
              <td  className = 'visits' data-label = 'Visits'>
                {redirectCount}
              </td>
              <td className = 'last-visited' data-label = 'Last visit'>
                {
                  if lastSeenDate then (Moment lastSeenDate).fromNow()
                }
              </td>
            </tr>
        }
      </tbody>
    </table>
  </div>
