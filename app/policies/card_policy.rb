# frozen_string_literal: true

class CardPolicy < ApplicationPolicy
	
	def edit?
	  user.cards.map(&:id).include?(record.id)
	end

	def destroy?
	  edit?
	end

	def new?
	  true	
	end	

	def create?
	  true
	end	

	def index?
      true
	end	

	def find_on_ebay?
	  true
	end	

	def show?
	  true
	end	
end