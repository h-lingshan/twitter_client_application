require 'openssl' if Rails.env.development?
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE  if Rails.env.development? #windowsの環境でエラーが起きるのを防ぐように追加
class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :recommendations, :init_follow, :followers, :add_follow, :show_tweet, :save_tweet]
  before_action :init, only: [:init_follow, :followers, :add_follow]
  def home  
   
  end

  def show
    init_follow if user_signed_in? && current_user.sign_in_count == 1
    recommendations if user_signed_in? && current_user.sign_in_count > 1
    time_line if user_signed_in? && current_user.sign_in_count > 1
  end
  
  def recommendations
    init
    @follows = @client.suggest_users("twitter")
  end

  def time_line
    init
    max_id = params[:max_id] == nil ? @client.home_timeline.first.id : params[:max_id]
    @feed_items = @client.home_timeline(:max_id => max_id, :count => 10)
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def time_line_max_id
    init 
    @max_id = @client.home_timeline.first.id
    respond_to do |format|
      format.js
      format.html
    end
  end

  def init_follow
    @follows = []
    @follows.push(@client.user("jack"))
    @follows.push(@client.user("yukihiro_matz"))
    @follows.push(@client.user("JeffBezos"))
  end

  def followers
    @users = @client.friends(current_user.username)
  end

  def add_follow
    @client.follow(params[:username])
  end
  
  def show_tweet
    @tweet_note = TweetNote.where(user_uid: current_user.uid)
    render "tweet"
  end

  def save_tweet
    tweet = params[:text]
    author = params[:username]
    TweetNote.create(tweet_author: author,tweet: tweet,user_uid: current_user.uid)
  end
  
  private
  def init
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "yQcoTY5x3VBDqqKkRG83PZvhA"
      config.consumer_secret = "zgnBzIfUwc9EHt2Brtswmm19wxQJXs4WevOrb09YLc3jg8cuNZ"
      config.access_token = "901767061122162690-aod8pad80zHKNrxaqXsia8JZeLvecXG"
      config.access_token_secret = "3CbTBl0LHE0pr7FZBishjvnvMo0G9FpBy8GeLaefkrnnF"
    end
  end
end
