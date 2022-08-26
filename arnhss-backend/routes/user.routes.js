const express = require("express");
const router = express.Router();
const userController = require("../controller/user.controller");
const authVerify = require("../middleware/auth.middleware");

router.post("/send-otp", authVerify.sendOtpValidation, userController.sendOtp);
router.post(
  "/verify-otp",
  authVerify.verifyOtpValidation,
  userController.verifyOtp
);
router.post(
  "/create-user",
  authVerify.createUserValidation,
  userController.createUser
);

// router.post("/login", (req, res) => userController.login(req, res));

module.exports = router;
