module ApplicationHelper

  def date_formatter(string)
      string.strftime('%A, %B %d, %Y')
  end

  def import(path, type)
     binding.pry
    CSV.foreach(path, :headers => true) do |row| 
      type.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE invoice_items_id_seq RESTART WITH #{type.maximum(:id) + 1}")
   
  end

end
