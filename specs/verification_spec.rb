# frozen_string_literal: true

require 'airborne'

describe '/verify' do
  let(:url) { 'http://localhost:9292/verify?id=%{id}&code=%{code}&owner=%{owner}' }
  let(:correct_card_codes) do
    { 'AMEX' => 378_282_246_310_005,
      'AMEX' => 371_449_635_398_431,
      'MASTERCARD' => 5_555_555_555_554_444,
      'MASTERCARD' => 5_105_105_105_105_100,
      'VISA' => 4_111_111_111_111_111,
      'VISA' => 4_012_888_888_881_881 }
  end
  let(:incorrect_card_codes) do
    %w[1234567890
       3122343433]
  end

  it 'should get valid card_provider (hash key)' do
    id_ = 0
    correct_card_codes.each do |p, c|
      get format(url, id: id_.to_s, code: c.to_s, owner: "Owner_#{id_}")
      expect_status '200'
      expect_json("{\"provider\":\"#{p}\"}")
      id_ += 1
    end
  end

  it 'should get INVALID card_provider (always INVALID!)' do
    id_ = 0
    incorrect_card_codes.each do |c|
      get format(url, id: id_.to_s, code: c.to_s, owner: "Owner_#{id_}")
      expect_json("{\"provider\":\"#{"INVALID"}\"}")
      id_ += 1
    end
  end
end
