require 'rails_helper'

RSpec.describe 'Api::V1::ClockinRecords', type: :request do
  let(:user) { create(:user, name: 'fresh_user', password: '123') }
  let(:clockin_record) { create(:clockin_record, user: user) }

  describe 'GET /api/v1/clockin_records' do
    context 'when user has permission to access resource' do
      before do
        get api_v1_clockin_records_path, headers: authenticated_header(user)
      end

      it 'user cant see list another user clockin records' do
        expect(json_response[:data].count).to(eq(0))
      end

      it 'get clockin_records and return correct http status' do
        expect(response).to(have_http_status(200))
      end

      it 'returns content list with pagination metadata' do
        expect(json_response[:meta].present?).to(be(true))
      end
    end
  end

  describe 'GET /api/v1/clockin_records/:id' do
    context 'when user has permission to access resource' do
      before do
        get "/api/v1/clockin_records/#{clockin_record.id}", headers: authenticated_header(user)
      end

      it 'get clockin_record and returns correct http status' do
        expect(response).to(have_http_status(200))
      end

      it 'returns clockin_record from param id data' do
        expect(json_response[:data][:attributes][:register_type]).to(eq(clockin_record.register_type))
      end
    end
  end

  describe 'POST /api/v1/clockin_records' do
    context 'when user has permission to access resource' do
      before do
        body = {
          clockin_record: {
            register_type: 'in',
            register_date: '2020-02-19T14:08:27.998Z',
          },
        }
        post api_v1_clockin_records_path, headers: authenticated_header(user), params: body
      end

      it 'creates clockin_record and return correct http status' do
        expect(response).to(have_http_status(201))
      end

      it 'returns fresh created clockin_record from post' do
        expect(json_response[:data][:attributes][:register_type]).to(eq('in'))
        expect(json_response[:data][:attributes][:register_date]).to(eq('2020-02-19T14:08:27.998Z'))
      end
    end
  end

  describe 'PUT /api/v1/clockin_records/:id' do
    context 'when user has permission to access resource' do
      before do
        body = {
          clockin_record: {
            register_type: 'out',
          },
        }
        put "/api/v1/clockin_records/#{clockin_record.id}", headers: authenticated_header(user), params: body
      end

      it 'updates clockin_record and return correct http status' do
        expect(response).to(have_http_status(200))
      end

      it 'returns clockin_record updated from post' do
        expect(json_response[:data][:attributes][:register_type]).to(eq('out'))
        expect(json_response[:data][:attributes][:register_type]).not_to(eq('in'))
      end
    end
  end

  describe 'DELETE /api/v1/clockin_records/:id' do
    context 'when user has permission to access resource' do
      before do
        delete "/api/v1/clockin_records/#{clockin_record.id}", headers: authenticated_header(user)
      end

      it 'deletes clockin_record and return correct http status' do
        expect(response).to(have_http_status(204))
      end

      it 'clockin_record`s deleted_at field is not nil' do
        clockin_record.reload
        expect(clockin_record.deleted_at).not_to(be_nil)
      end
    end
  end
end
