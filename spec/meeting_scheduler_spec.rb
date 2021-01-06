require '../meeting_scheduler'

describe MeetingScheduler do
  describe ".meetings" do
    let (:set_of_meetings) { [
      { name: "Meeting 1", duration: 3, type: :onsite },
      { name: "Meeting 2", duration: 2, type: :offsite },
      { name: "Meeting 3", duration: 1, type: :offsite },
      { name: "Meeting 4", duration: 0.5, type: :onsite }
    ] }
    let (:total_no_of_hours) { 8 }

    it "returns scheduled meeting list" do
      schedule = MeetingScheduler.new(set_of_meetings, total_no_of_hours)
      expected_output = ["09:00 - 12:00 - Meeting 1", "12:00 - 12:30 - Meeting 4", "01:00 - 03:00 - Meeting 2", "03:30 - 04:30 - Meeting 3"]
      output = schedule.meetings

      expect(output).to include(expected_output[0])
      expect(output).to include(expected_output[1])
      expect(output).to include(expected_output[2])
      expect(output).to include(expected_output[3])
    end

    it "returns No, Can't fit on duration is more than 8 hours" do
      set_of_meetings = [
        { name: "Meeting 1", duration: 4, type: :offsite },
        { name: "Meeting 2", duration: 4, type: :offsite }
      ]
      schedule = MeetingScheduler.new(set_of_meetings, total_no_of_hours)
      expect(schedule.meetings).to eql("No, Can't fit")
    end

    it "returns Nil, If set_of_meetings is not set" do
      set_of_meetings = nil
      schedule = MeetingScheduler.new(set_of_meetings, total_no_of_hours)
      expect(schedule.meetings).to eql(nil)
    end

    it "returns Nil, If total_no_of_hours is not set" do
      total_no_of_hours = nil
      schedule = MeetingScheduler.new(set_of_meetings, total_no_of_hours)
      expect(schedule.meetings).to eql(nil)
    end
  end
end
