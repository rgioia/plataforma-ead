module Abilities
  class AdministratorAbility
    include CanCan::Ability

    def initialize(user)
      can :manage, :all
    end
  end
end