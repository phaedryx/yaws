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
      return Success([1]) if guess == answer

      Failure(guess:, answer:)
    end

    # def validate_guess(guess:, answer:)
    #   return Failure(:non_alpha_error) if /[^A-Za-z]/.match?(guess)

    #   Success(:placeholder)
    # end
  end
end
