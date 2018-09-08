## Keep the keys in environment variables
Rails.configuration.stripe = {
  publishable_key: "pk_test_FOrDNxS9f6GDnSR2UbjlTv4B",
  secret_key: "sk_test_yMWffGbIpQ9162bnnlEiSdyu",
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
