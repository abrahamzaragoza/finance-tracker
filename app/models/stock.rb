class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:api_key],
      secret_token: Rails.application.credentials.iex_client[:secret_token],
      endpoint: 'https://cloud.iexapis.com/v1'
    )

    response = client.quote(ticker_symbol)
    response.to_a
    response["iex_ask_price"]
  end
end
