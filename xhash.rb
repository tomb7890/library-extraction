# This class is a wrapper for a Hash used to store dates and actions
# gathered from the TPL website, used as input for creation
# of an Emacs Org Mode file.
class Xhash
  attr_reader :hash

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
    @hash.each do |k, v|
      puts "element: #{k}, #{v}"
    end
  end

  def total_items
    total = 0
    @hash.each do |_k, v|
      total += v.size
    end
    total
  end

  def encode_into_hash(datestring, mediatitle)
    if @hash.key?(datestring)
      list = @hash[datestring]
    else
      list = []
    end
    list << mediatitle
    @hash[datestring] = list
  end
end
