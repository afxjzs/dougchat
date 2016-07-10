class Chat < Volt::Model
  own_by_user
  field :body, String

  def latest(limit = 50)
    limit(limit).order({created_at: -1})
  end
end
