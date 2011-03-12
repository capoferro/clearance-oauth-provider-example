Factory.sequence :client_secret do |n|
  "secretsecret#{n}"
end

Factory.sequence :client_id do |n|
  "client_id#{n}"
end

Factory.define :application do |a|
  a.url 'http://appurl.com'
  a.redirect_uri 'http://appurl.com/redirect/uri'
  a.client_secret { Factory.next :client_secret }
  a.client_id { Factory.next :client_id }
  a.user { |a| a.association :user }
end
