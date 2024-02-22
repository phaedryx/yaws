# frozen_string_literal: true

module Words
  class Checker < ::ServiceObject
    step :alpha_validation
    step :lowercase_validation
    step :length_validation
    step :exact_match_validation

    private

    def alpha_validation(guess:, actual:)
      return Failure(:non_alpha_error) if /[^A-Za-z]/.match?(guess)

      Success(guess:, actual:)
    end

    def lowercase_validation(guess:, actual:)
      return Failure(:upper_case_error) if /[A-Z]/.match?(guess)

      Success(guess:, actual:)
    end

    def length_validation(guess:, actual:)
      return Failure(:length_error) if guess.length != actual.length

      Success(guess:, actual:)
    end

    def exact_match_validation(guess:, actual:)
      return Success([1]) if guess == actual

      Failure(guess:, actual:)
    end

    # def validate_guess(guess:, actual:)
    #   return Failure(:non_alpha_error) if /[^A-Za-z]/.match?(guess)

    #   Success(:placeholder)
    # end
  end
end
