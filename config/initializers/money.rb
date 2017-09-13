
MoneyRails.configure do |config|
  config.default_currency = :sek

  config.amount_column = {prefix: '', # column name prefix
                          postfix: '_cents', # column name  postfix
                          column_name: nil, # full column name (overrides prefix, postfix and accessor name)
                          type: :integer, # column type
                          present: true, # column will be created
                          null: false, # other options will be treated as column options
                          default: 0
  }

  config.add_rate 'USD', 'SEK', 1
end


