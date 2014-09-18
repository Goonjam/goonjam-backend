express = require 'express'
params = require 'express-params'
db = require '../models'

apiRouter = express.Router()
params.extend apiRouter

apiRouter.get '/', (req, res) ->
  res.send('goonjam JSON api')

apiRouter.get '/users', (req, res) ->
  db.User.findAll().success (users) ->
    res.set('Content-Type', 'application/json')
    .status(200)
    .json users: users.map (user) ->
      return user.selectedValues


module.exports = apiRouter
