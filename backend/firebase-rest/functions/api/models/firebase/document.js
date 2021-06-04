// File:  document.js
// Purpose: Define a wrapper for document operations. It centeralizes generic CRUD operations.
// 
// Author: Jumail 
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 4 Jun 2021

'use strict'

const firebase = require('./firebase_admin');


// Here, we are implementing the class with Singleton design pattern
class Document {

    constructor() {

        if (this.instance) return this.instance

        Document.instance = this

        this.firestore = firebase.firestore()
    }

    // Define some helper methods for CRUD operations
    // Note that, each firestore function call is asynchronous.
    //  Thus, you want to use the 'await' keyword at the caller.

    async create(collectionName, documentData, documentId) {
        const result = (documentId !== undefined) ? await this.firestore.collection(collectionName).doc(documentId).set(documentData) :
            await this.firestore.collection(collectionName).add(documentData)
        // const result = await this.firestore.collection(collectionName).add(documentData)
        documentData.id = result.id
        return documentData
    }

    async getList(collectionName) {
        const result = await this.firestore.collection(collectionName).get()

        const list = []
        result.forEach((document) => {
            const data = document.data()
            data.id = document.id
            list.push(data)
        })
        return list.length ? list : null
    }

    async get(collectionName, documentId) {
        const result = await this.firestore.collection(collectionName).doc(documentId).get()
        if (!result.exists) return null  // Record not found

        const document = result.data()
        document.id = result.id
        return document
    }

    async set(collectionName, documentId, documentData) {
        const document = this.firestore.collection(collectionName).doc(documentId)
        const result = await document.get()

        if (!result.exists) return null  // Record not found

        await document.set(documentData)

        documentData.id = documentId
        return documentData
    }

    async delete(collectionName, documentId) {
        const document = this.firestore.collection(collectionName).doc(documentId)
        const result = await document.get()

        if (!result.exists) return null // Record not found

        await document.delete()

        return { id: documentId }
    }
}

module.exports = new Document()