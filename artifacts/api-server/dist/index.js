// Wrapper for index.cjs (CommonJS) from ES module context
// This allows startCommand: node artifacts/api-server/dist/index.js to work
// even though package.json has "type": "module"
import('./index.cjs').catch(e => {
  console.error('Failed to start server:', e);
  process.exit(1);
});
