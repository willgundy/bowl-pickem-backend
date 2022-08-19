const pool = require('../utils/pool');

module.exports = class Profile {
  id;
  user_id;
  first_name;
  last_name;
  avatar;
  user_name;
  primary_color;
  secondary_color;
  created_at;

  constructor(row) {
    this.id = row.id;
    this.user_id = row.user_id;
    this.first_name = row.first_name;
    this.last_name = row.last_name;
    this.avatar = row.avatar;
    this.user_name = row.user_name;
    this.primary_color = row.primary_color;
    this.secondary_color = row.secondary_color;
    this.created_at = row.created_at;
  }

  static async insert({ user_id, first_name, last_name, avatar, user_name, primary_color, secondary_color }) {
    const { rows } = await pool.query(
      `
      INSERT INTO profiles (user_id, first_name, last_name, avatar, user_name, primary_color, secondary_color)
      VALUES ($1, $2, $3, $4, $5, $6, $7)
      RETURNING *;
    `,
      [user_id, first_name, last_name, avatar, user_name, primary_color, secondary_color]
    );

    return new Profile(rows[0]);
  }

  static async updateProfileByUserId(user_id, attrs) {
    const profile = await Profile.getProfileByUserId(user_id);
    if (!profile) return null;
    const { first_name, last_name, avatar, user_name, primary_color, secondary_color } = { ...profile, ...attrs };
    const { rows } = await pool.query(
      `
      UPDATE profiles 
      SET    first_name=$2, last_name=$3, avatar=$4, user_name=$5, primary_color=$6, secondary_color=$7
      WHERE  user_id=$1
      RETURNING *;
    `,
      [user_id, first_name, last_name, avatar, user_name, primary_color, secondary_color]
    );
    return new Profile(rows[0]);
  }

  static async getByUserId(user_id) {
    const { rows } = await pool.query(
      `
      SELECT *
      FROM   profiles
      WHERE  id=$1
    `,
      [user_id]
    );

    if (!rows[0]) {
      return null;
    }
    return new Profile(rows[0]);
  }

  static async delete(id) {
    const { rows } = await pool.query(
      `
      DELETE FROM profiles 
      WHERE id = $1 
      RETURNING *
    `,
      [id]
    );
    return new Profile(rows[0]);
  }
};

