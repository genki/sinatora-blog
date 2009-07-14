require "rubygems"
require "sinatra"
require "dm-core"
require "haml"

DataMapper::setup(:default, "sqlite3::memory:")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :content, Text
  auto_upgrade!
end

get "/" do
  @posts = Post.all(:order => [:id.desc])
  haml :index
end

post "/" do
  Post.create(params)
  redirect "/"
end

__END__
@@ index
%h1 Hello, Sinatra!
%ul
  - @posts.each do |post|
    %li= post.content
%form{:method => :post}
  %textarea{:name => :content}
  %input{:type => :submit, :value => "Post"}
