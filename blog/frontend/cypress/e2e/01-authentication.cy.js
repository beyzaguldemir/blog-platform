describe('Kullanıcı Kimlik Doğrulama', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('Ana sayfa yüklenir', () => {
    cy.url().should('include', '/');
    cy.contains('Welcome to Our Blog').should('be.visible');
  });

  it('Giriş sayfasına gidebilir', () => {
    cy.contains('Login').click();
    cy.url().should('include', '/login');
    cy.contains('Welcome Back').should('be.visible');
  });

  it('Admin olarak başarılı giriş yapabilir', () => {
    cy.visit('/login');
    cy.get('input[type="email"]').type('admin@blog.com');
    cy.get('input[type="password"]').type('password123');
    cy.get('button[type="submit"]').click();
    
    // Başarılı giriş sonrası ana sayfaya yönlendirilir
    cy.url().should('eq', Cypress.config().baseUrl + '/');
    cy.contains('Welcome, Admin User').should('be.visible');
    
    // Admin menü öğeleri görünür olmalı
    cy.contains('Posts').should('be.visible');
    cy.contains('Categories').should('be.visible');
    cy.contains('Tags').should('be.visible');
    cy.contains('Users').should('be.visible');
  });

  it('Normal kullanıcı olarak başarılı giriş yapabilir', () => {
    cy.visit('/login');
    cy.get('input[type="email"]').type('john@blog.com');
    cy.get('input[type="password"]').type('password123');
    cy.get('button[type="submit"]').click();
    
    cy.url().should('eq', Cypress.config().baseUrl + '/');
    cy.contains('Welcome, John Doe').should('be.visible');
    cy.contains('My Posts').should('be.visible');
  });

  it('Hatalı şifre ile giriş yapamaz', () => {
    cy.visit('/login');
    cy.get('input[type="email"]').type('admin@blog.com');
    cy.get('input[type="password"]').type('wrongpassword');
    cy.get('button[type="submit"]').click();
    
    // Hata mesajı görünmeli
    cy.contains('Invalid email or password').should('be.visible');
    cy.url().should('include', '/login');
  });

  it('Kayıt sayfasına gidebilir', () => {
    cy.visit('/login');
    cy.contains('Register here').click();
    cy.url().should('include', '/register');
    cy.contains('Create Account').should('be.visible');
  });

  it('Yeni kullanıcı kaydı yapabilir', () => {
    cy.visit('/register');
    
    const timestamp = Date.now();
    const email = `test${timestamp}@example.com`;
    
    cy.get('input[type="text"]').type('Test User');
    cy.get('input[type="email"]').type(email);
    cy.get('input[type="password"]').first().type('password123');
    cy.get('input[type="password"]').last().type('password123');
    cy.get('button[type="submit"]').click();
    
    // Başarılı kayıt sonrası ana sayfaya yönlendirilir
    cy.url().should('eq', Cypress.config().baseUrl + '/');
    cy.contains('Welcome, Test User').should('be.visible');
  });

  it('Çıkış yapabilir', () => {
    cy.loginAsUser();
    cy.contains('button', 'Logout').click();
    
    cy.url().should('include', '/login');
    cy.contains('Login').should('be.visible');
  });
});

