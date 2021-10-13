require 'yaml/store'
require 'sinatra'

get '/' do
  @title = 'What do you fancy??!'
  erb :index
end

Choices = {
  'HAM' => 'Ham',
  'PIZ' => 'Pi',
  'CUR' => 'Cur',
  'NOO' => 'Nood',
}

post '/cast' do
  @title = 'Thanks for choosing!'
  @vote  = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end