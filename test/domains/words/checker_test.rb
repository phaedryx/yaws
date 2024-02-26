# frozen_string_literal: true

require "test_helper"

# rubocop:disable Metrics/BlockLength

# Rules
# ----------
# Letters that are in the answer and in the right place turn green.
# Letters that are in the answer but in the wrong place turn yellow.
# Letters that are not in the answer turn gray.
# A particular letter (e.g. 'N') will only 'light up' (be colored green or yellow) as many times as it is in the word.
# If you repeat a letter more times than it is contained in the word, and one of the repeated letters is in the correct
#   position, that letter will always light up in green.
# If you repeat a letter more times than it is contained in the word, but none of the repeated letters is in the correct
#   position, the first letter will light up in yellow.

describe ::Words::Checker do
  before do
    @overrides = {}
    @guess     = ""
    @answer    = ""
  end

  let(:result) { ::Words::Checker.new(**@overrides).call(guess: @guess, answer: @answer) }

  it "checks for truth" do
    _(true).must_equal(true)
  end

  describe ".call" do
    it "fails if the guess has non-alpha characters" do
      @guess = "B2_4A"
      @answer = "aaaaa"

      _(result.failure?).must_equal(true)
      _(result.failure).must_equal(:non_alpha_error)
    end

    it "fails if the guess has uppercase characters" do
      @guess =  "Aaaaa"
      @answer = "aaaaa"

      _(result.failure?).must_equal(true)
      _(result.failure).must_equal(:upper_case_error)
    end

    it "fails if the guess length is different than answer length" do
      @guess =  "aaaa"
      @answer = "aaaaa"

      _(result.failure?).must_equal(true)
      _(result.failure).must_equal(:length_error)
    end

    it "returns [1] with a guess of 'a' and an answer of 'a'" do
      @guess = "a"
      @answer = "a"

      _(result.success?).must_equal(true)
      _(result.success).must_equal([1])
    end

    it "returns an array of 1's equal to the length of the guess if it is an exact match" do
      length = rand(20)
      @answer = ("a".."z").to_a.sample(length).join
      @guess = @answer

      _(result.success?).must_equal(true)
      _(result.success).must_equal(Array.new(length, 1))
    end

    [
      { guess: "a", answer: "b", result: [-1] },
      { guess: "aa", answer: "bb", result: [-1, -1] },
      { guess: "ab", answer: "ac", result: [1, -1] },
      { guess: "ab", answer: "cb", result: [-1, 1] },
      { guess: "ab", answer: "bc", result: [-1, 0] },
      { guess: "ab", answer: "ca", result: [0, -1] },
      { guess: "ab", answer: "ba", result: [0, 0] },
      { guess: "abc", answer: "bac", result: [0, 0, 1] },
      { guess: "abc", answer: "acb", result: [1, 0, 0] },
      { guess: "aba", answer: "abb", result: [1, 1, -1] },
      { guess: "babes", answer: "abbey", result: [0, 0, 1, 1, -1] },
      { guess: "kebab", answer: "abbey", result: [-1, 0, 1, 0, 0] },
      { guess: "keeps", answer: "abbey", result: [-1, 0, -1, -1, -1] },
      { guess: "annal", answer: "banal", result: [0, -1, 1, 1, 1] },
    ].each do |h|
      it "returns #{h[:result]} if the guess is '#{h[:guess]}' and the answer is '#{h[:answer]}'" do
        @guess = h[:guess]
        @answer = h[:answer]

        _(result.failure).must_equal(h[:result])
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
