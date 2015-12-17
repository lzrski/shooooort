store         = require './store'

store.subscribe -> console.log store.getState()
console.log store.getState()

# TODO: Move to test cases
store.dispatch type: 'shorten', url: 'http://lazurski.pl/'
store.dispatch type: 'different' # State should be the same
