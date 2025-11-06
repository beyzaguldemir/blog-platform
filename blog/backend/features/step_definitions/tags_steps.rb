# frozen_string_literal: true

Eğer('ki sistemde tag\'ler var') do
  # Seed data'da tag'ler var
  @tags_exist = true
end

Ozaman('tüm tag\'ler listelenebilmeli') do
  @response = APIHelper.get('/tags', headers: APIHelper.auth_headers)
  expect(@response.code).to eq(200)
  @tags = JSON.parse(@response.body)
  expect(@tags.length).to be > 0
end

Eğer('ki {string} adında yeni bir tag oluşturuyorum') do |name|
  @tag_data = { name: name }
  @response = APIHelper.post('/tags',
    body: @tag_data.to_json,
    headers: APIHelper.auth_headers(@token)
  )
end

Ozaman('tag başarıyla oluşturulmalı') do
  expect(@response.code).to eq(201)
  @created_tag = JSON.parse(@response.body)
end

Eğer('ki sistemde {string} adında bir tag var') do |name|
  response = APIHelper.get('/tags', headers: APIHelper.auth_headers)
  tags = JSON.parse(response.body)
  @tag = tags.find { |t| t['name'] == name }
  
  if @tag.nil?
    response = APIHelper.post('/tags',
      body: { name: name }.to_json,
      headers: APIHelper.auth_headers(@token)
    )
    @tag = JSON.parse(response.body)
  end
end

Eğer('ki tag adı {string} olarak güncelleniyor') do |new_name|
  @update_data = { name: new_name }
  @response = APIHelper.put("/tags/#{@tag['id']}",
    body: @update_data.to_json,
    headers: APIHelper.auth_headers(@token)
  )
end

Eğer('ki sistemde silinebilir bir tag var') do
  response = APIHelper.post('/tags',
    body: { name: "TestTag#{Time.now.to_i}" }.to_json,
    headers: APIHelper.auth_headers(@token)
  )
  @deletable_tag = JSON.parse(response.body)
end

Ozaman('tag silinebilmeli') do
  @response = APIHelper.delete("/tags/#{@deletable_tag['id']}",
    headers: APIHelper.auth_headers(@token)
  )
  expect(@response.code).to eq(200)
end

