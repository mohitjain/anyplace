# All back end users (i.e. Active Admin users) are authorized using this class
class ActiveAdminAbility
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new
    # We operate with four role levels:
    alias_action :create, :read, :update, to: :cannot_delete
    alias_action :read, :update, to: :read_update
    alias_action :read, :create, to: :read_create
    # 1. Super Admin -> god in the code means user type in database.

    can [:read, :create], ActiveAdmin::Comment
    can :read, ActiveAdmin::Page, :name => "Dashboard"
    can :cannot_delete, Hotel
    can :cannot_delete, Availability
    can :cannot_delete, Pricing
    can :cannot_delete, RoomType
  end
end
