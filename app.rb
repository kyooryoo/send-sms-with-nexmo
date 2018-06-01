require 'sinatra'
require 'nexmo'
require 'dotenv'
Dotenv.load

set :erb, layout: :layout

# client = Nexmo::Client.new(
#   key: ENV['NEXMO_API_KEY'],
#   secret: ENV['NEXMO_API_SECRET']
# )

get '/' do
  erb :index
end

post '/' do
  $client = Nexmo::Client.new(
    key: params['key'],
    secret: params['secret']
  )
  erb :send
end

get '/send' do
  erb :send
end

post '/send' do
  numbers = params['number']
  number_list = numbers.split("\r\n")
    
  for number in number_list
    $client.sms.send(
      from: ENV['NEXMO_NUMBER'],
      to: params['nc'] + number,
      text: params['message']
    )
    sleep 0.03
  end
  erb :send
end

##########################
get '/update' do
  choice = params['text']
  number = params['msisdn']

  # You can store or validate
  # the choice made here

  message = "Thank you for picking option #{choice}. " +
            "Your delivery is now fully scheduled in."

  nexmo.send_message(
    from: ENV['NEXMO_NUMBER'],
    to: number,
    text: message
  )

  body ''
end
