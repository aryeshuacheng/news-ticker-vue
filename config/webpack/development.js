process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

const crypto = require("crypto");
const crypto_orig_createHash = crypto.createHash;
crypto.createHash = algorithm => crypto_orig_createHash(algorithm == "md4" ? "sha256" : algorithm);

module.exports = environment.toWebpackConfig()
