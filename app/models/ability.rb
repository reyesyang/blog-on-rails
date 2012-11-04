class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :tagged, Article
      can :logout, User
      cannot :show, Article do |article|
        article.tags.any?{|tag| tag.name == 'draft'}
      end

      cannot :tagged, Article do |article|
        article.tags.any?{|tag| tag.name == 'draft'}
      end
    end
  end
end
