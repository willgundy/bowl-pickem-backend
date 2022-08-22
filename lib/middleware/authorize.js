const Profile = require('../models/Profile');

module.exports = async (req, res, next) => {
  try {
    const item = await Profile.getById(req.params.id);
    if (!item || item.user_id !== req.user.id) {
      throw new Error('You do not have access to view this page');
    }
    next();
  } catch (e) {
    e.status = 403;
    next(e);
  }
};

// Compare this snippet from lib/routes/items.js

