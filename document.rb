require 'nokogiri'

# The Document class encapsulates knowledge about extracting details of interest
# from the library website.
class Document
  def make_ndoc(html)
    Nokogiri::HTML(html)
  end

  def ready_for_pickup(html, hash)
    query = "//tbody[@id='tblAvail']/tr"
    noko_query(query, html, hash)
  end

  def in_transit(html, hash)
    query = "//tbody[@id='tblIntr']/tr"
    noko_query(query, html, hash)
  end

  def checked_out_books(html, hash)
    query = "//tbody[@id='renewcharge']/tr"
    noko_query(query, html, hash)
  end

  def noko_query(query, html, hash)
    nokodoc = make_ndoc(html)
    rows = nokodoc.xpath(query)
    rows.each do |row|
      process_row(row, hash)
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
        $1.strip
      end
    end
  end

end
