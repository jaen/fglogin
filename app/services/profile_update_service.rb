module ProfileUpdateService
  def self.first_profile_update?(user)
    user.profile_updates.empty?
  end
end
