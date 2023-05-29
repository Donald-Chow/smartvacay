class LocationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope.where(searches.includes?(user.trip))
      scope.includes(:searches).where(searches: { trip_id: user.trip.id })
    end
  end

  def show?
    true
  end

  def favorite?
    # allow users to perform the bookmarking action
    true
  end

  def my_favorites?
    true
  end
end
