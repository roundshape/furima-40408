module ItemsHelper
  def can_interact_with_item?(user, item)
    user.present? && !item.purchase
  end
end
