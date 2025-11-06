// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************

// Custom login command
Cypress.Commands.add('login', (email, password) => {
  cy.visit('/login');
  cy.get('input[type="email"]').type(email);
  cy.get('input[type="password"]').type(password);
  cy.get('button[type="submit"]').click();
  cy.url().should('eq', Cypress.config().baseUrl + '/');
});

// Login as admin
Cypress.Commands.add('loginAsAdmin', () => {
  cy.login('admin@blog.com', 'password123');
});

// Login as user
Cypress.Commands.add('loginAsUser', () => {
  cy.login('john@blog.com', 'password123');
});

// Logout command
Cypress.Commands.add('logout', () => {
  cy.contains('button', 'Logout').click();
  cy.url().should('include', '/login');
});

// Clear database (via API)
Cypress.Commands.add('resetDatabase', () => {
  // Bu komut backend'de bir endpoint olursa kullanılabilir
  cy.log('Database reset - implement if needed');
});

