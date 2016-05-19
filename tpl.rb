require 'yaml'
require 'mechanize'
require_relative './document'

class Tpl
  attr_accessor :cachefile, :doc

  def readyforpickup_titles
    @xreadyforpickup.alltitles
  end

  def initialize
    @doc = Document.new
    @cachefile = 'archive.html'
    @xbooksdue = Xhash.new
    @xreadyforpickup = Xhash.new
  end

  def ready_for_pickup
    @doc.ready_for_pickup(@cachefile)
  end

  def total_checked_out_items
    @xbooksdue.total_items
  end

  def num_items_available_for_pickup
    @xreadyforpickup.total_items
  end

  def main
    parse_and_write(local_html)
  end

  def refresh
    parse_and_write(remote_html)
  end

  def getconfig
    configfile = 'config/config.yml'
    YAML.load_file(configfile)
  end

  def getoption(opt)
    rc = nil
    config = getconfig if config.nil?
    if config
      t = config[opt]
      rc = t unless t.nil?
    end
    rc
  end

  def parse_and_write(html)
    parse(html)
    write_orgmode_file
  end

  def parse(html)
    @doc.checked_out_books(html, @xbooksdue)
    @doc.ready_for_pickup(html, @xreadyforpickup)
  end

  def local_html
    f = open(@cachefile, 'r')
    html = f.read
    html = strip_html(html)
    f.close
    html
  end

  def orgmode_filename
    orgfile = getoption('org_agenda_file')
    File.expand_path(orgfile)
  end

  private

  def write_orgmode_file
    orgfile = orgmode_filename
    f = open(orgfile, 'w')
    @xbooksdue.create_orgmode_entrys(f, 'checkouts due')
    @xreadyforpickup.create_orgmode_entrys(f, 'ready for pickup')
    f.close
  end

  def cache(page)
    f = open(@cachefile, 'w')
    f.write(page.body)
    f.close
  end

  def prepare_login_form(login_form)
    email_field = login_form.field_with(name: 'userId')
    password_field = login_form.field_with(name: 'password')
    email_field.value = getoption('tpl_username')
    password_field.value = getoption('tpl_password')
  end

  def remote_html
    agent = Mechanize.new
    agent.log = Logger.new 'mechanize.log'
    login_page = agent.get 'https://www.torontopubliclibrary.ca/youraccount'
    login_form = login_page.form_with(action: 'https://www.torontopubliclibrary.ca:443/signin')
    prepare_login_form(login_form)
    home_page = login_form.submit
    cache(home_page)
    home_page.body
  end

  def strip_html(str)
    z = Nokogiri::HTML('&nbsp;').text
    str.gsub(z, '')
  end
end

# The Xhash class is a wrapper for a Hash used to store dates and
# actions gathered from the TPL website, and then used as input for creation of
# the Emacs Org Mode file.
class Xhash
  def initialize
    @hash = {}
  end

  def alltitles
    all = []
    @hash.each do |_k, v|
      all << v
    end
    all
  end

  def size
    @hash.size
  end

  def dump
    @hash.each do |k,v|
      puts "element: #{k}, #{v}"
    end
  end

  def total_items
    total = 0
    @hash.each do |k,v|
      total = total + v.size
    end
    total
  end

  def create_orgmode_entrys(f, actiontype)
    @hash.each do |key, value|
      items = value
      datestring = key
      orgmode_entry_header = '*** TODO TPL'
      entry = "#{orgmode_entry_header} #{actiontype}\nDEADLINE: #{datestring}\n"
      entry = assemble_book_list(items, entry)
      f.write(entry)
    end
  end

  def encode_into_hash(datestring, mediatitle)
    if @hash.key?(datestring)
      list = @hash[datestring]
    else
      list = []
    end
    list << format_media_title(mediatitle)
    @hash[datestring] = list
  end

  def assemble_book_list(items, entry)
    items.each do |l|
      entry += append_unordered_list_element(l)
    end
    entry
  end

  def append_checkbox_item(l)
    " - [ ] #{l}\n"
  end

  def append_unordered_list_element(l)
    " - #{l}\n"
  end

  def format_media_title(mediatitle)
    "#{mediatitle}"
  end
end
