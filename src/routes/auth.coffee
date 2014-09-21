express = require 'express'
passport = require 'passport'

OAuth2Strategy = require('passport-oauth').OAuth2Strategy
process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0';

passport.use('goonauth', new OAuth2Strategy({
    authorizationURL: 'https://goonauth.cattes.us/o/authorize/',
    tokenURL: 'https://goonauth.cattes.us/o/token/',
    clientID: 'dU3uSu;HNbGwcV1S@T?@u@oEiJkb-y!nf1hkRIOQ',
    clientSecret: 'wAlngI-0!z?=UZgqPRUClumL25f;L9bi!juzL9XHks11bMTXE.tv.GCwOx1hC10mbskE9k5PRgcQkElL@Xky?j0wrM6Pzgr-0d83hPcZ9VmzGxsWQNR-@z.B0C;E67:O'
    callbackURL: 'http://localhost:8000/authorize'
  },
  
  (accessToken, refreshToken, profile, done) -> 
    console.log accessToken
    console.log refreshToken
    console.log profile
    done(null, {})

    # User.findOrCreate(..., function(err, user) {
    #   done(err, user);
    # });
))


authRouter = express.Router()

authRouter.get('/',
  passport.authenticate('goonauth', {
    session: false, 
    successRedirect: '/api/v1/users',
    failureRedirect: '/' }));

# authRouter.get('/login', passport.authenticate('goonauth'))

module.exports = authRouter
