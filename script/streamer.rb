# -*- coding: utf-8 -*-
require 'em-websocket'
require 'em-twitter'
require 'yaml'
require 'json'

env = YAML.load_file(File.dirname(__FILE__)+'/config.yml')
count = 0

OPTION = { 
  :path => "/1/statuses/filter.json",
  :params => {:track => "#koryosai"},
  #:params => {:track => "#nowplaying"},
  :oauth => {
    :consumer_key => env['CONSUMER_KEY'],
    :consumer_secret => env['CONSUMER_SECRET'],
    :token => env['ACCESS_TOKEN'],
    :token_secret => env['ACCESS_TOKEN_SECRET']
  }
}

EM::run do
  puts 'server start'
  @channel = EM::Channel.new
  @client =  EM::Twitter::Client.connect(OPTION)

  EM::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|

    ws.onopen do
      sid = @channel.subscribe do |mes|
        ws.send(mes)
      end
      #@channel.push("open")
    end

    ws.onmessage do |mes|
      p mes
      @channel.push(mes)
     end

    ws.onclose do
    end
  end

  EM::defer do
    @client.each do |result|
      tweet = JSON::parse(result)
      tweet[:type] = 0
      tweet[:private_id] = count
      count += 1
      p tweet
      @channel.push(tweet.to_json)
    end 
  end

end
