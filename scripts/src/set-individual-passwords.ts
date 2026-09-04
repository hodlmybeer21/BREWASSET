/**
 * Password bootstrap script — DISABLED for security.
 *
 * This script previously committed and printed default plaintext passwords.
 * Do not restore plaintext credential maps to the repository.
 *
 * To set or rotate passwords safely:
 * 1. Use an admin flow / secure one-off script that reads passwords from
 *    environment variables or a local file that is gitignored (never commit it).
 * 2. Hash with bcryptjs (see artifacts/api-server/src/lib/auth.ts).
 * 3. Login will verify-and-rehash any remaining legacy SHA-256 hashes.
 */
console.error(
  "[set-individual-passwords] Disabled: refusing to set or print default plaintext passwords.\n" +
    "Set passwords via a secure out-of-band process using bcrypt hashes.",
);
process.exit(1);
