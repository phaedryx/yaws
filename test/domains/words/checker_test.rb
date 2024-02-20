# frozen_string_literal: true

require "test_helper"

describe ::Words::Checker do
  before do
    @overrides = {}
    @guess     = ""
    @actual    = ""
  end

  let(:result) { ::Words::Checker.new(**@overrides).call(guess: @guess, actual: @actual) }

  it "checks for truth" do
    _(true).must_equal(true)
  end

  describe ".call" do
    it "fails if the guess has non-alpha characters"
    it "fails if the guess has uppercase characters"
    it "fails if the guess is less than 5 characters"
    it "fails if the guess is more than 5 characters"
    it "returns [1,-1,-1,-1,-1] if there is an exact match on the first letter only"
  end
end
