class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role == 'admin'
      can :manage, :all
    elsif user.role == 'doctor'
      can :manage, :all
    elsif user.role == 'user'
      can :manage, Animal
      can :manage, Event
      can :read, Visitor
      can :read, History
    else
      can :read, :all
    end
  end
end
