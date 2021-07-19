# frozen_string_literal: true

def headers
  {
    'Accept' => 'application/json',
    'Authorization' => "Token #{Provet.token}",
    'Content-Type' => 'application/json'
  }
end
