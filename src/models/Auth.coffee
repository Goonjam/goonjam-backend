module.exports = (sequelize, DataTypes) ->
  Auth = sequelize.define('Auth', {
    access_token: DataTypes.STRING
    refresh_token: DataTypes.STRING
    goonauth_username: DataTypes.STRING
  },

  {
    underscored: true
    classMethods:
      associate: (models) ->
        Auth.belongsTo(models.User)
  })
