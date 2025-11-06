describe('Tag Yönetimi', () => {
  beforeEach(() => {
    cy.loginAsAdmin();
  });

  it('Tags sayfasına gidebilir', () => {
    cy.contains('Tags').click();
    cy.url().should('include', '/admin/tags');
    cy.contains('h1', 'Tags').should('be.visible');
  });

  it('Mevcut tag\'leri görüntüleyebilir', () => {
    cy.contains('Tags').click();
    
    // Seed data'daki tag'ler görünmeli
    cy.contains('#Ruby').should('be.visible');
    cy.contains('#Rails').should('be.visible');
    cy.contains('#React').should('be.visible');
  });

  it('Yeni tag ekleyebilir', () => {
    cy.contains('Tags').click();
    cy.contains('button', 'Add Tag').click();
    
    const timestamp = Date.now();
    const tagName = `TestTag${timestamp}`;
    
    cy.get('input[type="text"]').type(tagName);
    cy.contains('button', 'Create').click();
    
    cy.contains(`#${tagName}`).should('be.visible');
  });

  it('Tag güncelleyebilir', () => {
    cy.contains('Tags').click();
    
    // Test tag oluştur
    cy.contains('button', 'Add Tag').click();
    const timestamp = Date.now();
    const originalName = `Original${timestamp}`;
    cy.get('input[type="text"]').type(originalName);
    cy.contains('button', 'Create').click();
    
    // Oluşturulan tag'i düzenle
    cy.contains(`#${originalName}`).parent().within(() => {
      cy.contains('button', 'Edit').click();
    });
    
    const updatedName = `Updated${timestamp}`;
    cy.get('input[type="text"]').clear().type(updatedName);
    cy.contains('button', 'Update').click();
    
    cy.contains(`#${updatedName}`).should('be.visible');
    cy.contains(`#${originalName}`).should('not.exist');
  });

  it('Tag silebilir', () => {
    cy.contains('Tags').click();
    
    // Test tag oluştur
    cy.contains('button', 'Add Tag').click();
    const timestamp = Date.now();
    const tagName = `DeleteTag${timestamp}`;
    cy.get('input[type="text"]').type(tagName);
    cy.contains('button', 'Create').click();
    
    // Tag'i sil
    cy.contains(`#${tagName}`).parent().within(() => {
      cy.contains('button', 'Delete').click();
    });
    
    cy.on('window:confirm', () => true);
    cy.contains(`#${tagName}`).should('not.exist');
  });
});

