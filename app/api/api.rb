require 'grape'
class API < Grape::API
  prefix :api
  format :json

  mount V1::LetterApi
end