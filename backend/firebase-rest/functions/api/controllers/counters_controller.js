// Author: Jumail 
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 5 Jun 2021

'use strict'

const Controller = require('./controller')
const counterModel = require('../models/counter_model')

const countersController = new Controller(counterModel)
module.exports = countersController.router