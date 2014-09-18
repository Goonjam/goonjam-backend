fs        = require('fs')
path      = require('path')
Sequelize = require('sequelize')
_         = require('lodash')

sequelize = new Sequelize('vagrant_goonjam', 'vagrant', 'vagrant', {
  host: 'localhost'
  dialect: 'postgres'
})

db = {}
 
fs
  .readdirSync(__dirname)
  
  .filter (file) ->
    file[0] isnt '.' and file isnt 'index.js'

  .forEach (file) ->
    model = sequelize.import path.join(__dirname, file)
    db[model.name] = model
 
for own modelName of db
  db[modelName].associate(db) if 'associate' of db[modelName]

module.exports = _.extend({
  sequelize: sequelize,
  Sequelize: Sequelize
}, db)
