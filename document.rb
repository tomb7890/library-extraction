require 'nokogiri'

# the TPL page creates a table of stuff of interest in rows with IDs
class Document
  def make_ndoc(html)
    # create an object model of the html document
    # for later XPath querying
    Nokogiri::HTML(html)
  end

  def ready_for_pickup(html, hash)
    # Query for all the rows that contain content about ready for pickup.
    query = "//tbody[@id='tblAvail']/tr"
    noko_query(query, html, hash)
  end

  def in_transit(html, hash)
    # Query for all the rows that contain content about in transit
    query = "//tbody[@id='tblIntr']/tr"
    noko_query(query, html)
  end

  def checked_out_books(html, hash)
    # Query for all the rows that contain content about in transit
    query = "//tbody[@id='renewcharge']/tr"
    noko_query(query, html, hash)
  end

  def noko_query(query, html, hash)
     nokodoc = make_ndoc(html)
    rows = nokodoc.xpath(query)
    rows.each do |row|
      process_row(row,hash)
    end
  end

  def process_row(tr, hash)
    paragraph = tr.to_s
    datestring = find_date_string(paragraph)
    if datestring
      mediatitle = find_media_title(paragraph)
      if mediatitle
        hash.encode_into_hash(datestring, mediatitle)
      end
    end
  end

  def find_date_string(text)
    if text =~ %r{(\d+)\/(\d+)\/(\d\d\d\d)}
      format('<%04d-%02d-%02d>', $3, $2, $1)
    end
  end

  def find_media_title(text)
    if text =~ %r{a href=.*detail.*>(.*)<\/a>}
      if text.size > 0
        mediatitle = $1.strip
      end
    end
  end

end
