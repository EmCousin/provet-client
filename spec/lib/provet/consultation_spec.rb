# frozen_string_literal: true

describe Provet::Consultation do
  let(:response) { JSON.parse(load_fixture('consultations', 'show')) }
  let(:body) { spy }
  let(:consultation_id) { '1' }

  describe '#list' do
    let(:response) { JSON.parse(load_fixture('consultations', 'index')) }

    before do
      stub_request(
        :get,
        File.join(
          Provet::Base.base_uri,
          'consultation',
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

    it 'sends a GET request to fetch the consultation list' do
      expect(described_class)
        .to receive(:get)
        .once
        .with('/consultation/', headers: headers, query: {})
        .and_return(response)
      expect(described_class.new.list).to eq(response)
    end
  end

  describe '#all' do
    let(:response) { JSON.parse(load_fixture('consultations', 'index')) }

    it 'sends a GET request to fetch consultations for each page' do
      (1..2).each do |page|
        stub_request(
          :get,
          File.join(
            Provet::Base.base_uri,
            'consultation',
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
          .with('/consultation/', headers: headers, query: { page: page })
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
          'consultation',
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

    it 'sends a GET request to fetch the consultation' do
      expect(described_class)
        .to receive(:get)
        .once
        .with('/consultation/123/', headers: headers, query: {}).and_return(response)
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

  describe 'PATCH #update' do
    it 'is not allowed' do
      expect { described_class.new.update('123', body, verb: :patch) }.to raise_error(Provet::MethodNotAllowedError)
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
