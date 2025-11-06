describe('Kategori Yönetimi', () => {
  beforeEach(() => {
    cy.loginAsAdmin();
  });

  it('Kategoriler sayfasına gidebilir', () => {
    cy.contains('Categories').click();
    cy.url().should('include', '/admin/categories');
    cy.contains('h1', 'Categories').should('be.visible');
  });

  it('Mevcut kategorileri görüntüleyebilir', () => {
    cy.contains('Categories').click();
    
    // Seed data'daki kategoriler görünmeli
    cy.contains('Technology').should('be.visible');
    cy.contains('Lifestyle').should('be.visible');
    cy.contains('Travel').should('be.visible');
    cy.contains('Food').should('be.visible');
  });

  it('Yeni kategori ekleyebilir', () => {
    cy.contains('Categories').click();
    cy.contains('button', 'Add Category').click();
    
    // Modal açılır
    cy.contains('Add Category').should('be.visible');
    
    const timestamp = Date.now();
    const categoryName = `Test Category ${timestamp}`;
    
    cy.get('input[type="text"]').type(categoryName);
    cy.get('textarea').type('Test description');
    cy.contains('button', 'Create').click();
    
    // Yeni kategori listede görünmeli
    cy.contains(categoryName).should('be.visible');
  });

  it('Kategori güncelleyebilir', () => {
    cy.contains('Categories').click();
    
    // İlk kategoriyi düzenle
    cy.contains('Technology').parent().parent().within(() => {
      cy.contains('button', 'Edit').click();
    });
    
    // Modal açılır
    cy.contains('Edit Category').should('be.visible');
    
    cy.get('textarea').clear().type('Updated description for technology');
    cy.contains('button', 'Update').click();
    
    // Güncelleme başarılı mesajı veya yeni açıklama görünmeli
    cy.contains('Updated description').should('be.visible');
  });

  it('Kategori silebilir', () => {
    cy.contains('Categories').click();
    
    // Test kategorisi oluştur
    cy.contains('button', 'Add Category').click();
    const timestamp = Date.now();
    const categoryName = `Delete Test ${timestamp}`;
    
    cy.get('input[type="text"]').type(categoryName);
    cy.get('textarea').type('Will be deleted');
    cy.contains('button', 'Create').click();
    
    // Oluşturulan kategoriyi sil
    cy.contains(categoryName).parent().parent().within(() => {
      cy.contains('button', 'Delete').click();
    });
    
    // Onay ve silme
    cy.on('window:confirm', () => true);
    
    // Kategori listeden kaybolmalı
    cy.contains(categoryName).should('not.exist');
  });
});

