# For react to work on legacy stuff
require 'es5-shim'
require 'es5-shim/es5-sham'
require 'html5shiv'
require 'setimmediate'
require('es6-promise').polyfill()
require 'whatwg-fetch'
require './define-setter-and-getter'
require './string-trim-left-and-right'
