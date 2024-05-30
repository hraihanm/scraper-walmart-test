require 'nokogiri'
require 'open-uri'
require 'json'

def printer(text, var)
    puts text + ":"
    puts var
    puts var.class
    puts
end

# /mnt/c/Users/Raihan/Downloads/Web/'New in Movies.html'
# file_path = '/home/hraihanm/Web/The Meg 2-Film Collection (DVD) - Walmart.com.html'
file_path = '/home/hraihanm/Web/Dune_ Part Two (4K Ultra HD + Digital Copy) - Walmart.com.html'
content = File.read(file_path)

nokogiri = Nokogiri.HTML(content)

# initialize an empty hash
product = {}

# Extract title
product['title'] = nokogiri.at_css('h1[id="main-title"]').text.strip
printer("TItle", product['title'])

# Extract current price
product['current_price'] = nokogiri.at_css('span[itemprop="price"]').text.gsub(/[^0-9.]/, '').to_f #.attr('content').to_f
printer("Current price", product['current_price'])


# Extract original price
original_price_div = nokogiri.at_css('span.strike')
original_price = original_price_div ? original_price_div.text.strip.gsub(/[^0-9.]/, '').to_f : nil
product['original_price'] = original_price == 0.0 ? nil : original_price
printer("Original price", product['original_price'])

# Extract rating
rating = nokogiri.at_css('span.rating-number').text.strip.gsub(/[^0-9.]/, '').to_f
product['rating'] = rating == 0 ? nil : rating
printer("Rating", product['rating'])

# Extract number of reviews
review_text = nokogiri.at_css('a[link-identifier="reviewsLink"]').text.strip
product['reviews_count'] = review_text =~ /reviews/ ? review_text.split(' ').first.to_i : 0
printer("Reviews count", product['reviews_count'])

# Extract publisher
product['publisher'] = nokogiri.xpath("//div[text()='Produced by']/following-sibling::div[1]").text.strip
printer("publisher", product['publisher'])

# Extract walmart item number
product['walmart_number'] = nokogiri.at_css('script[type="application/ld+json"]').text.scan(/"sku":"(\d+)"/)[0] #.split('#').last.strip
printer("Walmart ID", product['walmart_number'])

# Extract product image
product['img_url'] = nokogiri.at_css('img[loading="eager"]')['src']
printer("Image URL", product['img_url'])

# Extract product categories
product['categories'] = nokogiri.xpath("//h3[text()='Movie Genre']/following-sibling::div/span").text
printer("Categories", product['categories'])

#= nokogiri.css('.breadcrumb-list li').collect{|li| li.text.strip.gsub('/','') }

# specify the collection where this record will be stored
product['_collection'] = 'products'

# save the product to the job’s outputs
outputs << product