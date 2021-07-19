# frozen_string_literal: true

describe Provet::ConsultationDischargeInstruction do
  let(:response) { JSON.parse(load_fixture('consultation_discharge_instructions', 'show')) }
  let(:body) { spy }
  let(:consultation_id) { '1' }

  describe '#list' do
    let(:response) { JSON.parse(load_fixture('consultation_discharge_instructions', 'index')) }

    before do
      stub_request(
        :get,
        File.join(
          Provet::Base.base_uri,
          'consultation',
          consultation_id,
          'consultationdischargeinstruction',
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

    it 'sends a GET request to fetch the discharge instruction list' do
      expect(described_class)
        .to receive(:get)
        .once
        .with("/consultation/#{consultation_id}/consultationdischargeinstruction/", headers: headers, query: {})
        .and_return(response)
      expect(described_class.new(consultation_id: consultation_id).list).to eq(response)
    end
  end

  describe '#all' do
    let(:response) { JSON.parse(load_fixture('consultation_discharge_instructions', 'index')) }

    it 'sends a GET request to fetch discharge instructions for each page' do
      (1..2).each do |page|
        stub_request(
          :get,
          File.join(
            Provet::Base.base_uri,
            'consultation',
            consultation_id,
            'consultationdischargeinstruction',
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
          .with("/consultation/#{consultation_id}/consultationdischargeinstruction/", headers: headers, query: { page: page })
          .and_return(response)
      end

      described_class.new(consultation_id: consultation_id).all
    end
  end

  describe '#find' do
    before do
      stub_request(
        :get,
        File.join(
          Provet::Base.base_uri,
          'consultation',
          consultation_id,
          'consultationdischargeinstruction',
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

    it 'sends a GET request to fetch the discharge instruction' do
      expect(described_class)
        .to receive(:get)
        .once
        .with("/consultation/#{consultation_id}/consultationdischargeinstruction/123/", headers: headers, query: {}).and_return(response)
      expect(described_class.new(consultation_id: consultation_id).find('123')).to eq(response)
    end
  end

  describe '#create' do
    before do
      stub_request(
        :post,
        File.join(
          Provet::Base.base_uri,
          'consultation',
          consultation_id,
          'consultationdischargeinstruction',
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

    it 'sends a POST request to create an discharge instruction' do
      expect(described_class)
        .to receive(:post)
        .once
        .with("/consultation/#{consultation_id}/consultationdischargeinstruction/", headers: headers, body: body)
        .and_return(response)
      expect(described_class.new(consultation_id: consultation_id).create(body)).to eq(response)
    end
  end

  describe '#update' do
    before do
      stub_request(
        :put,
        File.join(
          Provet::Base.base_uri,
          'consultation',
          consultation_id,
          'consultationdischargeinstruction',
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

    it 'sends a PUT request to update the discharge instruction' do
      expect(described_class)
        .to receive(:put)
        .once
        .with("/consultation/#{consultation_id}/consultationdischargeinstruction/123/", headers: headers, body: body)
        .and_return(response)
      expect(described_class.new(consultation_id: consultation_id).update('123', body)).to eq(response)
    end
  end

  describe 'PATCH #update' do
    before do
      stub_request(
        :patch,
        File.join(
          Provet::Base.base_uri,
          'consultation',
          consultation_id,
          'consultationdischargeinstruction',
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

    it 'sends a PATCH request to update the discharge instruction' do
      expect(described_class)
        .to receive(:patch)
        .once
        .with("/consultation/#{consultation_id}/consultationdischargeinstruction/123/", headers: headers, body: body)
        .and_return(response)
      expect(described_class.new(consultation_id: consultation_id).update('123', body, verb: :patch)).to eq(response)
    end
  end

  describe '#destroy' do
    it 'is not allowed' do
      expect { described_class.new(consultation_id: consultation_id).destroy('123') }.to raise_error(Provet::MethodNotAllowedError)
    end
  end

  describe '#restore' do
    it 'is not allowed' do
      expect { described_class.new(consultation_id: consultation_id).restore('123') }.to raise_error(Provet::MethodNotAllowedError)
    end
  end
end
