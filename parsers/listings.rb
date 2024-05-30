nokogiri = Nokogiri.HTML(content)

products = nokogiri.css('.pb3-m')
products.each do |product|
  href = product.at_css('a.absolute.w-100.h-100.z-1.hide-sibling-opacity')['href']
  url = URI.join('https://www.walmart.com', href).to_s
  pages << {
      url: url,
      page_type: 'products',
      fetch_type: 'browser',
      vars: {}
    }
end

pagination_links = nokogiri.css('a[data-testid="NextPage"]')
pagination_links.each do |link|
  url = URI.join('https://www.walmart.com', link['href']).to_s
  pages << {
      url: url,
      page_type: 'listings',
      fetch_type: 'browser',
      vars: {}
    }
end