puts <<-BANNER
     __
    .-'  |
   /   <\|
  /     \'
  |_.- o-o
  / C  -._)\
 /',       |
|   `-,_,__,'
(,,)====[_]=|
  '.   ____/
   | -|-|_
   |____)_) 
====================================================================
**                  Instagram : @risky.manuel                     **
**                  Telegram  : @kikikokok9                       **
**                  Email     : riskymanuel08@proton.me           **
====================================================================
BANNER

require 'net/http'
require 'json'
require 'uri'

def shorten_with_tinyurl(url)
  uri = URI("http://tinyurl.com/api-create.php?url=#{URI.encode_www_form_component(url)}")
  response = Net::HTTP.get(uri)
  response
end

def shorten_with_shorturl(url)
  uri = URI("https://api.shorturl.at/shorten")
  request = Net::HTTP::Post.new(uri)
  request["User-Agent"] = "Ruby/#{RUBY_VERSION}"
  request.set_form_data({ "url" => url })

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(request)
  end

  if response.code.to_i == 200
    JSON.parse(response.body)["shorturl"]
  else
    "Error: #{response.message}"
  end
end

puts "Pilih metode pemendekan URL:"
puts "1. TinyURL"
puts "2. ShortURL"
print "Pilihan Anda: "
choice = gets.chomp.to_i

print "Masukkan URL yang akan diperpendek: "
url = gets.chomp

case choice
when 1
  puts "Shortened URL (TinyURL): #{shorten_with_tinyurl(url)}"
when 2
  puts "Shortened URL (ShortURL): #{shorten_with_shorturl(url)}"
else
  puts "Pilihan tidak valid!"
end
