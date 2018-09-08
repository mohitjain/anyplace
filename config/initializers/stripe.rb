Rails.configuration.stripe = {
  publishable_key: "pk_test_****",
  secret_key: "sk_test_***",
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
