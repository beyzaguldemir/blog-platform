# frozen_string_literal: true

Eğer('ki sistemde kategoriler var') do
  # Seed data'da kategoriler var
  @categories_exist = true
end

Ozaman('tüm kategoriler listelenebilmeli') do
  @response = APIHelper.get('/categories', headers: APIHelper.auth_headers)
  expect(@response.code).to eq(200)
  @categories = JSON.parse(@response.body)
end

Ozaman('kategori sayısı 0\'dan büyük olmalı') do
  expect(@categories.length).to be > 0
end

Eğer('ki {string} adında yeni bir kategori oluşturuyorum') do |name|
  @category_data = { name: name }
end

Eğer('ki açıklaması {string}') do |description|
  @category_data[:description] = description
end

Ozaman('kategori başarıyla oluşturulmalı') do
  @response = APIHelper.post('/categories',
    body: @category_data.to_json,
    headers: APIHelper.auth_headers(@token)
  )
  expect(@response.code).to eq(201)
  @created_category = JSON.parse(@response.body)
end

Ozaman('kategorinin adı {string} olmalı') do |name|
  expect(@created_category['name']).to eq(name)
end

Eğer('ki sistemde {string} adında bir kategori var') do |name|
  # Önce kategoriyi bul veya oluştur
  response = APIHelper.get('/categories', headers: APIHelper.auth_headers)
  categories = JSON.parse(response.body)
  @category = categories.find { |c| c['name'] == name }
  
  if @category.nil?
    response = APIHelper.post('/categories',
      body: { name: name, description: 'Test category' }.to_json,
      headers: APIHelper.auth_headers(@token)
    )
    @category = JSON.parse(response.body)
  end
end

Eğer('ki kategori açıklaması {string} olarak güncelleniyor') do |new_description|
  @update_data = { description: new_description }
end

Ozaman('güncelleme başarılı olmalı') do
  @response = APIHelper.put("/categories/#{@category['id']}",
    body: @update_data.to_json,
    headers: APIHelper.auth_headers(@token)
  )
  expect(@response.code).to eq(200)
end

Eğer('ki sistemde silinebilir bir kategori var') do
  # Test kategorisi oluştur
  response = APIHelper.post('/categories',
    body: { name: "TestCategory#{Time.now.to_i}", description: 'For deletion' }.to_json,
    headers: APIHelper.auth_headers(@token)
  )
  @deletable_category = JSON.parse(response.body)
end

Ozaman('kategori silinebilmeli') do
  @response = APIHelper.delete("/categories/#{@deletable_category['id']}",
    headers: APIHelper.auth_headers(@token)
  )
  expect(@response.code).to eq(200)
end

Eğer('ki yeni bir kategori oluşturmaya çalışıyorum') do
  @category_data = { name: 'Unauthorized Category', description: 'Test' }
  @response = APIHelper.post('/categories',
    body: @category_data.to_json,
    headers: APIHelper.auth_headers(@token)
  )
end

