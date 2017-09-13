class Balance < ActiveRecord::Base
    belongs_to :user
    before_create :calculate_emission
    
    def means_of_transport_selection
        ["Auto", "Bahn", "Bus", "Fahrrad", "zu Fuß", "Elektro-PKW", "Elektro-PKW mit Ökostrom"]
    end


    def calculate_emission
        if  means_of_transport.to_s == "Auto"
            self.emission = track_length.to_i * 0.15 
        elsif means_of_transport.to_s == "Bahn"
            self.emission = track_length.to_i * 0.04
        elsif means_of_transport.to_s == "Bus"
            self.emission = track_length.to_i * 0.02
        elsif means_of_transport.to_s == "Fahrrad"
            self.emission = 0
        elsif means_of_transport.to_s == "zu Fuß"
            self.emission = 0
        elsif means_of_transport.to_s == "Elektro-PKW"
            self.emission = track_length.to_i * 0.1
        else self.means_of_transport.to_s == "Elektro-PKW mit Ökostrom"
            self.emission = track_length.to_i * 0.007
        end
    end
    
   
        
end
