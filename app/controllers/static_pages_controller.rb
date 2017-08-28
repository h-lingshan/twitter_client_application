require 'openssl' if Rails.env.development?
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE  if Rails.env.development?
class StaticPagesController < ApplicationController
  def home  
    
  end

  def show
    init_follow if user_signed_in? && current_user.sign_in_count == 1
    recommendations if user_signed_in? && current_user.sign_in_count > 1
  end
  
  def recommendations
    init
    @follows = @client.suggest_users("twitter")
  end

  def init_follow
    init 
    @follows = []
    @follows.push(@client.user("jack"))
    @follows.push(@client.user("yukihiro_matz"))
    @follows.push(@client.user("JeffBezos"))
  end

  def followers
    init
    @title = "followers"
    @users = @client.friends(current_user.username)
  end

  def add_follow(user_name)
    init
    @client.follow(user_name)
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