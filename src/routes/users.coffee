express = require 'express'
params = require 'express-params'
db = require '../models'

apiRouter = express.Router()
params.extend apiRouter
apiRouter.param('id', /^\d+$/) # IDs are digits only

# apiRouter.get '/', (req, res) ->
#   res.send('goonjam JSON api')

apiRouter.get '/', (req, res) ->
  if Object.keys(req.query).length is 0
    # no querystring
    db.User.findAll().success (users) ->
      res.status(200).json(users: users)
  else
    searchString = Object.keys(req.query).reduce((accum, item) ->
      if item of db.User.rawAttributes
        accum.where[item] = req.query[item];
      return accum;
    {where: {}})

    numValidQueryParams = Object.keys(searchString.where).length

    if numValidQueryParams isnt Object.keys(req.query).length
      res.status(400).end('invalid query parameter')

    else
      db.User.findAll(searchString).success (users) ->
        res.status(200).json(users: users)

apiRouter.get '/:id', (req, res) ->
  db.User.find(+req.params.id[0])
    .success (user) ->
      if user is null then return res.status(404).end()
      res.status(200).json(user: user)

apiRouter.put '/:id', (req, res) ->
  db.User.find(+req.params.id[0])
    .success (user) ->
      if user is null then return res.status(404).end()
      
      user.updateAttributes(req.body)
        .success ->
          res.status(200).json(user: user)
        # .error (err) ->
        #   res.status(400).end(err)
    # .error (err) ->
    #   res.end(404)


module.exports = apiRouter
