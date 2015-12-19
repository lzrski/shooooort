gulp        = require 'gulp'
coffee      = require 'gulp-cjsx'
browserify  = require 'browserify'
reactify    = require 'coffee-reactify'
watchify    = require 'watchify'
uglify      = require 'gulp-uglify'
source      = require 'vinyl-source-stream'
buffer      = require 'vinyl-buffer'
webserver   = require 'gulp-webserver'
del         = require 'del'
sourcemaps  = require 'gulp-sourcemaps'
{Readable}  = require 'stream'
{fork}      = require 'child_process'
_           = require 'lodash'
cache       = require 'gulp-cached'
stylus      = require 'gulp-stylus'
autoprefixer= require 'gulp-autoprefixer'
exorcist    = require 'exorcist'
mocha       = require 'gulp-mocha'

config = ->
  # Returns a readable stream with config code
  # It can be used both in frontend and backend code (via write-config task)
  # NOTE: In this project there is no backend.

  { NODE_ENV } = process.env

  object =
    port  : 8010  # This is for the backend
    api   :
      # Set API url depending on NODE_ENV
      url     : switch NODE_ENV
        when 'development'
          # Use local reverse proxy server. See docker-copose.yml.
          'http://localhost:8080/'
        when 'staging'
          # Use public reverse proxy server.
          'http://shooooort.lazurski.pl/'
        else
          # This will only work if app is served from the same domain (CORS)
          # Otherwise make sure to set NODE_ENV to staging
          'http://gymia-shorty.herokuapp.com/'

  stream = new Readable
  stream._read = ->
    # https://nodejs.org/api/stream.html#stream_readable_read_size_1
    # http://stackoverflow.com/a/22085851/1151982
  stream.push "module.exports = #{JSON.stringify object}"
  stream.push null

  return stream

gulp.task 'write-config', ->
  config()
    .pipe source 'config.js'
    .pipe gulp.dest './build/'

gulp.task 'test', ->
  gulp
    .src 'test/index.coffee'
    .pipe mocha reporter: 'spec'

bundler = watchify browserify Object.assign {}, watchify.args,
  entries   : './scripts/index.coffee'
  debug     : true
  transform : reactify
  extensions: ['.coffee', '.cjsx', '.jsx']

bundler.on 'log', console.log

gulp.task 'frontend', ->
  { NODE_ENV } = process.env

  # One can require a stream into browserify bundle. Here is how:
  # Exclude before require, otherwise bundle will throw
  bundler.exclude './config'
  bundler.require do config,
    expose  : './config'
    file    : 'config.coffee'
    basedir : process.cwd() + '/scripts/'

  bundler
    .bundle()
    .on 'error', (error) ->
      throw error
    .pipe source 'bundle.js'
    .pipe buffer()
    .pipe sourcemaps.init loadMaps: yes
    .pipe uglify()
    .pipe sourcemaps.write '.'
    .pipe gulp.dest './build/frontend/'

# Backend is mostly the same as frontend, but it just get's compiled from cjsx.
gulp.task 'backend', ->
  gulp
    .src 'scripts/**/*.coffee'
    .pipe cache 'backend'
    .pipe sourcemaps.init()
    .pipe do coffee
    .pipe sourcemaps.write './'
    .pipe gulp.dest './build/'

gulp.task 'style', ->
  gulp
    .src './style/index.styl'
    .pipe stylus()
  	.pipe autoprefixer
    	browsers : [ '> 5%', 'last 5 versions' ]
    	cascade  : false
    .pipe gulp.dest './build/frontend'

gulp.task 'assets', ->
  gulp
    .src './assets/**/*'
    .pipe gulp.dest './build/frontend/'

gulp.task 'clean', ->
  del './build/**/*'

gulp.task 'serve', (done) ->
  gulp
    .src './build/frontend'
    .pipe webserver
      host      : '0.0.0.0'
      livereload: yes
      open      : 'http://localhost:8000'
      fallback  : '/index.html'

gulp.task 'build', gulp.series [
  'clean'
  gulp.parallel [
    'assets'
    'frontend'
    # NOTE: There is no backend in this project, so write-config is obsolate
    # 'backend'
    # 'write-config'
    'style'
  ]
  'test'
]

# FIX: Make sure gulp exits when everything is done.
gulp.task 'prepublish', gulp.series [
  'build'
  (done) ->
    setTimeout process.exit, 100
    do done
]

gulp.task 'watch', (done) ->
  gulp.watch ['./scripts/**/*'],  gulp.series [
    gulp.parallel [
      # 'backend'
      'frontend'
    ]
    'test'
  ]
  gulp.watch ['./assets/**/*'],   gulp.series   ['assets']
  gulp.watch ['./style/**/*'],    gulp.series   ['style']
  gulp.watch ['./test/**/*'],     gulp.series   ['test']

  # It is never done :)

gulp.task 'develop', gulp.series [
  (done) ->
    process.env.NODE_ENV ?= 'development'
    do done
  'build'
  'serve'
  'watch'
]
