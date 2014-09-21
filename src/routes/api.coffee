express = require 'express'
params = require 'express-params'
db = require '../models'

passport = require 'passport' 
# auth = require '../auth'

apiRouter = express.Router()
params.extend apiRouter

# apiRouter.get '/', (req, res) ->
#   res.send('goonjam JSON api')



apiRouter.get '/', (req, res) ->
  searchString = Object.keys(req.query).reduce((accum, item) ->
    if item of db.User.rawAttributes
      accum.where[item] = req.query[item];
    return accum;
  , {where: {}})

  numValidQueryParams = Object.keys(searchString.where).length

  if numValidQueryParams isnt Object.keys(req.query).length
    res.status(400).end('invalid query parameter');

  else if numValidQueryParams is 0
    db.User.findAll().success (users) ->
      res.status(200).json(users: users)
  else
    db.User.findAll(searchString).success (users) ->
      res.status(200).json(users: users)

.param('id', /^\d+$/) # IDs are digits only

apiRouter.get '/:id', (req, res) ->
  db.User.find(+req.params.id[0])
    .success (user) ->
      res.status(200).json(user: user)

module.exports = apiRouter
