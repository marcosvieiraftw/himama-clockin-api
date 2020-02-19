class Api::V1::ClockinRecordPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # Filtering records by current user id.
      scope.where(user_id: user.id)
    end
  end
end
