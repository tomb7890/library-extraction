require_relative '../tpl'

describe 'tests' do
  before(:all) do
    @tpl = Tpl.new
    @tpl.cachefile = 'spec/data/cache-13-april-2016.html'
    @tpl.parse(@tpl.local_html)
  end

  it 'correctly finds items for pickup' do
    expect(@tpl.num_items_available_for_pickup).to eq(1)
  end

  it 'correctly finds outstanding holds' do
    num_outstanding_holds = 4
    expect(num_outstanding_holds).to eq(4)
  end

  it 'correctly counts checked out items' do
    expect(@tpl.total_checked_out_items).to eq(13)
  end

  it 'correctly finds a known ready title' do
    expect(@tpl.readyforpickup_titles).to eq([['Gangs of New York [videorecording]']])
  end
end
