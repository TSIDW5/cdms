module Members
  extend ActiveSupport::Concern

  included do
    def search_non_members(term)
      User.where('unaccent(name) ILIKE unaccent(?)', "%#{term}%").order('name ASC').where.not(id: user_ids)
    end
  end
end
