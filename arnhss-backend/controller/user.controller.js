const otp = require("../utils/otp.util");
const userAuth = require("../helpers/auth/user.auth.js");
const jwt = require("../utils/jwt.util");
const { validationResult } = require("express-validator");

module.exports = {
  sendOtp: async (req, res) => {
    console.log("-> send otp route");
    console.log(req.body);
    const errors = validationResult(req);
    // console.log(errors);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array(), status: false });
    }

    try {
      otp
        .sendOtp(req.body.phone, req.body.channel, req.body.countryCode)
        .then((response) => {
          console.log(response);
          res.json(response);
        })
        .catch((error) => {
          res.status(500).json(error);
          console.log(error);
        });
    } catch (error) {
      console.log("error");
      res.json(error);
    }
  },



  verifyOtp: async (req, res) => {
    console.log("-> verify otp route");
    const errors = validationResult(req);
    console.log(errors);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array(), status: false });
    }
    try {
      otp
        .verifyOtp(req.body.phone, req.body.otp)
        .then((response) => {
          userAuth
            .checkUser(req.body.phone)
            .then(async (data) => {
              // res.json(response);
              if (response.status) {
                if (data.status) {
                  const token = await jwt.generate({ id: data._id });
                  res.json({
                    status: true,
                    login: true,
                    toke: token,
                    valid: true,
                  });
                } else {
                  res.json({
                    status: false,
                    toke: null,
                    valid: true,
                  });
                }
              } else {
                res.json({
                  status: false,
                  toke: null,
                  valid: false,
                });
              }
            })
            .catch((error) => res.json(error));
        })
        .catch((error) => {
          res.json({ error: error, status: false, token: null });
        });
    } catch (error) {
      res.json(error);
    }
  },
  createUser: async (req, res) => {
    console.log("-> create user route");
    const errors = validationResult(req);
    console.log(errors);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array(), success: false });
    }
    try {
      // verify phone number is okay
      userAuth
        .createUser(req.body.user)
        .then(async (response) => {
          const token = await jwt.generate({ id: response._id });
          if (response.status) {
            res.json({
              status: true,
              login: true,
              toke: token,
            });
          } else {
            res.json({
              status: false,
              login: false,
              toke: null,
            });
          }
        })
        .catch((data) => {
          res.json(data);
        });
    } catch (error) {
      res.json(error);
    }
  },
};
