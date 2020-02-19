class ClockinRecord < ApplicationRecord
  include AuthenticableEntity
  has_soft_deletion default_scope: true
  include PgSearch::Model

  pg_search_scope :search_by_type, against: [:register_type],
                  using: { tsearch: { prefix: true } }

  # Relation
  belongs_to :user

  # Validations
  enum register_type: { in: 1, out: 0 }
  validates :register_type, presence: true, inclusion: { in: register_types.keys, message: :inclusion }
  validates :register_date, presence: true, absence: false
  # Custom validations
  # I decided not to validate on update because there might be a situation where users want to fix all events of a day
  # and if there are validations, they wouldn't be able to change in/out
  validate :check_last_record_type, on: :create

  private

  # Checking if the last record type is the same as the new to prevent duplication or inconsistency.
  def check_last_record_type
    last_user_record = ClockinRecord.where(user_id: user_id).last
    if last_user_record&.register_type == register_type
      errors.add(:register_type, :last_type_equals)
    end
  end
end
