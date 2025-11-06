# frozen_string_literal: true

Eğer('ki sistemde yayınlanmış makaleler var') do
  # Seed data'da yayınlanmış makaleler var
  @posts_exist = true
end

Ozaman('sadece yayınlanmış makaleler listelenebilmeli') do
  @response = APIHelper.get('/posts?published=true', headers: APIHelper.auth_headers)
  expect(@response.code).to eq(200)
  @posts = JSON.parse(@response.body)
  @posts.each do |post|
    expect(post['published']).to be true
  end
end

Eğer('ki sistemde bir makale var') do
  response = APIHelper.get('/posts', headers: APIHelper.auth_headers)
  @posts = JSON.parse(response.body)
  @post = @posts.first
end

Ozaman('makale detayları görüntülenebilmeli') do
  @response = APIHelper.get("/posts/#{@post['id']}", headers: APIHelper.auth_headers)
  expect(@response.code).to eq(200)
  @post_detail = JSON.parse(@response.body)
end

Ozaman('makale yazarı bilgileri dönmeli') do
  expect(@post_detail['user']).not_to be_nil
  expect(@post_detail['user']['name']).not_to be_nil
end

Ozaman('makale kategorisi bilgileri dönmeli') do
  expect(@post_detail['category']).not_to be_nil
  expect(@post_detail['category']['name']).not_to be_nil
end

Ozaman('makale tag\'leri dönmeli') do
  expect(@post_detail['tags']).to be_a(Array)
end

Eğer('ki {string} başlıklı yeni bir makale oluşturuyor') do |title|
  @post_data = { title: title }
end

Eğer('ki makale içeriği {string}') do |content|
  @post_data[:content] = content
end

Eğer('ki bir kategori seçilmiş') do
  response = APIHelper.get('/categories', headers: APIHelper.auth_headers)
  categories = JSON.parse(response.body)
  @post_data[:category_id] = categories.first['id']
end

Ozaman('makale başarıyla oluşturulmalı') do
  @response = APIHelper.post('/posts',
    body: @post_data.to_json,
    headers: APIHelper.auth_headers(@token)
  )
  expect(@response.code).to eq(201)
  @created_post = JSON.parse(@response.body)
end

Ozaman('makale başlığı {string} olmalı') do |title|
  expect(@created_post['title']).to eq(title)
end

Eğer('ki yeni bir makale oluşturuyor') do
  response = APIHelper.get('/categories', headers: APIHelper.auth_headers)
  categories = JSON.parse(response.body)
  
  @post_data = {
    title: 'Test Post',
    content: 'Test content',
    category_id: categories.first['id']
  }
end

Eğer('ki makaleye tag\'ler ekliyor') do
  response = APIHelper.get('/tags', headers: APIHelper.auth_headers)
  tags = JSON.parse(response.body)
  @post_data[:tag_ids] = [tags.first['id'], tags.last['id']]
end

Ozaman('makale tag\'leri ile birlikte kaydedilmeli') do
  @response = APIHelper.post('/posts',
    body: @post_data.to_json,
    headers: APIHelper.auth_headers(@token)
  )
  expect(@response.code).to eq(201)
  @created_post = JSON.parse(@response.body)
  expect(@created_post['tags'].length).to be > 0
end

Eğer('ki kullanıcının bir makalesi var') do
  response = APIHelper.get('/posts', headers: APIHelper.auth_headers(@token))
  posts = JSON.parse(response.body)
  @user_post = posts.find { |p| p['user']['id'] == @current_user['id'] }
  
  if @user_post.nil?
    # Yeni makale oluştur
    categories_response = APIHelper.get('/categories', headers: APIHelper.auth_headers)
    categories = JSON.parse(categories_response.body)
    
    response = APIHelper.post('/posts',
      body: { title: 'My Post', content: 'Content', category_id: categories.first['id'] }.to_json,
      headers: APIHelper.auth_headers(@token)
    )
    @user_post = JSON.parse(response.body)
  end
end

Eğer('ki makale başlığını güncelliyor') do
  @update_data = { title: 'Updated Title' }
  @response = APIHelper.put("/posts/#{@user_post['id']}",
    body: @update_data.to_json,
    headers: APIHelper.auth_headers(@token)
  )
end

Eğer('ki başka bir kullanıcının makalesi var') do
  response = APIHelper.get('/posts', headers: APIHelper.auth_headers)
  posts = JSON.parse(response.body)
  @other_user_post = posts.find { |p| p['user']['id'] != @current_user['id'] }
end

Eğer('ki o makaleyi güncellemeye çalışıyor') do
  @update_data = { title: 'Hacked Title' }
  @response = APIHelper.put("/posts/#{@other_user_post['id']}",
    body: @update_data.to_json,
    headers: APIHelper.auth_headers(@token)
  )
end

Eğer('ki herhangi bir kullanıcının makalesi var') do
  response = APIHelper.get('/posts', headers: APIHelper.auth_headers(@token))
  posts = JSON.parse(response.body)
  @any_post = posts.first
end

Ozaman('admin makaleyi güncelleyebilmeli') do
  @response = APIHelper.put("/posts/#{@any_post['id']}",
    body: { title: 'Admin Updated' }.to_json,
    headers: APIHelper.auth_headers(@token)
  )
  expect(@response.code).to eq(200)
end

Ozaman('admin makaleyi silebilmeli') do
  @response = APIHelper.delete("/posts/#{@any_post['id']}",
    headers: APIHelper.auth_headers(@token)
  )
  expect(@response.code).to eq(200)
end

Eğer('ki makale taslak olarak kaydediliyor') do
  @update_data = { published: false }
  @response = APIHelper.put("/posts/#{@user_post['id']}",
    body: @update_data.to_json,
    headers: APIHelper.auth_headers(@token)
  )
end

Ozaman('makale {string} durumu {string} olmalı') do |field, value|
  updated_post = JSON.parse(@response.body)
  expect(updated_post[field].to_s).to eq(value)
end

Ozaman('makale yayınlanınca {string} durumu {string} olmalı') do |field, value|
  @response = APIHelper.put("/posts/#{@user_post['id']}",
    body: { published: true }.to_json,
    headers: APIHelper.auth_headers(@token)
  )
  updated_post = JSON.parse(@response.body)
  expect(updated_post[field].to_s).to eq(value)
end

