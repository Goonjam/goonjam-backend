express    = require 'express'
app        = express()
bodyParser = require 'body-parser'
Sequelize  = require 'sequelize'

# sequelize = new Sequelize('vagrant_goonjam', 'vagrant', 'vagrant', {
#   host: 'localhost'
#   dialect: 'postgres'
# })

port = process.env.PORT or 8000

app.use bodyParser.urlencoded()
app.use bodyParser.json()

app.use '/api/v1', require('./routes/api')

app.listen(port)
console.log "Server running on #{port}"
