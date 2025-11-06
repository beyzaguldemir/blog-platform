# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Clearing existing data..."
PostTag.destroy_all
Post.destroy_all
Tag.destroy_all
Category.destroy_all
User.destroy_all

puts "Creating users..."
admin = User.create!(
  name: "Admin User",
  email: "admin@blog.com",
  password: "password123",
  password_confirmation: "password123",
  role: "admin"
)

user1 = User.create!(
  name: "John Doe",
  email: "john@blog.com",
  password: "password123",
  password_confirmation: "password123",
  role: "user"
)

user2 = User.create!(
  name: "Jane Smith",
  email: "jane@blog.com",
  password: "password123",
  password_confirmation: "password123",
  role: "user"
)

puts "Creating categories..."
tech = Category.create!(name: "Technology", description: "Technology related posts")
lifestyle = Category.create!(name: "Lifestyle", description: "Lifestyle and daily life posts")
travel = Category.create!(name: "Travel", description: "Travel and adventure posts")
food = Category.create!(name: "Food", description: "Food and cooking posts")

puts "Creating tags..."
ruby = Tag.create!(name: "Ruby")
rails = Tag.create!(name: "Rails")
react = Tag.create!(name: "React")
javascript = Tag.create!(name: "JavaScript")
health = Tag.create!(name: "Health")
fitness = Tag.create!(name: "Fitness")
adventure = Tag.create!(name: "Adventure")
recipe = Tag.create!(name: "Recipe")

puts "Creating posts..."
post1 = Post.create!(
  title: "Getting Started with Ruby on Rails",
  content: "Ruby on Rails is a web application framework written in Ruby. It is designed to make programming web applications easier by making assumptions about what every developer needs to get started. This post will guide you through the basics...",
  user: admin,
  category: tech,
  published: true
)
post1.tags << [ruby, rails]

post2 = Post.create!(
  title: "Modern React Development",
  content: "React has revolutionized the way we build user interfaces. In this comprehensive guide, we'll explore the latest features and best practices for React development in 2024...",
  user: user1,
  category: tech,
  published: true
)
post2.tags << [react, javascript]

post3 = Post.create!(
  title: "Healthy Living Tips",
  content: "Living a healthy lifestyle doesn't have to be complicated. Here are some simple tips to improve your daily routine and overall well-being...",
  user: user2,
  category: lifestyle,
  published: true
)
post3.tags << [health, fitness]

post4 = Post.create!(
  title: "Exploring the Mountains",
  content: "Mountain travel offers breathtaking views and unforgettable experiences. Join me as I share my recent adventure to the Himalayas...",
  user: user1,
  category: travel,
  published: true
)
post4.tags << [adventure]

post5 = Post.create!(
  title: "Easy Pasta Recipes",
  content: "Pasta is a versatile and delicious meal option. Here are five easy pasta recipes you can make in under 30 minutes...",
  user: user2,
  category: food,
  published: true
)
post5.tags << [recipe]

post6 = Post.create!(
  title: "Draft Post: Upcoming Features",
  content: "This is a draft post about upcoming features in our application...",
  user: admin,
  category: tech,
  published: false
)
post6.tags << [ruby, rails, react]

puts "Seed data created successfully!"
puts "Admin credentials: admin@blog.com / password123"
puts "User credentials: john@blog.com / password123"
puts "User credentials: jane@blog.com / password123"
