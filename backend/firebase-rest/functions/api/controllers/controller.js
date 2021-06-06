// File: controllers/controller.js
// Purpose: Base file. Only for refactoring reason.
// 
// Author: Jumail 
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 4 Jun 2021

'use strict'
const express = require('express')

class Controller {
    constructor(model) {
        this.model = model
        this.router = express.Router()

        // Get all Counter documents
        this.router.get('/', async (req, res, next) => {
            try {
                const result = await this.model.queryDocumentList(req.query)
                return res.json(result)
            }
            catch (e) {
                return next(e)
            }
        })

        // Get one Counter document
        this.router.get('/:id', async (req, res, next) => {
            try {
                const result = await this.model.getDocument(req.params.id)
                if (!result) return res.sendStatus(404)
                return res.json(result)
            }
            catch (e) {
                return next(e)
            }
        })

        // Create / add a new Counter document
        this.router.post('/', async (req, res, next) => {
            try {
                const result = await this.model.createDocument(req.body)
                if (!result) return res.sendStatus(409)
                return res.status(201).json(result)
            }
            catch (e) {
                return next(e)
            }
        })

        // Delete a counter
        this.router.delete('/:id', async (req, res, next) => {
            try {
                const result = await this.model.deleteDocument(req.params.id)
                if (!result) return res.sendStatus(404)
                return res.sendStatus(200)
            }
            catch (e) {
                return next(e)
            }
        })

        // Update a counter
        this.router.patch('/:id', async (req, res, next) => {
            try {
                const id = req.params.id
                const data = req.body

                const doc = await this.model.getDocument(id)
                if (!doc) return res.sendStatus(404)

                // Merge existing fields with the ones to be updated
                Object.keys(data).forEach((key) => doc[key] = data[key])

                const updateResult = await this.model.updateDocument(id, doc)
                if (!updateResult) return res.sendStatus(404)

                return res.json(doc)
            }
            catch (e) {
                return next(e)
            }
        })

        // Replace a counter
        this.router.put('/:id', async (req, res, next) => {
            try {
                const updateResult = await this.model.updateDocument(req.params.id, req.body)
                if (!updateResult) return res.sendStatus(404)

                const result = await this.model.getDocument(req.params.id)
                return res.json(result)

            }
            catch (e) {
                return next(e)
            }
        })
    }
}

module.exports = Controller
