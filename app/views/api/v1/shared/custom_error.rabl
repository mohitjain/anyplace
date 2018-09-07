child :errors do
  node(:error_keys) { |object| {} }
  node(:full_messages) { |object| @full_messages }
end
