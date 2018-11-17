class MeetingAvailabilitySerializer < ActiveModel::Serializer
  attributes :id, :date_available
  belongs_to :room

  def date_available
    start_date = object.date_from.to_datetime
    end_date= object.date_to.to_datetime
    
    (start_date..end_date).map{|d| filter_days(d, object.skip_weekends)}
  end

  private
  def filter_days(day, skip_weekends)
    if skip_weekends
      return day unless day.saturday? || day.sunday?
    else 
      return day
    end
  end
end
