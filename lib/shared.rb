# Shared Methods Class

require './far_mar'

class FarMar::Shared

  # self.find will return the object associated with an id passed to it by the
  # calling class. If the id cannot be found, an ArgumentError is raised.
  def self.find(find_id)
    all = self.all
    all.each do |element|
      if element.id == find_id
        return element
      end
    end
    raise ArgumentError.new("This id cannot be found")
  end

end
