# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

TOPICS = ["Object Oriented Ruby", "Rack", "ActiveRecord", "Sinatra", "Rails", "Javascript", "Angular"]

TOPICS.each{|topic_name| Topic.create(:name  => topic_name)}

molly = User.create(:email => "Molly@gmail.com")

html = Topic.create(:name => "HTML and CSS")

shopping_cart_video = Resource.create(:user_id => molly.id, :title => "Shopping Cart Video", :link => "http://stackoverflow.com/questions/7167895/whats-a-good-way-to-validate-links-urls-in-rails")

ResourceTopic.create(:topic_id => html.id, :resource_id => shopping_cart_video.id)