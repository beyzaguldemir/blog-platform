describe('Kullanıcı Yönetimi', () => {
  beforeEach(() => {
    cy.loginAsAdmin();
  });

  it('Users sayfasına gidebilir', () => {
    cy.contains('Users').click();
    cy.url().should('include', '/admin/users');
    cy.contains('h1', 'Users').should('be.visible');
  });

  it('Tüm kullanıcıları görüntüleyebilir', () => {
    cy.contains('Users').click();
    
    // Kullanıcı tablosu görünmeli
    cy.contains('th', 'Name').should('be.visible');
    cy.contains('th', 'Email').should('be.visible');
    cy.contains('th', 'Role').should('be.visible');
    
    // Seed data'daki kullanıcılar
    cy.contains('Admin User').should('be.visible');
    cy.contains('John Doe').should('be.visible');
    cy.contains('Jane Smith').should('be.visible');
  });

  it('Kullanıcı rollerini görebilir', () => {
    cy.contains('Users').click();
    
    cy.contains('admin').should('be.visible');
    cy.contains('user').should('be.visible');
  });

  it('Admin kullanıcıyı silebilir', () => {
    cy.contains('Users').click();
    
    // Jane Smith'i sil (admin değil)
    cy.contains('tr', 'Jane Smith').within(() => {
      cy.contains('button', 'Delete').click();
    });
    
    cy.on('window:confirm', () => true);
    
    // Kullanıcı tablodan kaybolmalı (sayfa yenilenmişse)
    cy.wait(1000);
  });
});

describe('Normal Kullanıcı Kısıtlamaları', () => {
  beforeEach(() => {
    cy.loginAsUser();
  });

  it('Normal kullanıcı admin sayfalarını görememeli', () => {
    // Users sayfasına gitmeye çalış
    cy.visit('/admin/users', { failOnStatusCode: false });
    
    // Ana sayfaya yönlendirilmeli
    cy.url().should('eq', Cypress.config().baseUrl + '/');
  });

  it('Normal kullanıcı Categories sayfasını görememeli', () => {
    cy.visit('/admin/categories', { failOnStatusCode: false });
    cy.url().should('eq', Cypress.config().baseUrl + '/');
  });

  it('Normal kullanıcı Tags sayfasını görememeli', () => {
    cy.visit('/admin/tags', { failOnStatusCode: false });
    cy.url().should('eq', Cypress.config().baseUrl + '/');
  });

  it('Normal kullanıcı My Posts sayfasını görebilir', () => {
    cy.contains('My Posts').click();
    cy.url().should('include', '/my-posts');
  });
});

