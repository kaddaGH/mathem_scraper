require 'cgi'
pages << {
    page_type: 'products_search',
    method: 'GET',
    url: 'https://api.mathem.io/product-search/noauth/search/products/10/categorytag/energidryck?brands=&badges=&categories=&storeId=10&size=25&index=0&sortTerm=&sortOrder=&supplier=',
   vars: {
        'input_type' => 'taxonomy',
        'search_term' => '-',
        'page' => 1
    }


}

search_terms = ['Red Bull', 'RedBull', 'Energidryck', 'Energidrycker']
search_terms.each do |search_term|
break
  pages << {
      page_type: 'products_search',
      method: 'GET',
      url: "https://api.mathem.io/product-search/noauth/search/query?q=#{CGI.escape(search_term)}&brands=&badges=&categories=&storeId=10&size=25&index=0&sortTerm=&sortOrder=&supplier=&searchToCart=true",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end