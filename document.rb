require 'nokogiri'

class Document
  def make_ndoc(html)
    # create an object model of the html document
    # for later XPath querying
    ndoc = Nokogiri::HTML(html)
  end

  def ready_for_pickup(html)
    #  the TPL page creates a table of stuff of interest in rows with IDs
    z = "//tbody[@id='tblAvail']/tr"
    q = make_ndoc(html)
    q.xpath(z)
  end

  def in_transit(html)
    q = make_ndoc(html)
    z = "//tbody[@id='tblIntr']/tr"
    q.xpath(z)
  end

  def checkedoutbooks(html)
    q = make_ndoc(html)
    z = "//tbody[@id='renewcharge']/tr"
    q.xpath(z)
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
