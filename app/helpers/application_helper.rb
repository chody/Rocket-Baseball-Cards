# frozen_string_literal: true

module ApplicationHelper
	def us_states
    	STATES.invert.to_a
  	end
end
