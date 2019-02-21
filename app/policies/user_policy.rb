# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
	
	def edit?
		record == user
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

	def show?
	  true
	end	
end