// Vercel serverless entry — built Express app (listens only when not on Vercel).
module.exports = require("../artifacts/api-server/dist/index.cjs");
