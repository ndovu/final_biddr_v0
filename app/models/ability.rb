class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :manage, Auction do |auction|
      auction.user == user
    end

    can :manage, Bid do |bid|
      bid.auction.user != user
    end
  end
end
