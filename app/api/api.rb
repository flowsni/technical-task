require 'grape'
class API < Grape::API
  prefix :api
  format :json

  mount V1::SomeApi
end