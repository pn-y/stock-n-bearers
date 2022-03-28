class Stock < ApplicationRecord
  belongs_to :bearer, optional: true, autosave: true

  enum status: {active: 'active', archived: 'archived'}
  attribute :status, default: -> { 'active' }

  validates :name, presence: true, uniqueness: true

  scope :with_bearer, -> { where.not(bearer_id: nil) }
  scope :api, -> { active }
end
