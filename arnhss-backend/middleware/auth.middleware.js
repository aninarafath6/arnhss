const { body, checkSchema } = require("express-validator");

exports.sendOtpValidation = [
  body("phone")
    .not()
    .isEmpty()
    .withMessage("Phone number is required")
    .isLength({ min: 10, max: 10 })
    .withMessage("invalid phone number"),
];

exports.verifyOtpValidation = [
  body("phone")
    .not()
    .isEmpty()
    .withMessage("Phone number is required")
    .isLength({ min: 10, max: 10 })
    .withMessage("invalid phone number"),

  body("otp")
    .not()
    .isEmpty()
    .withMessage("please provide otp")
    .isLength({ min: 6, max: 6 })
    .withMessage("invalid otp, otp must be 6 numbers"),
];

exports.createUserValidation = [
  body("user.phone")
    .not()
    .isEmpty()
    .withMessage("Phone number is required")
    .isLength({ min: 10, max: 10 })
    .withMessage("invalid phone number")
    .isNumeric()
    .withMessage("phone no must be numerical value"),
  body("user.email").isEmail().withMessage("invalid email address"),
  body("user.name").not().isEmpty().withMessage("name is required"),
];
