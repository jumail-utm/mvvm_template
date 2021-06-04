// Script:  add_users.js
// Purpose: To import users and upload to firebase Auth service
// 
// Author: Jumail 
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 4 Jun 2021

const db = require('../api/models/firebase/auth')

const userAuthList = [
  {
    uid: 'uid1',
    email: 'user1@example.com',
    passwordHash: Buffer.from('passwordHash1'),
    passwordSalt: Buffer.from('salt1'),
  },
  {
    uid: 'uid2',
    email: 'user2@example.com',
    passwordHash: Buffer.from('passwordHash2'),
    passwordSalt: Buffer.from('salt2'),
  },
  //...
];

admin
  .auth()
  .importUsers(userImportRecords, {
    hash: {
      algorithm: 'HMAC_SHA256',
      key: Buffer.from('secretKey'),
    },
  })
  .then((userImportResult) => {
    // The number of successful imports is determined via: userImportResult.successCount.
    // The number of failed imports is determined via: userImportResult.failureCount.
    // To get the error details.
    userImportResult.errors.forEach((indexedError) => {
      // The corresponding user that failed to upload.
      console.log(
        'Error ' + indexedError.index,
        ' failed to import: ',
        indexedError.error
      );
    });
  })
  .catch((error) => {
    // Some unrecoverable error occurred that prevented the operation from running.
  });

async function addUsers(_req, res, _next) {
    // To delete all the collections
    const collections = ['users', 'counters']
    collections.forEach(async (collection) => await deleteCollection(collection))

    // Add documents to the todos collection
    addDocuments(
        'users',
        [
            {
                "name": "Alexander Holmes",
                "photoUrl": "https://randomuser.me/api/portraits/thumb/men/75.jpg"
              },
              {
                "name": "Jessica Walters",
                "photoUrl": "https://randomuser.me/api/portraits/thumb/women/75.jpg"
              }
        ],

        'counters',
        [
            {
                "counter": 0,
                "user": 1
              },
              {
                "counter": 2,
                "id": 2,
                "user": 2
              }
        ]
    )

    res.send('Setting Up Database.... Done ')
}

async function deleteCollection(collection) {
    const cref = db.firestore.collection(collection)
    const docs = await cref.listDocuments()
    docs.forEach((doc) => doc.delete())
}

function addDocuments(collection, docs) {
    docs.forEach((doc) => db.create(collection, doc))
}

module.exports = addUsers