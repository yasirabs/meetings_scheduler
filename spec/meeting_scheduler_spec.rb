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

    it "returns Yes, can fit for scheduled meeting list" do
      schedule = MeetingScheduler.new(set_of_meetings, total_no_of_hours)
      expect(schedule.meetings).to eq("Yes, can fit")
    end
    
    it "returns Yes, can fit with Example 1" do
      set_of_meetings = [
        { name: "Meeting 1", duration: 1.5, type: :onsite },
        { name: "Meeting 2", duration: 2, type: :offsite },
        { name: "Meeting 3", duration: 1, type: :onsite },
        { name: "Meeting 4", duration: 1, type: :offsite },
        { name: "Meeting 5", duration: 1, type: :offsite }
    ]
      schedule = MeetingScheduler.new(set_of_meetings, total_no_of_hours)
      expect(schedule.meetings).to eql("Yes, can fit")
    end

    it "returns No, Can't fit on duration is more than 8 hours with Example 2" do
      set_of_meetings = [
        { name: "Meeting 1", duration: 4, type: :offsite },
        { name: "Meeting 2", duration: 4, type: :offsite }
      ]
      schedule = MeetingScheduler.new(set_of_meetings, total_no_of_hours)
      expect(schedule.meetings).to eql("No, Can't fit")
    end
    
    it "returns Yes, can fit with Example 3" do
      set_of_meetings = [
        { name: "Meeting 1", duration: 0.5, type: :offsite },
        { name: "Meeting 2", duration: 0.5, type: :onsite },
        { name: "Meeting 3", duration: 2.5, type: :offsite },
        { name: "Meeting 4", duration: 3, type: :onsite }
      ]
      schedule = MeetingScheduler.new(set_of_meetings, total_no_of_hours)
      expect(schedule.meetings).to eql("Yes, can fit")
    end
    
    it "returns Yes, can fit with back to back offsite meetings Example 4" do
      set_of_meetings = [
        { name: "Meeting 1", duration: 4, type: :offsite },
        { name: "Meeting 2", duration: 3.5, type: :offsite }
      ]
      schedule = MeetingScheduler.new(set_of_meetings, total_no_of_hours)
      expect(schedule.meetings).to eql("Yes, can fit")
    end
    
    it "raises exception on invalid set_of_meetings Hash" do
      set_of_meetings = [
        { name: "Meeting 1", duration: 4 },
        { name: "Meeting 2", duration: 4, type: :offsite }
      ]
      schedule = MeetingScheduler.new(set_of_meetings, total_no_of_hours)
      expect(schedule.meetings).to eq("comparison of Array with Array failed")
    end
    
    it "raises exception on total_no_of_hours is nil" do
      set_of_meetings = [
        { name: "Meeting 1", duration: 3, type: :onsite },
        { name: "Meeting 2", duration: 4, type: :offsite }
      ]
      total_no_of_hours = nil
      schedule = MeetingScheduler.new(set_of_meetings, total_no_of_hours)
      expect(schedule.meetings).to eq(nil)
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
