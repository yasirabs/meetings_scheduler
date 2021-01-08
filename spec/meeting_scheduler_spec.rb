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
      output = schedule.meetings
      expect(output[0]).to eq("Yes, can fit :")
      expect(output[1]).to eq("09:00 - 12:00 - Meeting 1")
      expect(output[2]).to eq("12:00 - 12:30 - Meeting 4")
      expect(output[3]).to eq("01:00 - 03:00 - Meeting 2")
      expect(output[4]).to eq("03:30 - 04:30 - Meeting 3")
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
      output = schedule.meetings
      expect(output[0]).to eq("Yes, can fit :")
      expect(output[1]).to eq("09:00 - 10:30 - Meeting 1")
      expect(output[2]).to eq("10:30 - 11:30 - Meeting 3")
      expect(output[3]).to eq("12:00 - 02:00 - Meeting 2")
      expect(output[4]).to eq("02:30 - 03:30 - Meeting 4")
      expect(output[5]).to eq("04:00 - 05:00 - Meeting 5")
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
      output = schedule.meetings
      expect(output[0]).to eq("Yes, can fit :")
      expect(output[1]).to eq("09:00 - 09:30 - Meeting 2")
      expect(output[2]).to eq("09:30 - 12:30 - Meeting 4")
      expect(output[3]).to eq("01:00 - 01:30 - Meeting 1")
      expect(output[4]).to eq("02:00 - 04:30 - Meeting 3")
    end
    
    it "returns Yes, can fit with back to back offsite meetings Example 4" do
      set_of_meetings = [
        { name: "Meeting 1", duration: 4, type: :offsite },
        { name: "Meeting 2", duration: 3.5, type: :offsite }
      ]
      schedule = MeetingScheduler.new(set_of_meetings, total_no_of_hours)
      output = schedule.meetings
      expect(output[0]).to eq("Yes, can fit :")
      expect(output[1]).to eq("09:00 - 01:00 - Meeting 1")
      expect(output[2]).to eq("01:30 - 05:00 - Meeting 2")
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

    it "returns Nil, If set_of_meetings array is empty" do
      set_of_meetings = []
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
