=begin
This spec class handles all thes tests related to states class
=end

require 'spec_helper'

describe States do
  subject(:states) do
    States.new
  end
  it "returs true if state id is valid" do
    expect(states.valid?(1)).to eq(true)
    expect(states.valid?(8)).to eq(true)
  end

  it "returs false if state id is invalid" do
    expect(states.valid?(0)).to eq(false)
    expect(states.valid?(9)).to eq(false)
  end

  it "gets the valid state name when searched by id" do
    expect(states.get_name(1)).to eq("Tasmania")
    expect(states.get_name(2)).to eq("Victoria")
    expect(states.get_name(3)).to eq("New South Wales")
    expect(states.get_name(4)).to eq("Australia Capital Territory")
    expect(states.get_name(5)).to eq("Queensland")
    expect(states.get_name(6)).to eq("Northern Territory")
    expect(states.get_name(7)).to eq("South Australia")
    expect(states.get_name(8)).to eq("Western Australia")
  end

  it "gets nil if the state id is wrong" do
    expect(states.get_name(0)).to be_nil
  end
end