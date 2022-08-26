const mongoClient = require("mongodb").MongoClient;
const state = {
  db: null,
};
module.exports.connect = (done) => {
  const url =
    "mongodb+srv://arnhss:rWwic2J417syd83l@cluster0.nrpdda3.mongodb.net/?retryWrites=true&w=majority";
  const dbname = "marketfeed";
  mongoClient.connect(url, { useUnifiedTopology: true }, (err, data) => {
    if (err) return done(err);
    state.db = data.db(dbname);
    done();
  });
};
module.exports.get = () => {
  return state.db;
};
