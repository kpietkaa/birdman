class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role == 'admin'
      can :manage, :all
    elsif user.role == 'doctor'
      can :manage, :all
    elsif user.role == 'user'
      can :create, Animal
      can [:read, :destroy, :edit, :update], Animal do |a|
        a.user_id == user.id
      end
      can :create, Event
      can [:read, :destroy, :edit, :update], Event do |e|
        e.user_id == user.id
      end
      can :read, Visitor
      can :read, History
    else
      can :read, :all
    end
  end
end
