require 'json'
require 'uri'
require 'net/http'

p Settings.slack_token
uri = URI.parse("https://slack.com/api/users.list?token=#{Settings.slack_token}&pretty=1")
json = Net::HTTP.get(uri)
result = JSON.parse(json)
members = result["members"]

members.each do |user|
  begin
    if user['is_bot'] == false
      member = User.new(
        :username => user['name'],
        :is_admin => false,
        :email => "",
        :password => user['name'])
        p user['name']
        p user["real_name"]
        p user["profile"]["email"]
        p user["is_bot"]
        p user["is_admin"]
        p user["is_owner"]
        member.save!
      end
    rescue => e
      p user['name']
      p "でエラーが生じました！"
    end


  end
