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
    it "fails if the guess has non-alpha characters" do
      @guess = "B2_4A"
      @actual = "aaaaa"

      _(result.failure?).must_equal(true)
      _(result.failure).must_equal(:non_alpha_error)
    end

    it "fails if the guess has uppercase characters" do
      @guess =  "Aaaaa"
      @actual = "aaaaa"

      _(result.failure?).must_equal(true)
      _(result.failure).must_equal(:upper_case_error)
    end

    it "fails if the guess length is different than actual length" do
      @guess =  "aaaa"
      @actual = "aaaaa"

      _(result.failure?).must_equal(true)
      _(result.failure).must_equal(:length_error)
    end

    it "returns [1] for guess `a` and actual `a` " do
      @guess = "a"
      @actual = "a"

      _(result.success?).must_equal(true)
      _(result.success).must_equal([1])
    end

    it "returns an array of 1's equal to the length of the guess if it is an exact match" do
      length = rand(20)
      @actual = ("a".."z").to_a.sample(length).join
      @guess = @actual

      _(result.success?).must_equal(true)
      _(result.success).must_equal(Array.new(length, 1))
    end
  end
end
