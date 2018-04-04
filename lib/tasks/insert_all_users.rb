require 'json'
require 'uri'
require 'net/http'

p Settings.slack_token
uri = URI.parse("https://slack.com/api/users.list?token=#{Settings.slack_token}&pretty=1")
json = Net::HTTP.get(uri)
result = JSON.parse(json)
members = result["members"]

admin_users = ['1060ki', '30000000', 'ko', 'koniatsu', 'pokotsun', 'sono', 'uzaki', 'yusk', 'takumi', 'nomiyamade']

members.each do |user|
  if user['is_bot'] == false
    member = User.new(
      :username => user['name'],
      :is_admin => false,
      :email => "",
      :password => "Planningdev2013!")
    if admin_users.include?(user['name'])
      member.is_admin = true
      p user['name']
      p user["real_name"]
      p user["profile"]["email"]
      p user["is_bot"]
      p user["is_admin"]
      p user["is_owner"]
    end
    member.save!
  end
end
