class Balance < ActiveRecord::Base
    belongs_to :user
    attr_accessor :means_of_transport
    before_create :calculate_emission
    
    def means_of_transport_selection
        ["Auto", "Bahn", "Bus", "Fahrrad", "zu Fuß", "Elektro-PKW", "Elektro-PKW mit Ökostrom"]
    end


    def calculate_emission
        if  means_of_transport.to_s == "Auto"
            self.emission = track_length.to_i * 150
        elsif means_of_transport.to_s == "Bahn"
            self.emission = track_length.to_i * 40
        elsif means_of_transport.to_s == "Bus"
            self.emission = track_length.to_i * 20
        elsif means_of_transport.to_s == "Fahrrad"
            self.emission = track_length.to_i * 1
        elsif means_of_transport.to_s == "zu Fuß"
            self.emission = track_length.to_i * 1
        elsif means_of_transport.to_s == "Elektro-Pkw"
            self.emission = track_length.to_i * 100
        else self.means_of_transport.to_s == "Elektro-PKW mit Ökostrom"
            self.emission = track_length.to_i * 7
        end
    end
        
end
