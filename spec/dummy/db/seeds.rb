# frozen_string_literal: true

(11..16).each do |i|
  Tag.find_or_create_by!(name: "Tag #{i}")
end

(11..20).each do |i|
  age = 21 + 3 * (i - 10)
  attrs = { name: "Author #{i}", age: age, email: "some@email#{i}.com" }
  Author.find_or_create_by!(name: "Author #{i}") do |author|
    author.assign_attributes(attrs)
    author.profile = Profile.new(description: "Profile description for Author #{i}") if (i % 3).zero?
  end
end

authors = Author.pluck(:id)
tags = Tag.where.not(name: 'A test tag').pluck(:id)
(11..40).each do |i|
  attrs = {
    title: "Post #{i}",
    author_id: authors.sample,
    position: rand(100),
    summary: "<p><em>Summary</em> for post #{i}</p>",
    description: "<p><strong>Some bold</strong> <em>Some italic</em> <u>Some underline</u> [#{i}]</p>",
    created_at: Time.now - rand(3600).seconds
  }
  attrs[:category] = 'news' if (i % 4).zero?
  attrs[:dt] = Time.now - rand(30).days if (i % 3).zero?

  Post.find_or_create_by!(title: "Post #{i}") do |post|
    post.assign_attributes(attrs)
    post.tags = Tag.where(id: tags.sample(2)) if (i % 2).zero?
  end
end

Author.find_or_create_by!(name: 'A test author', email: 'aaa@bbb.ccc', age: 30)
Tag.find_or_create_by!(name: 'A test tag')

puts '> Seeds: done.'
