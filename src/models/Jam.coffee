module.exports = (sequelize, DataTypes) ->
  sequelize.define('Jam', {
    title:
      type: DataTypes.STRING
      unique: true
      allowNull: false
    description:
      type: DataTypes.TEXT
      allowNull: false
    active:
      type: DataTypes.BOOLEAN
      defaultValue: false
    submissions_start:
      type: DataTypes.DATE
    submissions_end:
      type: DataTypes.DATE
    voting_start:
      type: DataTypes.DATE
    voting_end:
      type: DataTypes.DATE
    logo:
      type: DataTypes.STRING
      allowNull: true
      validate:
        isUrl: true
  },

  {
    underscored: true
  },

  {
    classMethods:
      associate: (models) ->
        Jam.hasMany(models.Project)
        Jam.hasMany(models.User, {as: 'Judges', through: 'user_judging'})
  })
