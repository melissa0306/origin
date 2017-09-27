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
        {name: "Ich", data: {"": sum_emission}},
        {name: "Durchschnitt", data: {"": "2655"}},
        {name: "Ziel für 2020", data: {"": "1593"}}
        ],
        width: "500px", height: "300px",
        ytitle: "kg/Jahr",
        colors: ["#2fef1a", "#6c7687" , "#caccc7"]
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
    def vergleich
        if sum_emission   > 2655
            "über"
        else 
            "unter"
        end
    end 
    
    def vergleich2020
        if sum_emission   > 1593
            "über"
        else 
            "unter"
        end
    end 
    
    # Anzahl an Autofahrten unter einer Strecke von 5km        
    def anzahl_auto
        @balances.where(:user_id => current_user.id).select { |a| a.means_of_transport == "Auto" && a.track_length <= 5}.count
    end
    
# Anzahl fahrten je nach Fahrzeug
    def sum_auto
        @balances.where(:user_id => current_user.id).select { |a| a.means_of_transport == "Auto"}.count
    end
    
    def sum_bahn_fern
        @balances.where(:user_id => current_user.id).select { |b| b.means_of_transport == "Bahn-Fernverkehr"}.count
    end

    def sum_bahn_nah
        @balances.where(:user_id => current_user.id).select { |b| b.means_of_transport == "Bahn-Nahverkehr"}.count
    end
    
    def sum_reisebus
        @balances.where(:user_id => current_user.id).select { |c| c.means_of_transport == "Reisebus"}.count
    end
    
    def sum_linienbus
        @balances.where(:user_id => current_user.id).select { |c| c.means_of_transport == "Linienbus"}.count
    end
    
    def sum_fahrrad
        @balances.where(:user_id => current_user.id).select { |c| c.means_of_transport == "Fahrrad"}.count
    end
    
    def sum_zu_fuß
        @balances.where(:user_id => current_user.id).select { |c| c.means_of_transport == "zu Fuß"}.count
    end
    
    def sum_elektro
        @balances.where(:user_id => current_user.id).select { |c| c.means_of_transport == "Elektro-PKW"}.count
    end
        
#  mit Fahrzeug zurückgelegte Strecke   
    def track_length_auto
        @balances.where(:user_id => current_user.id , :means_of_transport => "Auto").sum(:track_length)
    end 
    
    def track_length_linienbus
        @balances.where(:user_id => current_user.id , :means_of_transport => "Linienbus").sum(:track_length)
    end 
    
    def track_length_reisebus
        @balances.where(:user_id => current_user.id , :means_of_transport => "Reisebus").sum(:track_length)
    end 
    
    def track_length_bahn_nah
        @balances.where(:user_id => current_user.id , :means_of_transport => "Bahn-Nahverkehr").sum(:track_length)
    end 

    def track_length_bahn_fern
        @balances.where(:user_id => current_user.id , :means_of_transport => "Bahn-Fernverkehr").sum(:track_length)
    end
    
    def track_length_zu_fuß
        @balances.where(:user_id => current_user.id , :means_of_transport => "zu Fuß").sum(:track_length)
    end 
    
    def track_length_fahrrad
        @balances.where(:user_id => current_user.id , :means_of_transport => "Fahrrad").sum(:track_length)
    end 
    
    def track_length_elektro
        @balances.where(:user_id => current_user.id , :means_of_transport => "Elektro-PKW").sum(:track_length)
    end 
    
    # Emission Auto
    def emission_auto
        @balances.where(:user_id => current_user.id , :means_of_transport => "Auto").sum(:emission)
    end

    # Durchschnitt Strecke mit Auto     
    def durchschnitt_auto
        @balances.where(:user_id => current_user.id , :means_of_transport => "Auto").average(:track_length)
    end
    
    # Durchschnitt Strecke mit öffentlichen Transport
    def durchschnitt_öffentlich
        @balances.where(:user_id => current_user.id , :means_of_transport => "Bahn-Fernverkehr" && "Bahn-Nahverkehr" && "Reisebus" && "Linienbus").average(:track_length)
    end  
    
    # Durchschnitt Strecke zu Fuß
    def durchschnitt_fuss
        @balances.where(:user_id => current_user.id , :means_of_transport => "Fahrrad" && "zu Fuß").average(:track_length)
    end
    
    # Meistgenutztes Fahrzeug
    def max_anzahl
        maxi = [sum_auto, sum_linienbus, sum_reisebus, sum_bahn_fern, sum_bahn_nah, sum_zu_fuß, sum_fahrrad, sum_elektro].max
        case maxi
        when sum_auto
            "das Auto"
        when sum_linienbus
            "der Linienbus"
        when sum_reisebus
            "der Reisebus"
        when sum_bahn_nah
            "die Bahn"
        when sum_bahn_fern
            "die Bahn"
        when sum_zu_fuß
            "zu Fuß"
        when sum_fahrrad
            "das Fahrrad"
        else
            "der Elektro-PKW"
        end
    end
    
    # Fahrzeug mit höchster Streckenlänge
    def max_strecke
        maxi = [track_length_auto, track_length_bahn_fern, track_length_bahn_nah,
        track_length_linienbus, track_length_reisebus, track_length_fahrrad, track_length_zu_fuß, track_length_elektro].max
        case maxi
        when track_length_auto
            "dem Auto"
        when track_length_linienbus
            "dem Linienbus"
        when track_length_reisebus
            "dem Reisebus"
        when track_length_bahn_fern
            "der Bahn"
        when track_length_bahn_nah
            "der Bahn"
        when track_length_zu_fuß
            "zu Fuß"
        when track_length_fahrrad
            "dem Fahrrad"
        else
            "dem Elektro-PKW"
        end
    end  
    
end
