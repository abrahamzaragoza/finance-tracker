class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:api_key],
      secret_token: Rails.application.credentials.iex_client[:secret_token],
      endpoint: 'https://cloud.iexapis.com/v1'
    )

    begin
      stock_data = client.quote(ticker_symbol)
      stock_data.to_a

      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: stock_data["latest_price"])
    rescue => exception
      return nil
    end
  end
end
