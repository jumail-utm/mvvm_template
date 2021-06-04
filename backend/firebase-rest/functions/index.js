// Author: Jumail 
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 4 Jun 2021

'use strict'
const functions = require("firebase-functions")
const express = require("express")
const app = express();
const counterRouter = require('./api/controllers/counter_controller')

// app.use(json())
// app.use('/todos', counterRouter)

// export const api = https.onRequest(app)

// export const functionsTimeOut = runWith({
//     timeoutSeconds: 300
// })

exports.setupdb = functions.https.onRequest(require('./tools/setup_database'))
// exports.hello = functions.https.onRequest( (_req,res)=>res.json({m:'Hello World'}))
