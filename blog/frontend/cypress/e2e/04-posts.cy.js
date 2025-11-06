describe('Makale Yönetimi', () => {
  beforeEach(() => {
    cy.loginAsAdmin();
  });

  it('Posts sayfasına gidebilir', () => {
    cy.contains('Posts').click();
    cy.url().should('include', '/admin/posts');
    cy.contains('h1', 'Posts').should('be.visible');
  });

  it('Mevcut makaleleri görüntüleyebilir', () => {
    cy.contains('Posts').click();
    
    // Seed data'daki makaleler görünmeli
    cy.contains('Getting Started with Ruby on Rails').should('be.visible');
    cy.contains('Modern React Development').should('be.visible');
  });

  it('Yeni makale ekleyebilir', () => {
    cy.contains('Posts').click();
    cy.contains('button', 'Add Post').click();
    
    const timestamp = Date.now();
    const title = `Test Post ${timestamp}`;
    
    cy.get('input[type="text"]').type(title);
    cy.get('textarea').first().type('This is a test post content for Cypress testing.');
    
    // Kategori seç
    cy.get('select').select(1);
    
    // Tag seç
    cy.contains('button', '#Ruby').click();
    cy.contains('button', '#React').click();
    
    // Yayınla
    cy.get('input[type="checkbox"]').check();
    
    cy.contains('button', 'Create').click();
    
    // Yeni makale listede görünmeli
    cy.contains(title).should('be.visible');
    cy.contains('Published').should('be.visible');
  });

  it('Taslak makale oluşturabilir', () => {
    cy.contains('Posts').click();
    cy.contains('button', 'Add Post').click();
    
    const timestamp = Date.now();
    const title = `Draft Post ${timestamp}`;
    
    cy.get('input[type="text"]').type(title);
    cy.get('textarea').first().type('This is a draft post.');
    cy.get('select').select(1);
    
    // Publish checkbox'ı işaretleme (taslak olarak kalacak)
    cy.contains('button', 'Create').click();
    
    cy.contains(title).should('be.visible');
    cy.contains('Draft').should('be.visible');
  });

  it('Makale güncelleyebilir', () => {
    cy.contains('Posts').click();
    
    // İlk makaleyi düzenle
    cy.contains('Getting Started').parent().parent().within(() => {
      cy.contains('button', 'Edit').click();
    });
    
    // Modal açılır
    cy.contains('Edit Post').should('be.visible');
    
    cy.get('input[type="text"]').clear().type('Updated Post Title');
    cy.contains('button', 'Update').click();
    
    cy.contains('Updated Post Title').should('be.visible');
  });

  it('Makale silebilir', () => {
    cy.contains('Posts').click();
    
    // Test makalesi oluştur
    cy.contains('button', 'Add Post').click();
    const timestamp = Date.now();
    const title = `Delete Test ${timestamp}`;
    
    cy.get('input[type="text"]').type(title);
    cy.get('textarea').first().type('Will be deleted');
    cy.get('select').select(1);
    cy.contains('button', 'Create').click();
    
    // Oluşturulan makaleyi sil
    cy.contains(title).parent().parent().within(() => {
      cy.contains('button', 'Delete').click();
    });
    
    cy.on('window:confirm', () => true);
    cy.contains(title).should('not.exist');
  });

  it('Ana sayfada yayınlanmış makaleleri görebilir', () => {
    // Ana sayfaya git
    cy.visit('/');
    
    // Yayınlanmış makaleler görünmeli
    cy.contains('Getting Started with Ruby on Rails').should('be.visible');
    cy.contains('Modern React Development').should('be.visible');
    
    // Makale detayına gidebilir
    cy.contains('Read More').first().click();
    cy.url().should('include', '/post/');
    
    // Makale içeriği görünmeli
    cy.contains('Getting Started with Ruby on Rails').should('be.visible');
    cy.contains('Back to Posts').should('be.visible');
  });
});

