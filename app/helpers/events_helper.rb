module EventsHelper
  def convert_km_to_miles(km)
    (km * 0.6214).round(1)
  end

  def convert_miles_to_km(miles)
    (miles / 0.6214).round(1)
  end
  
  def wordy_distance(distance) 
    case convert_km_to_miles(distance)
    when 26.2
      "Marathon"
    when 13.1
      "Half Marathon"
    else
      "#{distance.to_i}K"
    end
  end
end
