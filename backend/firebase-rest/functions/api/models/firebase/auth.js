// File:  auth.js
// Purpose: Define a wrapper for authentication service.
// 
// Author: Jumail 
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 4 Jun 2021

'use strict'

const firebase = require('./firebase_admin');


// Here, we are implementing the class with Singleton design pattern
class Auth {

    constructor() {

        if (this.instance) return this.instance 

        Auth.instance = this

        this.auth = firebase.auth()
    }

    // async addUser(credential) {
    //     const result = await this.auth
    // }

    // async signIn(credential) {
    //     const result = await this.auth
    // }

    // async signOut(credential) {
    //     const result = await this.auth
    // }
}

module.exports = new Auth()