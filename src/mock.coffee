async = require 'async'

exports.mockDb = (db) ->
  # db.sequelize.transaction (t) -> 
    async.parallel([
      (done) ->
        db.User.bulkCreate([{
          username: 'mitch'
          email: 'olordhux@gmail.com'
          website: 'www.mitchrobb.com'
        }, {
          username: 'mitch2'
          email: 'olordhux2@gmail.com'
          website: 'www.mitchrobb.com'
        }, {
          username: 'mitch3'
          email: 'olordhux3@gmail.com'
          website: 'www.mitchrobb.com'
        }]) 
        .success ->
          console.log 'created users'
          done() 
        .error (err) ->
          done(err)

      (done) ->    
        db.Project.create({
          title: 'my cool game'
          description: 'its a game'
        })
        .success ->
          console.log 'created project'
          done()
        .error (err) ->
          done(err)

      (done) ->
        db.Jam.create({
          title: 'goonjam'
          description: 'a great jam for friends'
        })
        .success ->
          console.log 'created jam'
          done()
        .error (err) ->
          done(err)
    ], (err) ->
      if err 
        return console.log 'ERROR --- ' + err
      console.log 'done creating'
    )