class Balance < ActiveRecord::Base
    belongs_to :user
    before_create :calculate_emission
    
    def means_of_transport_selection
        ["Auto", "Bahn-Fernverkehr", "Bahn-Nahverkehr", "Linienbus", "Reisebus", "Fahrrad", "zu Fuß", "Elektro-PKW"]
    end


    def calculate_emission
        if  means_of_transport.to_s == "Auto"
            self.emission = track_length.to_i * 0.142 
        elsif means_of_transport.to_s == "Bahn-Fernverkehr"
            self.emission = track_length.to_i * 0.041
        elsif means_of_transport.to_s == "Linienbus"
            self.emission = track_length.to_i * 0.076
        elsif means_of_transport.to_s == "Reisebus"
            self.emission = 0.032
        elsif means_of_transport.to_s == "Bahn-Nahverkehr"
            self.emission = 0.067
        elsif means_of_transport.to_s == "Fahrrad"
            self.emission = 0
        elsif means_of_transport.to_s == "zu Fuß"
            self.emission = 0
        elsif means_of_transport.to_s == "Elektro-PKW"
            self.emission = track_length.to_i * 0.072
        end
    end
    
   
        
end
