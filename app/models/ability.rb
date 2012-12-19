class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
      
    if user.admin?
      can :manage, :all
    else
      can :create, :session
      can :read, Article
      can :read, Tag
      cannot :show, Article do |article|
        article.draft?
      end
      
      cannot :show, Tag do |tag|
        tag.name == 'draft'
      end
    end
  end
end
