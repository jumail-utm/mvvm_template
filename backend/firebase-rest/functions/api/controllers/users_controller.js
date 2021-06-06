// Author: Jumail 
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 5 Jun 2021

'use strict'

const Controller = require('./controller')
const userModel = require('../models/user_model')

const usersController = new Controller(userModel)
module.exports = usersController.router