require 'nokogiri'
require 'open-uri'
require 'json'

content = URI.open('https://www.walmart.com/browse/new-in-movies/0/0?_refineresult=true&_be_shelf_id=1522545&search_sort=100&facet=shelf_id%3A1522545&povid=_Movies_cp_static_topnav_newreleases&page=2&affinityOverride=default')
puts "content:"
puts content.class
puts content
puts

# initialize nokogiri
nokogiri = Nokogiri::HTML(content)
puts "nokogiri:"
puts nokogiri.class
puts nokogiri
puts

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