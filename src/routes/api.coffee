express = require 'express'
params = require 'express-params'

apiRouter = express.Router()
params.extend apiRouter

apiRouter.get '/', (req, res) ->
  res.send('goonjam JSON api')

apiRouter.get '/users', (req, res) ->

module.exports = apiRouter
