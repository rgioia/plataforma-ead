# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      self.merge Abilities::EveryoneAbility.new(user) unless user.profile.administrator?

      if user.profile.administrator?
        self.merge Abilities::AdministratorAbility.new(user)
      end
    end
  end
end
