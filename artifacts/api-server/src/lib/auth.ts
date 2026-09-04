import { createHash } from "crypto";
import bcrypt from "bcryptjs";

const BCRYPT_ROUNDS = 10;

/** True for bcrypt hashes ($2a$ / $2b$ / $2y$). Legacy SHA-256 uses salt:hex. */
export function isBcryptHash(stored: string): boolean {
  return /^\$2[aby]\$/.test(stored);
}

export async function hashPassword(password: string): Promise<string> {
  return bcrypt.hash(password, BCRYPT_ROUNDS);
}

/** Verify password. Supports legacy salted SHA-256 (salt:hash) and bcrypt. */
export async function verifyPassword(
  password: string,
  stored: string,
): Promise<boolean> {
  if (!stored) return false;
  if (isBcryptHash(stored)) {
    return bcrypt.compare(password, stored);
  }
  // Legacy: salt:sha256hex
  const [salt, hash] = stored.split(":");
  if (!salt || !hash) return false;
  const computed = createHash("sha256").update(salt + password).digest("hex");
  return computed === hash;
}

/** Returns true if the stored hash is legacy SHA-256 and should be upgraded. */
export function needsRehash(stored: string): boolean {
  return Boolean(stored) && !isBcryptHash(stored);
}
