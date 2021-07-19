# frozen_string_literal: true

describe Provet::Invoice do
  let(:response) { JSON.parse(load_fixture('invoices', 'show')) }
  let(:body) { spy }

  describe '#list' do
    let(:response) { JSON.parse(load_fixture('invoices', 'index')) }

    before do
      stub_request(
        :get,
        File.join(
          Provet::Base.base_uri,
          'invoice',
          '/'
        )
      ).with(
        headers: headers
      ).to_return(
        status: 200,
        headers: { content_type: 'application/json' },
        body: response.to_json
      )
    end

    it 'sends a GET request to fetch the invoice list' do
      expect(described_class)
        .to receive(:get)
        .once
        .with('/invoice/', headers: headers, query: {})
        .and_return(response)
      expect(described_class.new.list).to eq(response)
    end
  end

  describe '#all' do
    let(:response) { JSON.parse(load_fixture('invoices', 'index')) }

    it 'sends a GET request to fetch invoices for each page' do
      (1..2).each do |page|
        stub_request(
          :get,
          File.join(
            Provet::Base.base_uri,
            'invoice',
            "/?page=#{page}"
          )
        ).with(
          headers: headers
        ).to_return(
          status: 200,
          headers: { content_type: 'application/json' },
          body: response.to_json
        )

        expect(described_class)
          .to receive(:get)
          .once
          .with('/invoice/', headers: headers, query: { page: page })
          .and_return(response)
      end

      described_class.new.all
    end
  end

  describe '#find' do
    before do
      stub_request(
        :get,
        File.join(
          Provet::Base.base_uri,
          'invoice',
          '123',
          '/'
        )
      ).with(
        headers: headers
      ).to_return(
        status: 200,
        headers: { content_type: 'application/json' },
        body: response.to_json
      )
    end

    it 'sends a GET request to fetch the invoice' do
      expect(described_class)
        .to receive(:get)
        .once
        .with('/invoice/123/', headers: headers, query: {}).and_return(response)
      expect(described_class.new.find('123')).to eq(response)
    end
  end

  describe '#create' do
    it 'is not allowed' do
      expect { described_class.new.create(body) }.to raise_error(Provet::MethodNotAllowedError)
    end
  end

  describe '#update' do
    before do
      stub_request(
        :put,
        File.join(
          Provet::Base.base_uri,
          'invoice',
          '123',
          '/'
        )
      ).with(
        headers: headers,
        body: body.to_json
      ).to_return(
        status: 200,
        headers: { content_type: 'application/json' },
        body: response.to_json
      )
    end

    it 'sends a PUT request to update the invoice' do
      expect(described_class)
        .to receive(:put)
        .once
        .with('/invoice/123/', headers: headers, body: body)
        .and_return(response)
      expect(described_class.new.update('123', body)).to eq(response)
    end
  end

  describe 'PATCH #update' do
    before do
      stub_request(
        :patch,
        File.join(
          Provet::Base.base_uri,
          'invoice',
          '123',
          '/'
        )
      ).with(
        headers: headers,
        body: body.to_json
      ).to_return(
        status: 200,
        headers: { content_type: 'application/json' },
        body: response.to_json
      )
    end

    it 'sends a PATCH request to update the invoice' do
      expect(described_class)
        .to receive(:patch)
        .once
        .with('/invoice/123/', headers: headers, body: body)
        .and_return(response)
      expect(described_class.new.update('123', body, verb: :patch)).to eq(response)
    end
  end

  describe '#destroy' do
    it 'is not allowed' do
      expect { described_class.new.destroy('123') }.to raise_error(Provet::MethodNotAllowedError)
    end
  end

  describe '#restore' do
    it 'is not allowed' do
      expect { described_class.new.restore('123') }.to raise_error(Provet::MethodNotAllowedError)
    end
  end
end
