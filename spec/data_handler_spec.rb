=begin
This spec class handles the testcases required for Fata handler class
=end

require 'spec_helper'

describe DataHandler do
  subject(:handler) do
    DataHandler.new
  end

  it 'parse the csv file' do
    handler.parse_file(false, 'spec/fixtures/data.csv')

    expect(handler.errors.length).to eq(1)
    expect(handler.errors[0][:error]).to eq(DataHandler::POSTCODE_ERROR)

    expect(handler.warnings.length).to eq(3)
    expect(handler.warnings[0][:warning]).to eq(DataHandler::NAME_WARNING)
    expect(handler.warnings[1][:warning]).to eq(DataHandler::STATE_WARNING)
    expect(handler.warnings[2][:warning]).to eq(DataHandler::SALARY_WARNING)
  end

  it 'validate the warning data' do
    user = {:name=>"Tom", :state=>1, :salary=>25000, :date_of_birth=>19970919, :postcode=>3072}
    expect(handler.validate(user)).to eq(DataHandler::NAME_WARNING)

    user = {:name=>"TomTom", :state=>0, :salary=>25000, :date_of_birth=>19970919, :postcode=>3072}
    expect(handler.validate(user)).to eq(DataHandler::STATE_WARNING)

    user = {:name=>"TomTom", :state=>1, :salary=>25000.01, :date_of_birth=>19970919, :postcode=>3072}
    expect(handler.validate(user)).to eq(DataHandler::SALARY_WARNING)
  end

  it 'validate the error data' do
    user = {:name=>"Tom", :state=>0, :salary=>25000, :date_of_birth=>19970919}
    expect{ handler.validate(user) }.to raise_error(DataHandler::POSTCODE_ERROR)
  end

  it 'validate the correct data' do
    user = {:name=>"TomTom", :state=>1, :salary=>25000, :date_of_birth=>19970919, :postcode=>3072}
    expect(handler.validate(user)).to be_nil
  end
end