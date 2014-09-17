express = require 'express'
params = require 'express-params'

apiRouter = express.Router()
params.extend apiRouter

apiRouter.get '/', (req, res) ->
	res.send('goonjam JSON api')

module.exports = apiRouter
