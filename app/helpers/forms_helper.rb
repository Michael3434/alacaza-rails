module FormsHelper
  def buildings_collection(authority = nil)
    if authority
      buildings = authority.buildings_associate
    else
      buildings = Bulding.all
    end
    buildings.all.map do |building|
      [building.name, building.id]
    end
  end

  def users_associate(authority)
    users = authority.buildings_associate.map(&:users).map do |user|
      user.map { |user| [user.name, user.id] }
    end
    users.inject(&:|)
  end
end
