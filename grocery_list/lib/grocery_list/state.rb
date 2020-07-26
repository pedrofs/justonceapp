module GroceryList
  class State
    InvalidState = Class.new(StandardError)

    VALID_STATES = %i[pending bought].freeze

    def initialize(state)
      unless state.in?(VALID_STATES)
        raise InvalidState.new, "Valid states are: #{VALID_STATES.join(', ')}"
      end

      @state = state
    end

    def pending?
      @state == :pending
    end

    def bought?
      @state == :bought
    end
  end
end
