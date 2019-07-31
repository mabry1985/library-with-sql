class User
  @@DB = PG.connect({:dbname => "local_library"})
  @@display_user = []

  def self.save(user_name)
  @@DB.exec("INSERT INTO users (name) VALUES ('#{user_name}');")
  end

  def self.search_by_name(user_name)
      result = @@DB.exec("SELECT * FROM users WHERE name='#{user_name}';").first
      result["id"].to_i
  end

  def self.user_history(user_id)
    @@DB.exec("SELECT * FROM checkouts WHERE user_id='#{user_id}';")
  end

end
