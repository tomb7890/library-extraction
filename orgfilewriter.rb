class OrgfileWriter
  def initialize(f)
    @f = f
  end

  def create_entrys(xh, actiontype)
    xh.hash.each do |key, value|
      items = value
      datestring = key
      entry_header = '*** TODO TPL'
      entry = "#{entry_header} #{actiontype}\nDEADLINE: #{datestring}\n"
      entry = assemble_book_list(items, entry)
      @f.write(entry)
    end
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
end
