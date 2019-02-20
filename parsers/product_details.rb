json_details = JSON.parse(content)

data = json_details['product']

promotion = "#{data['discount']['quantityToBeBought']} för #{data['discount']['price']}:-" rescue ""

availability = data['availability'] == 'AVAILABLE' ? '1' : ''


price = data['price']

category = data['category']['name']

description = json_details['info']['PRODUCT_DESCRIPTION'].gsub(/[\n\s]+/, ' ').gsub(/,/, '.') rescue ''
pack = data['amountInPackage'].to_i>0?data['amountInPackage']:"1"
size =  data['quantity']
size_uom = data['unit']
if pack>0

  regexps = [
      /(\d*[\.,]?\d+)\s?([Ff][Ll]\.?\s?[Oo][Zz])/,
      /(\d*[\.,]?\d+)\s?([Oo][Zz])/,
      /(\d*[\.,]?\d+)\s?([Ff][Oo])/,
      /(\d*[\.,]?\d+)\s?([Ee][Aa])/,
      /(\d*[\.,]?\d+)\s?([Ff][Zz])/,
      /(\d*[\.,]?\d+)\s?(Fluid Ounces?)/,
      /(\d*[\.,]?\d+)\s?([Oo]unce)/,
      /(\d*[\.,]?\d+)\s?([Mm][Ll])/,
      /(\d*[\.,]?\d+)\s?([Cc][Ll])/,
      /(\d*[\.,]?\d+)\s?([Ll])/,
      /(\d*[\.,]?\d+)\s?([Gg])/,
      /(\d*[\.,]?\d+)\s?([Ll]itre)/,
      /(\d*[\.,]?\d+)\s?([Ss]ervings)/,
      /(\d*[\.,]?\d+)\s?([Pp]acket\(?s?\)?)/,
      /(\d*[\.,]?\d+)\s?([Cc]apsules)/,
      /(\d*[\.,]?\d+)\s?([Tt]ablets)/,
      /(\d*[\.,]?\d+)\s?([Tt]ubes)/,
      /(\d*[\.,]?\d+)\s?([Cc]hews)/,
      /(\d*[\.,]?\d+)\s?([Mm]illiliter)/i,
  ]
  regexps.find {|regexp| data['fullName'] =~ regexp}
  size = $1
  size_uom = $2
end
product_details = {
    # - - - - - - - - - - -
    RETAILER_ID: '102',
    RETAILER_NAME: 'mathem',
    GEOGRAPHY_NAME: 'SE',
    # - - - - - - - - - - -
    SCRAPE_INPUT_TYPE: page['vars']['input_type'],
    SCRAPE_INPUT_SEARCH_TERM: page['vars']['search_term'],
    SCRAPE_INPUT_CATEGORY: page['vars']['input_type'] == 'taxonomy' ? category : '-',
    SCRAPE_URL_NBR_PRODUCTS: page['vars']['scrape_url_nbr_products'],
    # - - - - - - - - - - -
    SCRAPE_URL_NBR_PROD_PG1: page['vars']['nbr_products_pg1'],
    # - - - - - - - - - - -
    PRODUCT_BRAND: data['brand']['name'],
    PRODUCT_RANK: page['vars']['product_rank'],
    PRODUCT_PAGE: page['vars']['page'],
    PRODUCT_ID: data['id'],
    PRODUCT_NAME: data['fullName'],
    EAN: data['gtin'],
    PRODUCT_DESCRIPTION: description,
    PRODUCT_MAIN_IMAGE_URL: data['images']['ORIGINAL'],
    PRODUCT_ITEM_SIZE: size,
    PRODUCT_ITEM_SIZE_UOM: size_uom,
    PRODUCT_ITEM_QTY_IN_PACK: pack,
    SALES_PRICE: price,
    IS_AVAILABLE: availability,
    PROMOTION_TEXT: promotion,
    PRODUCT_STAR_RATING: data['rating']['avgRating'],
    PRODUCT_NBR_OF_REVIEWS: data['rating']['votes'],
    EXTRACTED_ON: Time.now.to_s
}

product_details['_collection'] = 'products'

outputs << product_details

