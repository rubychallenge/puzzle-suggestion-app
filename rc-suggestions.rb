require 'yaml'

config = YAML::load(open('config/config.yaml'))
SINATRA_ENV = config[:env] unless(defined?(SINATRA_ENV)) 

require 'rubygems'
require 'sinatra'
require 'activerecord'

require 'models/suggestion'

db_settings = YAML::load(open('config/database.yaml'))[SINATRA_ENV]
ActiveRecord::Base.establish_connection(db_settings)
  
# taken -and slightly modified- from http://sinatra.github.com/book.html#partials
helpers do
  def partial(template, *args)
    options = args.extract_options!
    options.merge!(:layout => false)
    if collection = options.delete(:collection) then
      collection.inject([]) do |buffer, member|
        buffer << haml("_#{template}".to_sym, options.merge(
                                  :layout => false, 
                                  :locals => {template.to_sym => member} # :todo = <Todo:3e345>
                                )
                     )
      end.join("\n")
    else
      haml(template, options)
    end
  end  
end    

#css
get '/public/stylesheets/main.css' do
  content_type 'text/css', :charset => 'utf-8'
end

#index
get '/' do
  @suggestions = Suggestion.all(:order => "id DESC");
  
  haml :index  
end

#show
get %r{/suggestions/([\d]+)} do
  id = params[:captures].first
  @suggestion = Suggestion.find(id)

  haml :show
end

#create
post '/suggestions' do
  s = Suggestion.create(:title => params[:title], 
                        :author => params[:author],
                        :tags => params[:tags],
                        :description => params[:description])
  partial(:suggestion, :collection => [s])
end