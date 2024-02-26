# frozen_string_literal: true

module Words
  # checks a word guess against an answer and returns an array indicating matches
  class Checker < ::ServiceObject
    step :alpha_validation
    step :lowercase_validation
    step :length_validation
    step :exact_match_validation

    private

    def alpha_validation(guess:, answer:)
      return Failure(:non_alpha_error) if /[^A-Za-z]/.match?(guess)

      Success(guess:, answer:)
    end

    def lowercase_validation(guess:, answer:)
      return Failure(:upper_case_error) if /[A-Z]/.match?(guess)

      Success(guess:, answer:)
    end

    def length_validation(guess:, answer:)
      return Failure(:length_error) if guess.length != answer.length

      Success(guess:, answer:)
    end

    def exact_match_validation(guess:, answer:)
      # binding.pry if answer == "a"
      return Success(Array.new(guess.length, 1)) if guess == answer

      # -1, 0, 1
      # -1 no match
      # 0 in word incorrect placement
      # 1 in word correct placement

      result = []
      guess.each_char.with_index do |c, i|
        # result << 1 if c == answer[i] # exact match
        # result << -1 unless c == answer[i] # no match
        # result << 0 if answer.chars.include?(c)
        result << if c == answer[i]
          1
        elsif answer.chars.include?(c)
          0
        else
          -1
        end
      end

      Failure(result)
    end

    # def validate_guess(guess:, answer:)
    #   return Failure(:non_alpha_error) if /[^A-Za-z]/.match?(guess)

    #   Success(:placeholder)
    # end
  end
end
