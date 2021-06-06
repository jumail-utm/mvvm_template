// Author: Jumail
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 5 Jun 2021

'use strict'

const Model = require('./model')

// Here, we are implementing the class with Singleton design pattern

class UserModel extends Model {
    constructor() {
        super('users')
        if (this.instance) return this.instance
        UserModel.instance = this
    }
}

module.exports = new UserModel()