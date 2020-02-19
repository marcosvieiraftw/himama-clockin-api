require 'rails_helper'

RSpec.describe(ClockinRecord, type: :model) do
  describe 'validates fields' do
    subject { build(:clockin_record) }

    context 'presence and enum' do
      it { is_expected.to(validate_presence_of(:register_type)) }
      it { is_expected.to(validate_presence_of(:register_date)) }
      it { is_expected.to(define_enum_for(:register_type).with_values(in: 1, out: 0)) }
    end

    context 'association' do
      it { is_expected.to(belong_to(:user)) }
    end
  end
end
