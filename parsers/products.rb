nokogiri = Nokogiri.HTML(content)

# initialize an empty hash
product = {}

# Extract title
product['title'] = nokogiri.at_css('h1[id="main-title"]').text.strip

# Extract current price
product['current_price'] = nokogiri.at_css('span[itemprop="price"]').text.gsub(/[^0-9.]/, '').to_f #.attr('content').to_f

# Extract original price
original_price_div = nokogiri.at_css('span.strike')
original_price = original_price_div ? original_price_div.text.strip.gsub(/[^0-9.]/, '').to_f : nil
product['original_price'] = original_price == 0.0 ? nil : original_price

# Extract rating
rating = nokogiri.at_css('span.rating-number').text.strip.gsub(/[^0-9.]/, '').to_f
product['rating'] = rating == 0 ? nil : rating

# Extract number of reviews
review_text = nokogiri.at_css('a[link-identifier="reviewsLink"]').text.strip
product['reviews_count'] = review_text =~ /reviews/ ? review_text.split(' ').first.to_i : 0

# Extract publisher
product['publisher'] = nokogiri.xpath("//div[text()='Produced by']/following-sibling::div[1]").text.strip

# Extract walmart item number
product['walmart_number'] = nokogiri.at_css('script[type="application/ld+json"]').text.scan(/"sku":"(\d+)"/)[0] #.split('#').last.strip

# Extract product image
product['img_url'] = nokogiri.at_css('img[loading="eager"]')['src']

# Extract product categories
product['categories'] = nokogiri.xpath("//h3[text()='Movie Genre']/following-sibling::div/span").text

# specify the collection where this record will be stored
product['_collection'] = 'products'

# save the product to the job’s outputs
outputs << product