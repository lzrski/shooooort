# TODO: Make proper test cases. This code is not being used ATM.

store.subscribe ->
  { urls } = store.getState()
  console.log '==>'
  for url, index  in urls
    console.log index
    for own key, value of url
      console.log "#{key}: #{value}"

console.log store.getState()

store.dispatch type: 'shorten', url: 'http://lori2lori.rocks/'
store.dispatch type: 'shorten', url: 'http://lazurski.pl/'
