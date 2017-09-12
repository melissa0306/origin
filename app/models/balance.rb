class Balance < ActiveRecord::Base
    belongs_to :user
    attr_accessor :selected_means_of_transport
    
    def means_of_transport
        ["Auto", "Bahn", "Bus", "Fahrrad", "zu Fuß", "Elektro-PKW", "Elektro-PKW mit Ökostrom"]
    end

    

end
