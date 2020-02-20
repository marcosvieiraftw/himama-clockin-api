class Api::V1::ClockinRecordSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :register_type, :register_date, :created_at, :updated_at
end
