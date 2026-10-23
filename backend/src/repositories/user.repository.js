'use strict';

const { prisma } = require('./task.repository');

/**
 * Creates a user record.
 *
 * @param {{email: string, passwordHash: string}} data - Validated user data.
 * @returns {Promise<import('@prisma/client').User>} Created user.
 */
function create(data) {
  return prisma.user.create({ data });
}

/**
 * Finds a user by email.
 *
 * @param {string} email - User email address.
 * @returns {Promise<import('@prisma/client').User|null>} Matching user or null.
 */
function findByEmail(email) {
  return prisma.user.findUnique({ where: { email } });
}

module.exports = { create, findByEmail };
