var jwt = require("jsonwebtoken");
require("dotenv").config();

module.exports = {
  generate: (data) => {
    return new Promise((resolve, reject) => {
      const token = jwt.sign(data, process.env.JWT_SECRET, {
        expiresIn: 50000000,
      });
      resolve(token);
    });
  },
};
