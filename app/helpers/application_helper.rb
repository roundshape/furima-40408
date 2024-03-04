module ApplicationHelper
  def can_edit_item?(item, user)
    item.present? && !item.purchase && user.present? && user.id == item.user.id
  end
end
