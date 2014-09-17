module.exports = (sequelize, DataTypes) ->
  User = sequelize.define('User', {
    username: DataTypes.STRING,
    email: DataTypes.STRING,
    sa_id: DataTypes.INTEGER,
    sa_username: DataTypes.STRING,
    twitch_username: DataTypes.STRING
  }, {
    classMethods:
      associate: (models) ->
        # User.hasMany(models.Vote)
        # User.hasMany(models.Project)
  })
