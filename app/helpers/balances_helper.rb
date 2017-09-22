module BalancesHelper
    
    # Kreisdiagramm 
    def used_transport
        pie_chart Balance.where(:user_id => current_user.id).group(:means_of_transport).count
    end  
    
    # Liniendiagramm
    def bilanz
        line_chart Balance.where(:user_id => current_user.id).group(:date).sum(:emission), xtitle: "Datum", ytitle: "Emission in kg"
    end  
    
    # Säulendiagramm Gesamtstrecke von Fahrzeugen
    def track_length_transport
        column_chart Balance.where(:user_id => current_user.id).group(:means_of_transport).sum(:track_length), ytitle: "Strecke in km" ,colors: ["#06d370"], height: "500px"
    end
    
    # Säulendiagramm Emission von Fahrzeugen
    def emission_transport
        column_chart Balance.where(:user_id => current_user.id).group(:means_of_transport).sum(:emission), ytitle: "Emission in kg", colors: ["#d12121"], height: "500px"
    end
    
    # Vergleich mit Durchschnitt    
    def comparison
        column_chart [
        {name: "Ich", data: {"": sum_emission / sum_track_length}},
        {name: "Durchschnitt", data: {"": "0.13257"}}
        ],
        width: "500px", height: "300px",
        ytitle: "kg/km",
        colors: ["#2fef1a", "#6c7687"]
    end
    
    # Summe von Strecke 
    def sum_track_length
        Balance.where(:user_id => current_user.id).sum(:track_length)
    end
    
    # Summe von Emission
    def sum_emission
        Balance.where(:user_id => current_user.id).sum(:emission)
    end   
    
    # Durchschnittliche mit dem Auto zurückgelegte Strecke
    def average_track_length
        Balance.where(:user_id => current_user.id , :means_of_transport => "Auto").average(:track_length)
    end
    
    # Vergleich mit Durchschnitt
    def butz
        if sum_emission / sum_track_length  > 0.117115
            "du liegst über dem Durchschnitt"
        else 
            "du liegst unter dem Durchschnitt"
        end
    end 
    
    # Anzahl an Autofahrten unter einer Strecke von 5km        
    def anzahl_auto
        @balances.where(:user_id => current_user.id).select { |a| a.means_of_transport == "Auto" && a.track_length >= 5}.count
    end
    
    # Anzahl fahrten je nach Fahrzeug
    def sum_auto
        @balances.where(:user_id => current_user.id).select { |a| a.means_of_transport == "Auto"}.count
    end
    
    def sum_bahn
        @balances.where(:user_id => current_user.id).select { |b| b.means_of_transport == "Bahn"}.count
    end
    
    def sum_bus
        @balances.where(:user_id => current_user.id).select { |c| c.means_of_transport == "Bus"}.count
    end
    
    #  mit Auto zurückgelegte Strecke   
    def track_length_auto
        @balances.where(:user_id => current_user.id , :means_of_transport => "Auto").sum(:track_length)
    end 
    
    
      
end
