// Author: Jumail
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 4 Jun 2021

'use strict'

const database = require('./firebase/document')

// Here, we are implementing the class with Singleton design pattern

class CounterModel {
    constructor() {
        if (this.instance) return this.instance
        CounterModel.instance = this
        this.modelName = 'counters'
    }

    get() { return database.getList(this.modelName) }

    getById(id) { return database.get(this.modelName, id) }

    create(todo) { return database.create(this.modelName, todo) }

    delete(id) { return database.delete(this.modelName, id) }

    update(id, todo) { return database.set(this.modelName, id, todo) }
}

module.exports = new CounterModel()