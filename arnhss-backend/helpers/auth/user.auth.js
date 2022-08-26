const db = require("../../config/db.config");
const collections = require("../../config/collections.config");
module.exports = {
  checkUser: check,
  createUser: (user) => {
    user.phone = parseInt(user.phone);
    return new Promise((resolve, reject) => {
      check(user.phone)
        .then((data) => {
          if (!data.status) {
            db.get()
              .collection(collections.USER_COLLECTION)
              .insertOne(user)
              .then((data) => {
                resolve({ status: true, id: data.insertedId });
              });
          } else {
            reject({
              status: false,
              statusCode: 400,
              error: "user already exists",
            });
          }
        })
        .catch((error) => {
          reject({
            status: false,
            statusCode: 400,
            error: error,
          });
        });
    });
  },
};

function check(phone) {
  return new Promise((resolve, reject) => {
    db.get()
      .collection(collections.USER_COLLECTION)
      .findOne({ phone: phone })
      .then((data) => {
        if (data) {
          resolve({ status: true, user: data, statusCode: 200 });
        } else {
          resolve({
            status: false,
            user: null,
            statusCode: 200,
          });
        }
      })
      .catch((error) => {
        reject({ status: false, error: error, statusCode: 500, user: null });
      });
  });
}
