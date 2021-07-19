# frozen_string_literal: true

describe Provet::Availability do
  let(:response) { JSON.parse(load_fixture('availability', 'success')) }

  describe '#list' do
    before do
      stub_request(:get, File.join(Provet::Base.base_uri, 'veterinarians_availibility', '/'))
        .with(headers: headers)
        .to_return(
          status: 200,
          headers: { content_type: 'application/json' },
          body: response.to_json
        )
    end

    it 'sends a GET request to fetch the availablity list' do
      expect(described_class)
        .to receive(:get)
        .once
        .with('/veterinarians_availibility/', headers: headers, query: {})
        .and_return(response)
      expect(described_class.new.list).to eq(response)
    end
  end

  describe '#all' do
    it 'sends a GET request to fetch availabilities for each page' do
      (1..2).each do |page|
        stub_request(:get, File.join(Provet::Base.base_uri, 'veterinarians_availibility', "/?page=#{page}"))
          .with(headers: headers)
          .to_return(
            status: 200,
            headers: { content_type: 'application/json' },
            body: response.to_json
          )

        expect(described_class)
          .to receive(:get)
          .once
          .with('/veterinarians_availibility/', headers: headers, query: { page: page })
          .and_return(response)
      end

      described_class.new.all
    end
  end
end
