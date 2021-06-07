// File: models/model.js
// Purpose: Base model class. - only for refactoring -
//          The class will be extended to the actual model classes, e.g. CounterModel and UserModel
// Author: Jumail
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 5 Jun 2021

'use strict'

const _firebase = require('./firebase/firebase_admin');

const _EMPTY_OBJECT = {}
const _EMPTY_LIST = []

class Model {

    constructor(collectionName) {

        this.firestore = _firebase.firestore()
        this.collectionName = collectionName
        this.collectionRef = this.firestore.collection(this.collectionName)
    }

    // Define some helper methods for CRUD operations
    // Note that, each firestore function call is asynchronous.
    //  Thus, you want to use the 'await' keyword at the caller.

    // Some helper methods to convert Firebase Ref to actual data they point

    _documentRefToData(documentRef) {

        if (!documentRef) return _EMPTY_OBJECT  // Record not found

        const document = documentRef.data()
        if (document == undefined) return _EMPTY_OBJECT

        document.id = documentRef.id
        return document
    }

    _documentRefListToList(documentRefList) {

        if (!documentRefList) return _EMPTY_LIST

        const list = []
        documentRefList.forEach(documentRef => list.push(this._documentRefToData(documentRef)))
        return list 
    }

    // Get all documents from the collection   
    async getDocumentList() {

        const documentRefList = await this.collectionRef.get()
        return this._documentRefListToList(documentRefList)
    }

    // Get a document given its id from the collection
    async getDocument(documentId) {
        if (!documentId) return _EMPTY_OBJECT

        const documentRef = await this.collectionRef.doc(documentId).get()
        return this._documentRefToData(documentRef)
    }

    // Find a document (the first matches) that satifies the search criterian by the 'fn' callback
    async findDocument(fn) {
        if (!fn) return _EMPTY_OBJECT

        const list = await this.getDocumentList()
        return list.find(fn)
    }

    // Find documents that satify the search criterian by the 'fn' callback
    async findDocumentList(fn) {
        if (!fn) return _EMPTY_LIST

        const list = await this.getDocumentList()
        return list.filter(fn)
    }

    // Find documents that satify the query filters
    // Idea 1. Search within the JavaScript list with find() method  
    //
    // async queryDocumentList(queryFilters) {
    // if (!queryFilters || Object.entries(queryFilters).length === 0) return this.getDocumentList()
    //     const list = await this.getDocumentList()
    //     const result = await list.filter(document => {
    //         for (let fieldName in queryFilters) {
    //             const fieldValue = queryFilters[fieldName]
    //             if (document[fieldName] !== fieldValue) return false
    //         }
    //         return true
    //     }
    //     )
    //     return result
    // }

    // Find documents that satify the query filters
    // Idea 2. Search within the JavaScript list with filter() method  
    //
    // async queryDocumentList(queryFilters) {
    // if (!queryFilters || Object.entries(queryFilters).length === 0) return this.getDocumentList()
    //     const documentList = await this.findDocumentList(
    //         document => {
    //             for (let fieldName in queryFilters){
    //                 let fieldValue = queryFilters[fieldName]
    //                 if (document[fieldName] !== fieldValue) return false
    //             }
    //             return true
    //       }
    //     )
    //     return documentList
    // }


    // Find documents that satify the query filters.
    // Idea 3. Search directly from the Firestore collection
    // 
    //  queryFilters is an object / hash. 
    //   e.g: {"username" : "alex", "age":20}

    async queryDocumentList(queryFilters) {

        // If there is no filter specified, get all documents
        if (!queryFilters || Object.entries(queryFilters).length === 0) return this.getDocumentList()

        // Initially, take all documents
        let queryRef = this.collectionRef
        let documentRefList = await queryRef.get()

        for (let fieldName in queryFilters) {
            const noMatch = documentRefList.empty
            if (noMatch) return _EMPTY_LIST

            const fieldValue = queryFilters[fieldName]
            queryRef = queryRef.where(fieldName, '==', fieldValue)
            // This is how to convert the following chained code to dynamic one 
            //    query.where().where().where()
            documentRefList = await queryRef.get()
        }
        return this._documentRefListToList(documentRefList)
    }

    // Create a new document into the collection
    async createDocument(documentData, documentId) {
        const documentRef = (documentId !== undefined) ? await this.collectionRef.doc(documentId).set(documentData) :
            await this.collectionRef.add(documentData)
        documentData.id = documentRef.id
        return documentData
    }

    // Update a document given its id
    async updateDocument(documentId, documentData) {
        const documentRef = this.collectionRef.doc(documentId)
        const existingDocumentRef = await documentRef.get()

        if (!existingDocumentRef.exists) return _EMPTY_OBJECT  // Record not found

        await documentRef.set(documentData)

        documentData.id = documentId
        return documentData
    }

    // Delete a document given its id
    async deleteDocument(documentId) {
        const documentRef = this.collectionRef.doc(documentId)
        const existingDocumentRef = await documentRef.get()

        if (!existingDocumentRef.exists) return _EMPTY_OBJECT // Record not found

        await documentRef.delete()

        return { id: documentId }
    }

}

module.exports = Model
