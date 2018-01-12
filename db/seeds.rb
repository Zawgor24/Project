# frozen_string_literal: true

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')
end

user1 = User.create(email: '1@1.com', password: 123_123)

post1 = user1.posts.create(title: 'first', body: 'post')
post2 = user1.posts.create(title: 'second', body: 'post')

news1 = user1.articles.create(title: 'first', body: 'news')
news2 = user1.articles.create(title: 'second', body: 'news')

post1.comments.create(title: 'first', body: 'comment',
                      user_id: post1.user_id)
post2.comments.create(title: 'first', body: 'comment',
                      user_id: post2.user_id)
news1.comments.create(title: 'second', body: 'comment',
                      user_id: news1.user_id)
news2.comments.create(title: 'second', body: 'comment',
                      user_id: news2.user_id)
