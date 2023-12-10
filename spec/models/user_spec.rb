# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.build(:user) }

  describe 'when all fields are present' do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:password) }
    it { is_expected.to respond_to(:password_confirmation) }
  end

  describe 'validations' do
    describe 'presence validations' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }
    end

    describe 'email validations' do
      it { is_expected.to allow_value('example@domain.com').for(:email) }
      it { is_expected.not_to allow_value('example.domain.com').for(:email) }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    end

    describe 'password validations' do
      it { is_expected.to validate_confirmation_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(6) }
    end

    describe 'when creating a user with an invalid email' do
      let(:user_with_invalid_email) { FactoryBot.build(:user, email: 'invalid_email') }

      it 'is not valid' do
        expect(user_with_invalid_email).not_to be_valid
      end
    end

    describe 'when creating a user without an email' do
      let(:user_without_email) { FactoryBot.build(:user, email: nil) }

      it 'is not valid' do
        expect(user_without_email).not_to be_valid
      end
    end
  end
end
