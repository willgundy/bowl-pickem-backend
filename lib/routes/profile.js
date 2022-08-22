const { Router } = require('express');
const Profile = require('../models/Profile');
const authorizeItem = require('../middleware/authorize');

module.exports = Router()
  .post('/', async ({ body, user }, res, next) => {
    try {
      const profile = await Profile.insert({ ...body, user_id: user.id });
      res.json(profile);
    } catch (e) {
      next(e);
    }
  })
  
  .get('/', async ({ user }, res, next) => {
    try {
      const profile = await Profile.getByUserId(user.id);
      res.json(profile);
    } catch (e) {
      next(e);
    }
  })
  
  .put('/:id', authorizeItem, async (req, res, next) => {
    try {
      const profile = await Profile.updateProfileByUserId(req.user.id, req.body);
      res.json(profile);
    } catch (e) {
      next(e);
    }
  })

  .delete('/:id', authorizeItem, async (req, res, next) => {
    try {
      const profile = await Profile.delete(req.params.id);
      res.json(profile);
    } catch (e) {
      next(e);
    }
  });
