require 'time'

class MeetingScheduler

  def initialize(set_of_meetings, total_no_of_hours)
    @set_of_meetings = set_of_meetings
    @total_no_of_hours = total_no_of_hours
  end

  def meetings
    return nil if @set_of_meetings.nil? || @total_no_of_hours.nil?

    day_start_time = Time.parse("9:00")

    day_end_time = day_start_time + @total_no_of_hours * 60 * 60

    meeting_list = @set_of_meetings.reverse.sort_by!{ |meeting| [meeting[:type]] }

    meeting_hours = meeting_list.sum {|h| h[:duration]}

    total_meeting_hours = day_start_time + meeting_hours * 60 * 60 + offsite_travel_time(meeting_list) * 60

    return "No, Can't fit" if total_meeting_hours > day_end_time

    updated_time = nil

    scheduled_list = []

    meeting_list.reverse.each_with_index do |list, index|
      day_start_time += 30 * 60 if list[:type] == :offsite && !index.zero?

      updated_time = day_start_time + list[:duration].to_f * 60 * 60

      scheduled_list << "#{day_start_time.strftime("%I:%M")} - #{updated_time.strftime("%I:%M")} - #{list[:name]}"

      day_start_time = updated_time
    end

    puts scheduled_list

    "Yes, can fit" if scheduled_list.any?
    
    rescue => ex
      ex.message  
  end

  private

  def offsite_travel_time(meeting_list)
    total_offsite_meetings_count = meeting_list.count { |x| x[:type] == :offsite }
    total_onsite_meetings_count = meeting_list.count { |x| x[:type] == :onsite }
    total_offsite_meetings_count = (total_onsite_meetings_count == 0) ? total_offsite_meetings_count - 1 : total_offsite_meetings_count
    value = 0
    while total_offsite_meetings_count > 0
      value += 30
      total_offsite_meetings_count -= 1
    end
    value
  end
end

set_of_meetings = [
  { name: "Meeting 1", duration: 3, type: :onsite },
  { name: "Meeting 2", duration: 2, type: :offsite },
  { name: "Meeting 3", duration: 1, type: :offsite },
  { name: "Meeting 4", duration: 0.5, type: :onsite }
]

total_no_of_hours = 8
schedule = MeetingScheduler.new(set_of_meetings, total_no_of_hours)
puts schedule.meetings

