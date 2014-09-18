express    = require 'express'
app        = express()
bodyParser = require 'body-parser'
db = require './models'
mock = require './mock'

app.set 'port', process.env.PORT or 8000

app.use bodyParser.urlencoded()
app.use bodyParser.json()

app.use '/api/v1', require('./routes/api')

 
db
  .sequelize
  .sync({force: true}) # { force: true } drops all tables first
  .complete (err) ->
    if (err)
      throw err[0]
    else
      app.listen app.get('port'), ->
        console.log 'Express server listening on port ' + app.get('port')
        mock.mockUser(db);

