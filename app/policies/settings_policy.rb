class SettingsPolicy < Struct.new(:user, :settings)
  def index?
    user.system_administrator? || user.bplo_officer?
  end
end
