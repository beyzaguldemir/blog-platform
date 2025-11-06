# frozen_string_literal: true

Ozaman('tüm kullanıcılar listelenebilmeli') do
  @response = APIHelper.get('/users', headers: APIHelper.auth_headers(@token))
  expect(@response.code).to eq(200)
  @users = JSON.parse(@response.body)
end

Ozaman('kullanıcı sayısı 0\'dan büyük olmalı') do
  expect(@users.length).to be > 0
end

Eğer('ki sistemde silinebilir bir kullanıcı var') do
  @deletable_user = @users.find { |u| u['role'] == 'user' && u['id'] != @current_user['id'] }
end

Ozaman('admin kullanıcıyı silebilmeli') do
  @response = APIHelper.delete("/users/#{@deletable_user['id']}",
    headers: APIHelper.auth_headers(@token)
  )
  expect(@response.code).to eq(200)
end

Eğer('ki tüm kullanıcıları listelemeye çalışıyor') do
  @response = APIHelper.get('/users', headers: APIHelper.auth_headers(@token))
end

Eğer('ki kendi adını güncelliyor') do
  @update_data = { name: 'Updated Name' }
  @response = APIHelper.put("/users/#{@current_user['id']}",
    body: @update_data.to_json,
    headers: APIHelper.auth_headers(@token)
  )
end

Eğer('ki başka bir kullanıcının bilgilerini güncellemeye çalışıyor') do
  response = APIHelper.get('/users', headers: APIHelper.auth_headers(@token))
  users = JSON.parse(response.body) rescue []
  other_user = users.find { |u| u['id'] != @current_user['id'] } || { 'id' => 999 }
  
  @response = APIHelper.put("/users/#{other_user['id']}",
    body: { name: 'Hacked Name' }.to_json,
    headers: APIHelper.auth_headers(@token)
  )
end

