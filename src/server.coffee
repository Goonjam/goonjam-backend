express    = require 'express'
app        = express()
bodyParser = require 'body-parser'
passport = require 'passport'
db = require './models'
mock = require './mock'

app.set 'port', process.env.PORT or 8000
process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0'; # fixme

app.use bodyParser.urlencoded()
app.use bodyParser.json()
app.use(passport.initialize());

app.use '/api/v1/users', require('./routes/users')
app.use  '/authorize', require('./routes/auth')
 
db
  .sequelize
  .sync({force: true}) # { force: true } drops all tables first
  .complete (err) ->
    if (err)
      throw err[0]
    else
      app.listen app.get('port'), ->
        console.log 'Express server listening on port ' + app.get('port')
        mock.mockDb(db);

