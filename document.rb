require 'nokogiri'

# the TPL page creates a table of stuff of interest in rows with IDs
class Document
  def make_ndoc(html)
    # create an object model of the html document
    # for later XPath querying
    Nokogiri::HTML(html)
  end

  def ready_for_pickup(html)
    # Query for all the rows that contain content about ready for pickup.
    query = "//tbody[@id='tblAvail']/tr"
    noko_query(query, html)
  end

  def in_transit(html)
    # Query for all the rows that contain content about in transit
    query = "//tbody[@id='tblIntr']/tr"
    noko_query(query, html)
  end

  def checked_out_books(html)
    # Query for all the rows that contain content about in transit
    query = "//tbody[@id='renewcharge']/tr"
    noko_query(query, html)
  end

  def noko_query(query, html)
    nokodoc = make_ndoc(html)
    nokodoc.xpath(query)
  end

  def self.find_media_title(text)
    if text =~ %r{a href=.*detail.*>(.*)<\/a>}
      if text.size > 0
        mediatitle = $1.strip
      end
    end
  end

  def self.find_date_string(text)
    if text =~ %r{(\d+)\/(\d+)\/(\d\d\d\d)}
      format('<%04d-%02d-%02d>', $3, $2, $1)
    end
  end
end
