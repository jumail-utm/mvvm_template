// File:  firebase_admin.js
// Purpose: Define a singletion wrapper class to initialize Firebase Admin SDK
// 
// Author: Jumail 
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 4 Jun 2021

'use strict'


// Here, we are implementing the class with Singleton design pattern
//  Singleton is a design pattern where we create only a single instance (or object) from a class

class FirebaseAdmin {

    constructor() {

        if (this.instance) return this.instance  // This is the key idea of implementing singleton. Return the same instance (i.e. the one that has already been created before)

        // We only proceedd to the following lines only if no instance has been created from this class
        FirebaseAdmin.instance = this

        this.admin = require('firebase-admin')  // To access Firebase 

        // Since the functions and firestore run on the same server,
        //  we can simply use default credential.
        // However, if your app run different location, you need to create a JSON Firebase credentials

        this.admin.initializeApp({
            credential: this.admin.credential.applicationDefault()
        })
    }

    firestore() {
        return this.admin.firestore()
    }

    auth() {
        return this.admin.auth()
    }
}

module.exports = new FirebaseAdmin()