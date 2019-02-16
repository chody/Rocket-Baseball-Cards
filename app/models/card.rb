class Card < ApplicationRecord

	belongs_to :user

  	enum manufacturer: { topps: 1, upper_deck: 2, panini: 3 }

	def player_full_name
		"#{player_first_name} #{player_last_name}"
	end
end
