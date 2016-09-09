# Shared Methods Class

require './far_mar'

class FarMar::Shared

  # self.find will return the object associated with an id passed to it by the calling class. If the id cannot be found, an ArgumentError is raised.
  def self.find(find_id)
    all = self.all
    obj = nil
    all.each do |element|
      if element.id == find_id
        obj = element
      end
    end
    if obj.nil?
      raise ArgumentError.new("This id cannot be found")
    else
      return obj
    end
  end

end
