String.prototype.trimLeft ?= ->
  re = /^[\s\uFEFF\xA0]+/
  @replace re, ''

String.prototype.trimRight ?= ->
  re = /[\s\uFEFF\xA0]+$/
  @replace re, ''
