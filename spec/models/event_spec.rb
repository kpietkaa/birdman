require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "validates" do
    it "sorts events alphabetically by event_type" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      event3 = FactoryGirl.create(:event, event_type: "Vaccination", start_at: '2016-11-01 00:00:00', user: user2)
      event2 = FactoryGirl.create(:event, event_type: "Castration", start_at: '2015-11-01 00:00:00', user: user2)
      event1 = FactoryGirl.create(:event, event_type: "Vaccination", user: user1)
      expect(Event.type_sort("Vaccination")).to eq([event3, event1])
    end
  end
end
