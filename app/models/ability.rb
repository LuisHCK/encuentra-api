class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user.has_role? :admin
      can :manage, :all
    end
  end
end
