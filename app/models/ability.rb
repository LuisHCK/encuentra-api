class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    alias_action :read, :create, :read, :update, :destroy, to: :crud

    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :publisher
      # Rooms
      can :crud, Room
    end
  end
end
