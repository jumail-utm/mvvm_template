// Script:  setup_database.js
// Purpose: An helper tool to upload stock data to firestore
// 
// Author: Jumail 
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 4 Jun 2021

const document = require('../api/models/firebase/document')

async function setupDatabase(_req, res, _next) {
  // Uncomment the following if you want to delete the existing data

  // const collectionNames = ['users', 'counters']

  // collectionNames.forEach(async (collectionName)=>{
  //   const collection = document.firestore.collection(collectionName)
  //   const documents = await collection.listDocuments()
  //   documents.forEach((document) => document.delete())
  // })


  // Add collections and their documents to the database 
  // Setup the data first manually
  // To use your own name for the document, specify the id 
  // property (The id must be of type string).  Otherwise, 
  // the document name will be auto-generated

  const collectionsJson = {
    "users": [
      {
        "id": "user1",
        "name": "Alexander Holmes",
        "photoUrl": "https://randomuser.me/api/portraits/thumb/men/75.jpg",
        "login": "alex",
        "password": "123"
      },
      {
        "id": "user2",
        "name": "Jessica Walters",
        "photoUrl": "https://randomuser.me/api/portraits/thumb/women/75.jpg",
        "login": "jessica",
        "password": "123"
      }
    ],
    "counters": [
      {
        "id": "counter1",
        "counter": 0,
        "user": "user1"
      },
      {
        "id": "counter2",
        "counter": 0,
        "user": "user2"
      }
    ]
  }

  // Start adding the data to the database
  for (let collectionName in collectionsJson) {
    const collectionData = collectionsJson[collectionName]
    collectionData.forEach(async (documentData) => {
      const documentId = documentData.id
      if (documentId) {

        // id will not be included in the database. it is used only to name the document
        delete documentData.id

        document.create(collectionName, documentData, documentId)
      }
      else document.create(collectionName, documentData)
    })
  }

  // To inform that the uploading process has completed
  res.send('Setting Up Database.... Done ')
}

module.exports = setupDatabase