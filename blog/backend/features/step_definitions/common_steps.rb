# frozen_string_literal: true

Eğer('ki admin olarak giriş yapılmış') do
  @response = APIHelper.post('/auth/login',
    body: { email: 'admin@blog.com', password: 'password123' }.to_json,
    headers: APIHelper.auth_headers
  )
  @token = JSON.parse(@response.body)['token']
  @current_user = JSON.parse(@response.body)['user']
end

Eğer('ki normal kullanıcı olarak giriş yapılmış') do
  @response = APIHelper.post('/auth/login',
    body: { email: 'john@blog.com', password: 'password123' }.to_json,
    headers: APIHelper.auth_headers
  )
  @token = JSON.parse(@response.body)['token']
  @current_user = JSON.parse(@response.body)['user']
end

Eğer('ki giriş yapılmış bir kullanıcı var') do
  @response = APIHelper.post('/auth/login',
    body: { email: 'john@blog.com', password: 'password123' }.to_json,
    headers: APIHelper.auth_headers
  )
  @token = JSON.parse(@response.body)['token']
  @current_user = JSON.parse(@response.body)['user']
end

Ozaman('{string} başarı kodu dönmeli') do |status_code|
  expect(@response.code).to eq(status_code.to_i)
end

Ozaman('işlem reddedilmeli') do
  expect([401, 403]).to include(@response.code)
end

