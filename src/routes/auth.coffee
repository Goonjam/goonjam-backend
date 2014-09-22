https = require 'https'
express = require 'express'
passport = require 'passport'
jwt  = require 'jwt-simple'
moment = require 'moment'

db = require '../models';

OAuth2Strategy = require('passport-oauth').OAuth2Strategy
jwtSecret = 'changeme'

passport.use('goonauth', new OAuth2Strategy({
    authorizationURL: 'https://goonauth.cattes.us/o/authorize/',
    tokenURL: 'https://goonauth.cattes.us/o/token/',
    clientID: 'dU3uSu;HNbGwcV1S@T?@u@oEiJkb-y!nf1hkRIOQ',
    clientSecret: 'wAlngI-0!z?=UZgqPRUClumL25f;L9bi!juzL9XHks11bMTXE.tv.GCwOx1hC10mbskE9k5PRgcQkElL@Xky?j0wrM6Pzgr-0d83hPcZ9VmzGxsWQNR-@z.B0C;E67:O'
    callbackURL: 'http://localhost:8000/authorize/cb',
    skipUserProfile: true,
    scope: 'read'
  },
  
  (accessToken, refreshToken, params, _, done) ->
    requestOptions = {
      hostname: 'goonauth.cattes.us',
      path: '/api/user/'
      headers:
        Authorization: 'Bearer ' + accessToken
    }

    userGoonauthProfile = ''
    req = https.request(requestOptions, (res) ->
      res.on 'data', (chunk) ->
        userGoonauthProfile += chunk
      res.on 'end', ->
        userGoonauthProfile = JSON.parse(userGoonauthProfile)

        profile =
          username: userGoonauthProfile.user.username
          email: 'tempfakeemail@whatever.com'
          sa_id: userGoonauthProfile.somethingawful.userid
          sa_username: userGoonauthProfile.somethingawful.username

        db.User.findOrCreate(profile)

          .success (user, wasCreated) ->
            # todo: ask to fill out profile on wascreated
            auth = db.Auth.create({
              access_token: accessToken
              refresh_token: refreshToken
              goonauth_username: userGoonauthProfile.user.username
              access_token_expires: moment()
                                      .add(params.expires_in - 20, 'seconds')
                                      .valueOf()
            })

            .success (auth) ->
              user.setAuth(auth)

              .success (associated) ->
                #todo: don't save user until here, in case there are errors
                done(null, user)

              .error (err) ->
                console.log 'error associating user with auth info', err
                #todo: clear user just created
                done(err)

          .error (err) ->
            console.log 'error creating user', err
            done(err)
    ).end()
))


authRouter = express.Router()

authRouter.get('/', passport.authenticate('goonauth'));
authRouter.get('/cb', passport.authenticate('goonauth', {
      session: false
      # successRedirect: '/api/v1/users'
      failureRedirect: '/bad' # todo
    }),
    (req, res, next) ->
      expires = moment().add(7, 'days').valueOf();
      token = jwt.encode({
        iss: req.user.values.id,
        exp: expires
      }, jwtSecret);

      res.json({
        token : token,
        expires: expires,
        user: req.user.toJSON()
      });
    )

module.exports = authRouter
