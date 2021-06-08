// Script:  add_users.js
// Purpose: To import users and upload to firebase Auth service
// 
// Author: Jumail 
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 4 Jun 2021

const _auth = require('../api/models/firebase/firebase_admin').auth()

function Auth(uid, email, password, displayName) {
  return {
    uid, email, password, displayName,
    emailVerified: false,
    disabled: false
  }
}

// Add the list of user accounts below
const _userAuthList = [
  Auth('alex', 'alex@mockmail.com', 'abc123', 'Alexander Holmes'),
  Auth('jesssica', 'jessica@mockmail.com', 'abc123', 'Jessica Walters')
];

async function setupAuthentication(_req, res, _next) {
  for (const user of _userAuthList){
    await _auth.createUser(user)
  }
  res.send('Importing authentications.... Done ')
}

module.exports = setupAuthentication