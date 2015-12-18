# run `ruby overlord.rb` to run a webserver for this app


require_relative 'lib/bomb'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'tilt'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "postgresql",
  :host     => "localhost",
  :username => "cstavitsky",
  :database => "bombs"
)

Tilt.register Tilt::ERBTemplate, 'html.erb'

class Overlord < Sinatra::Base
	enable :sessions

	get '/' do
		@bomb = session[:bomb]
	    erb :index
	end

	post '/' do
		act_code = params["actcode"].empty? ? "1234" : params["actcode"]
		deact_code = params["deactcode"].empty? ? "0000" : params["deactcode"]
		session[:bomb] = Bomb.new(act_code, deact_code)
		redirect '/activate'
	end

	get '/activate' do
		@bomb = session[:bomb]
		erb :activate
	end

	post '/activate' do
		@bomb = session[:bomb]
		@bomb.enter_code(params["actcode"])
		if @bomb.state == :active
			redirect '/active_bomb'
		else
			@error = "You failed to activate the bomb."
			erb :activate
		end
	end

	get '/active_bomb' do
		@bomb = session[:bomb]
		erb :active_bomb
	end

	# we can shove stuff into the session cookie YAY!
	def start_time
	  session[:start_time] ||= (Time.now).to_s
	end

	run! if app_file == $0
end