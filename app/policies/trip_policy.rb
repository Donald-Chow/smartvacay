class TripPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    record.user == user
  end

  def create?
    true
  end

  def generate?
    true
  end
end
