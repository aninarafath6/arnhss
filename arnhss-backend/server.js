const express = require("express");
const path = require("path");
const cors = require("cors");
const app = express();
const userRoute = require("./routes/user.routes");
var db = require("./config/db.config");

// middleware
app.use(express.json());
// app.use(cors());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "public")));

db.connect((err) => {
  if (err) throw err;
  console.log("connected to database");
});

app.use("/api/auth", userRoute);

const PORT = process.env.PORT || 1080;
app.listen(PORT, () => console.log(`SERVER RUNNING ON PORT ${PORT}`));
