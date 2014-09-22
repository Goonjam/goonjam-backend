module.exports = (sequelize, DataTypes) ->
  Project = sequelize.define('Project', {
    title:
      type: DataTypes.STRING
      unique: true
      allowNull: false
    description:
      type: DataTypes.TEXT
      allowNull: false
    website:
      type: DataTypes.STRING
      allowNull: true
      validate:
        isUrl: true
  },
  {
    underscored: true
    classMethods:
      associate: (models) ->
        # Project.hasMany(models.Vote)
        Project.hasMany(models.User)
        Project.belongsTo(models.Jam)
  })
