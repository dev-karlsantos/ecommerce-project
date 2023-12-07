Rails.configuration.stripe = {
  publishable_key: ENV["pk_test_51OKmBAGBvFhSgxo3JMjnCU0WwnYiyYqCMi7uXqzfKKb507B1RUOVOxWgZHqVgeaebczEzyhhSk3uwnZ0iFqaJy5O009ZG7DNXJ"],
  secret_key:      ENV["sk_test_51OKmBAGBvFhSgxo34RCKoy03MyRYnujhcp5cnKmliJ9SqJ9zf0zTmeAdnaGcju84dcy3Pvb5K1uPW88uiYaZhJQz00sVKIQ39K"]
}

Stripe.api_key = Rails.configuration.stripe[:publishable_key]
