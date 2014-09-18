exports.mockUser = (db) ->
  db.User.bulkCreate [{
    username: 'mitch'
    email: 'olordhux@gmail.com'
    website: 'www.mitchrobb.com'
  },
  {
    username: 'mitch2'
    email: 'olordhux2@gmail.com'
    website: 'www.mitchrobb.com'
  },
  {
    username: 'mitch3'
    email: 'olordhux3@gmail.com'
    website: 'www.mitchrobb.com'
  }]

    
  .success (user) -> 
    console.log 'created user'
    db.User.findAll().success (users) ->
      console.log users.length
  .error (err) ->
    console.log err