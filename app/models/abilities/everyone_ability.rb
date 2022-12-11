module Abilities
  class EveryoneAbility
    include CanCan::Ability

    def initialize(user)
      can :read, :dashboard
    end
  end
end