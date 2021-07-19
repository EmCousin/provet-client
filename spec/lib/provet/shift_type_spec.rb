# frozen_string_literal: true

describe Provet::ShiftType do
  let(:response) { JSON.parse(load_fixture('shift_types', 'show')) }
  let(:body) { spy }

  describe '#list' do
    let(:response) { JSON.parse(load_fixture('shift_types', 'index')) }

    before do
      stub_request(:get, File.join(Provet::Base.base_uri, 'shifttype', '/'))
        .with(headers: headers)
        .to_return(
          status: 200,
          headers: { content_type: 'application/json' },
          body: response.to_json
        )
    end

    it 'sends a GET request to fetch the shift types list' do
      expect(described_class)
        .to receive(:get)
        .once
        .with('/shifttype/', headers: headers, query: {})
        .and_return(response)
      expect(described_class.new.list).to eq(response)
    end
  end

  describe '#all' do
    let(:response) { JSON.parse(load_fixture('shift_types', 'index')) }

    it 'sends a GET request to fetch shift types for each page' do
      (1..2).each do |page|
        stub_request(:get, File.join(Provet::Base.base_uri, 'shifttype', "/?page=#{page}"))
          .with(headers: headers)
          .to_return(
            status: 200,
            headers: { content_type: 'application/json' },
            body: response.to_json
          )

        expect(described_class)
          .to receive(:get)
          .once
          .with('/shifttype/', headers: headers, query: { page: page })
          .and_return(response)
      end

      described_class.new.all
    end
  end

  describe '#find' do
    before do
      stub_request(:get, File.join(Provet::Base.base_uri, 'shifttype', '123', '/'))
        .with(headers: headers)
        .to_return(
          status: 200,
          headers: { content_type: 'application/json' },
          body: response.to_json
        )
    end

    it 'sends a GET request to fetch the shift type' do
      expect(described_class)
        .to receive(:get)
        .once
        .with('/shifttype/123/', headers: headers, query: {}).and_return(response)
      expect(described_class.new.find('123')).to eq(response)
    end
  end

  describe '#create' do
    it 'is not allowed' do
      expect { described_class.new.create(body) }.to raise_error(Provet::MethodNotAllowedError)
    end
  end

  describe '#update' do
    it 'is not allowed' do
      expect { described_class.new.update('123', body) }.to raise_error(Provet::MethodNotAllowedError)
    end
  end

  describe '#destroy' do
    it 'is not allowed' do
      expect { described_class.new.destroy('123') }.to raise_error(Provet::MethodNotAllowedError)
    end
  end
end
