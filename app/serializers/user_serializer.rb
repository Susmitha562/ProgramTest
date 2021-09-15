class UserSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :first_name, :email
end
