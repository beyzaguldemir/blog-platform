# frozen_string_literal: true

Eğer('ki {string} adında yeni bir kullanıcı kaydolmak istiyor') do |name|
  @user_data = { name: name }
end

Eğer('ki email adresi {string}') do |email|
  @user_data[:email] = email
end

Eğer('ki şifresi {string}') do |password|
  @user_data[:password] = password
  @user_data[:password_confirmation] = password
end

Ozaman('kayıt başarılı olmalı') do
  @response = APIHelper.post('/auth/register', 
    body: @user_data.to_json,
    headers: APIHelper.auth_headers
  )
  expect(@response.code).to eq(201)
end

Ozaman('JWT token almalı') do
  @response_body = JSON.parse(@response.body)
  expect(@response_body['token']).not_to be_nil
  @token = @response_body['token']
end

Ozaman('kullanıcı bilgileri dönmeli') do
  expect(@response_body['user']).not_to be_nil
  expect(@response_body['user']['name']).to eq(@user_data[:name])
  expect(@response_body['user']['email']).to eq(@user_data[:email])
end

Eğer('ki sistemde {string} email\'li bir kullanıcı var') do |email|
  # Seed data'da admin@blog.com var
  @login_email = email
end

Eğer('ki doğru şifre {string} ile giriş yapıyor') do |password|
  @login_password = password
end

Ozaman('giriş başarılı olmalı') do
  @response = APIHelper.post('/auth/login',
    body: { email: @login_email, password: @login_password }.to_json,
    headers: APIHelper.auth_headers
  )
  expect(@response.code).to eq(200)
end

Ozaman('kullanıcı rolü {string} olmalı') do |role|
  @response_body = JSON.parse(@response.body)
  expect(@response_body['user']['role']).to eq(role)
end

Eğer('ki yanlış şifre {string} ile giriş yapıyor') do |wrong_password|
  @login_password = wrong_password
end

Ozaman('giriş başarısız olmalı') do
  @response = APIHelper.post('/auth/login',
    body: { email: @login_email, password: @login_password }.to_json,
    headers: APIHelper.auth_headers
  )
  expect(@response.code).to eq(401)
end

Ozaman('{string} hata kodu dönmeli') do |status_code|
  expect(@response.code).to eq(status_code.to_i)
end

