class QuoteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :quotes, :user_id
end
