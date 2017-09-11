class Balance < ActiveRecord::Base
    belongs_to :user
    attr_accessor :selected_means_of_transport
    
    def means_of_transport
        ["Auto", "Bahn", "Bus", "Fahrrad", "zu Fuß", "Elektro-PKW", "Elektro-PKW mit Ökostrom"]
    end
    
    def emission
        if self.selected_means_of_transport == "Auto"
            self.track_length * 150
        elsif self.selected_means_of_transport == "Bahn"
            self.track_length * 40
        elsif self.selected_means_of_transport == "Bus"
            self.track_length * 20
        elsif self.selected_means_of_transport == "Fahrrad"
            self.track_length * 1
        elsif self.selected_means_of_transport == "zu Fuß"
            self.track_length * 1
        elsif self.selected_means_of_transport == "Elektro-Pkw"
            self.track_length * 100
        else self.selected_means_of_transport == "Elektro-PKW mit Ökostrom"
            self.track_length * 7
        end
    end
end
