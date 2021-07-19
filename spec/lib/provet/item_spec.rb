# frozen_string_literal: true

describe Provet::Item do
  let(:response) { JSON.parse(load_fixture('items', 'show')) }
  let(:body) { spy }
  let(:item) { 'medicine' }

  describe '#list' do
    let(:response) { JSON.parse(load_fixture('items', 'index')) }

    before do
      stub_request(:get, File.join(Provet::Base.base_uri, item, '/'))
        .with(headers: headers)
        .to_return(
          status: 200,
          headers: { content_type: 'application/json' },
          body: response.to_json
        )
    end

    it 'sends a GET request to fetch the item list' do
      expect(described_class)
        .to receive(:get)
        .once
        .with("/#{item}/", headers: headers, query: {})
        .and_return(response)
      expect(described_class.new(type_code: item).list).to eq(response)
    end
  end

  describe '#all' do
    let(:response) { JSON.parse(load_fixture('items', 'index')) }

    it 'sends a GET request to fetch items for each page' do
      (1..2).each do |page|
        stub_request(:get, File.join(Provet::Base.base_uri, item, "/?page=#{page}"))
          .with(headers: headers)
          .to_return(
            status: 200,
            headers: { content_type: 'application/json' },
            body: response.to_json
          )

        expect(described_class)
          .to receive(:get)
          .once
          .with("/#{item}/", headers: headers, query: { page: page })
          .and_return(response)
      end

      described_class.new(type_code: item).all
    end
  end

  describe '#find' do
    before do
      stub_request(:get, File.join(Provet::Base.base_uri, item, '123', '/'))
        .with(headers: headers)
        .to_return(
          status: 200,
          headers: { content_type: 'application/json' },
          body: response.to_json
        )
    end

    it 'sends a GET request to fetch the item' do
      expect(described_class)
        .to receive(:get)
        .once
        .with("/#{item}/123/", headers: headers, query: {}).and_return(response)
      expect(described_class.new(type_code: item).find('123')).to eq(response)
    end
  end

  describe '#create' do
    before do
      stub_request(:post, File.join(Provet::Base.base_uri, item, '/'))
        .with(
          headers: headers,
          body: body.to_json
        ).to_return(
          status: 200,
          headers: { content_type: 'application/json' },
          body: response.to_json
        )
    end

    it 'sends a POST request to create an item' do
      expect(described_class)
        .to receive(:post)
        .once
        .with("/#{item}/", headers: headers, body: body)
        .and_return(response)
      expect(described_class.new(type_code: item).create(body)).to eq(response)
    end
  end

  describe '#update' do
    before do
      stub_request(:put, File.join(Provet::Base.base_uri, item, '123', '/'))
        .with(
          headers: headers,
          body: body.to_json
        ).to_return(
          status: 200,
          headers: { content_type: 'application/json' },
          body: response.to_json
        )
    end

    it 'sends a PUT request to update the item' do
      expect(described_class)
        .to receive(:put)
        .once
        .with("/#{item}/123/", headers: headers, body: body)
        .and_return(response)
      expect(described_class.new(type_code: item).update('123', body)).to eq(response)
    end
  end

  describe '#destroy' do
    let(:body) { { archived: 1 } }

    before do
      stub_request(:patch, File.join(Provet::Base.base_uri, item, '123', '/'))
        .with(
          headers: headers,
          body: body.to_json
        ).to_return(
          status: 200,
          headers: { content_type: 'application/json' },
          body: response.to_json
        )
    end

    it 'sends a PATCH request to mark the appointment as inactive' do
      expect(described_class)
        .to receive(:patch)
        .once
        .with("/#{item}/123/", headers: headers, body: body.to_json)
        .and_return(response)
      expect(described_class.new(type_code: item).destroy('123')).to eq(response)
    end
  end

  describe '#really_destroy!' do
    before do
      stub_request(:delete, File.join(Provet::Base.base_uri, item, '123', '/'))
        .with(headers: headers)
        .to_return(status: 204)
    end

    it 'sends a DELETE request to erase the item' do
      expect(described_class)
        .to receive(:delete)
        .once
        .with("/#{item}/123/", headers: headers)
      described_class.new(type_code: item).really_destroy!('123')
    end
  end

  describe '#restore' do
    let(:body) { { archived: 0 } }

    before do
      stub_request(:patch, File.join(Provet::Base.base_uri, item, '123', '/'))
        .with(
          headers: headers,
          body: body.to_json
        ).to_return(
          status: 200,
          headers: { content_type: 'application/json' },
          body: response.to_json
        )
    end

    it 'sends a PATCH request to mark the appointment as active' do
      expect(described_class)
        .to receive(:patch)
        .once
        .with("/#{item}/123/", headers: headers, body: body.to_json)
        .and_return(response)
      expect(described_class.new(type_code: item).restore('123')).to eq(response)
    end
  end
end
