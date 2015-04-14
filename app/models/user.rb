class User < ActiveRecord::Base
  ROLES = %w(member admin)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :role, presence: true, inclusion: {in: ROLES}

  def admin?
    role == 'admin'
  end
end
