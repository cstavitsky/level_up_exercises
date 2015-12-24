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

	# BOMB_STATES_VIEWS = {:active=>:active, :inactive, :exploded, :disarmed}

	#want this route to contain logic for each page. If bomb is :state,
	#show view for state.
	get '/' do
		@bomb = session[:bomb]
		if @bomb && more_deactivation_attempts?(@bomb)
	  	erb @bomb.state
	  elsif @bomb && !more_deactivation_attempts?(@bomb)
	  	@bomb.explode
	  else
	  	erb :index
	  end
	end

	post '/initialize' do
		act_code = params["actcode"].empty? ? "1234" : params["actcode"]
		deact_code = params["deactcode"].empty? ? "0000" : params["deactcode"]
		session[:bomb] = Bomb.new(act_code, deact_code)
		session[:deactivation_attempts] = 0
		redirect '/'
	end

	post '/activate' do
		@bomb = session[:bomb]
		@bomb.enter_code(params["actcode"])
		if @bomb.state == :active
			redirect '/'
		else
			@error = "You failed to activate the bomb."
			erb :inactive
		end
	end

	post '/deactivate' do
		@bomb = session[:bomb]
		@bomb.enter_code(params["deactcode"])
		if @bomb.state == :inactive
			redirect '/'
		else
			session[:deactivation_attempts] += 1
			redirect '/'
		end
	end

	def start_time
	  session[:start_time] ||= (Time.now).to_s
	end
	
	def more_deactivation_attempts?(bomb)
		if session[:deactivation_attempts].to_i < bomb.max_failed_deactivations
			return true
		end
		false
	end

	run! if app_file == $0
end