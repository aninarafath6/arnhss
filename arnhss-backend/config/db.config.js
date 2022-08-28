const mongoClient = require("mongodb").MongoClient;
const state = {
  db: null,
};
module.exports.connect = (done) => {
  const url =
    "mongodb+srv://myarnhss:Rw2EatxviCL1KMAZ@cluster0.cvoo5cf.mongodb.net/?retryWrites=true&w=majority";
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
