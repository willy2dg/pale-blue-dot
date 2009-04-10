class Star < ActiveRecord::Base
  def self.search(search, page)
    if search.only_available
      conditions = ['adopted_by = ? ', ""]
    else 
      conditions = ['adopted_by like ?', "%#{search.name}%"]
    end

    order = "number"
    if search.brightness
      order = "mag " + search.brightness_order
    end

    paginate :per_page => 30, :page => page,
             :conditions => conditions, :order => order
  end

  def latitude
    # This returns the numerical coordinate
    return ((self.lat_d.to_f + self.lat_m.to_f / 60.0 + self.lat_s.to_f / 3600.0)).to_s
    
    # This returns it as hr:minute:sec
    #return self.lat_d.to_s + ":" + self.lat_m.to_s + ":" + self.lat_s.to_s


  end

  def longitude
    # This returns the numerical coordinate
    return (-((self.lon_d.to_f + self.lon_m.to_f / 60.0 + self.lon_s.to_f / 3600.0) * 15 - 180)).to_s
    #
    #return self.lon_d.to_s + ":" + self.lon_m.to_s + ":" + self.lon_s.to_s
  end
end
