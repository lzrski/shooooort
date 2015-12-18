store         = require './store'
Moment        = require 'moment'

store.subscribe ->
  { urls } = store.getState()
  console.log '==>'
  for url, index  in urls
    console.log index
    for own key, value of url
      console.log "#{key}: #{value}"

console.log store.getState()

# TODO: Move to test cases
store.dispatch type: 'shorten', url: 'http://lazurski.pl/'
store.dispatch type: 'shorten', url: 'http://lori2lori.rocks/'
