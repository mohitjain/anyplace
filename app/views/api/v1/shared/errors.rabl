child @error_object => :errors do
  node(:error_keys) { |object| object.errors.to_h }
  node(:full_messages) { |object| object.errors.full_messages}
end
