require 'nokogiri'
require 'open-uri'
require 'json'

# /mnt/c/Users/Raihan/Downloads/Web/'New in Movies.html'
file_path = '/home/hraihanm/Web/New in Movies.html'
content = File.read(file_path)

# puts "content:"
# puts content.class
# puts content
# puts

# initialize nokogiri
nokogiri = Nokogiri::HTML(content)

# products = nokogiri.css('.pr0-xl') # Movies container
products = nokogiri.css('.pb3-m')

puts products.class
puts products.length()
# products.each do |product|
#   puts
#   puts product
#   puts
# end
puts

products.each do |product|
  href = product.at_css('a.absolute.w-100.h-100.z-1.hide-sibling-opacity')['href']
  url = URI.join('https://www.walmart.com', href).to_s
  puts
  puts url
  puts
  # pages << {
  #     url: url,
  #     page_type: 'products',
  #     fetch_type: 'browser',
  #     vars: {}
  #   }
end

pagination_links = nokogiri.css('a[data-testid="NextPage"]')
pagination_links.each do |link|
  url = URI.join('https://www.walmart.com', link['href']).to_s

  puts url
  # pages << {
  #     url: url,
  #     page_type: 'listings',
  #     fetch_type: 'browser',
  #     vars: {}
  #   }
end