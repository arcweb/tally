class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      cannot :index, User
      cannot :update, User
      can :show, User, id: user.id
    end            
  end
end
