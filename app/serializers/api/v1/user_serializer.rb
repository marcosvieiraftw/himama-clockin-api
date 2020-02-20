class Api::V1::UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email, :created_at
end
