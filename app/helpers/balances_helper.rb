module BalancesHelper


# Kreisdiagramm 
    def used_transport
        pie_chart Balance.where(:user_id => current_user.id).group(:means_of_transport).count
    end  
    
# Liniendiagramm
    def balance 
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
    
# Vergleich Gesamte Emission mit Durchschnitt    
    def comparison
        column_chart [
        {name: "Ich", data: {"": sum_emission}},
        {name: "Durchschnitt", data: {"": "2190"}},
        {name: "Hochrechnung eigener Durchschnitt (Jahr)", data: {"": extrapolation}},
        {name: "Durchschnitt Wohnort", data: {"": comparison_place_of_residence}},
        {name: "Unser Ziel", data: {"": "1752"}}
        ],
        width: "500px", height: "300px",
        ytitle: "kg/Jahr",
        colors: ["#2fef1a", "#6c7687" ,"#2fef1a", "#caccc7", "#3eaeef"]
    end
    
    
# Vergleich Strecke ÖPNV mit Durchschnitt
    def comparison_öpnv
        column_chart [
        {name: "Ich", data: {"": track_length_öpnv}},
        {name: "Durchschnitt", data: {"": "980"}},
        ],
        width: "500px", height: "300px",
        ytitle: "km/Jahr",
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
    
# Durchschnitt hochrechnen
    def extrapolation
        unless sum_emission.nil? || sum_emission == 0
            Balance.where(:user_id => current_user.id).average(:emission)  * 365
        end
    end
    
# Vergleich Emission mit Durchschnitt des Wohnorts 
    def comparison_place_of_residence
        User.joins(:balances).where(:place_of_residence => current_user.place_of_residence).sum(:emission) /
        User.where(:place_of_residence => current_user.place_of_residence).count
    end
    
 
# Vergleich mit Durchschnitt
    def comparison_average
        if sum_emission   > 2190
            "über"
        else 
            "unter"
        end
    end 
    
# Vergleich mit Ziel
    def comparison_goal
        if sum_emission   > 438  #20% von 2190 
            "über"
        else 
            "unter"
        end
    end 
    
# Anzahl an Autofahrten unter einer Strecke von 5km        
    def count_auto
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
        unless sum_auto.nil? 
            @balances.where(:user_id => current_user.id , :means_of_transport => "Auto").sum(:track_length).round(2)
        end
    end 
    
    def track_length_linienbus
        unless sum_linienbus.nil? 
            @balances.where(:user_id => current_user.id , :means_of_transport => "Linienbus").sum(:track_length).round(2)
        end 
    end
    
    def track_length_reisebus
        unless sum_reisebus.nil? 
            @balances.where(:user_id => current_user.id , :means_of_transport => "Reisebus").sum(:track_length).round(2)
        end 
    end
    
    def track_length_bahn_nah
        unless sum_bahn_nah.nil? 
            @balances.where(:user_id => current_user.id , :means_of_transport => "Bahn-Nahverkehr").sum(:track_length).round(2)
        end 
    end
    
    def track_length_bahn_fern
        unless sum_bahn_fern.nil? 
            @balances.where(:user_id => current_user.id , :means_of_transport => "Bahn-Fernverkehr").sum(:track_length).round(2)
        end
    end
    
    def track_length_zu_fuß
        unless sum_zu_fuß.nil? 
            @balances.where(:user_id => current_user.id , :means_of_transport => "zu Fuß").sum(:track_length).round(2)
        end 
    end
    
    def track_length_fahrrad
        unless sum_fahrrad.nil? 
            @balances.where(:user_id => current_user.id , :means_of_transport => "Fahrrad").sum(:track_length).round(2)
        end 
    end
    
    def track_length_elektro
        unless sum_elektro.nil? 
            @balances.where(:user_id => current_user.id , :means_of_transport => "Elektro-PKW").sum(:track_length).round(2)
        end 
    end
    
# Strecke von ÖPNV 
    def track_length_öpnv
        unless sum_bahn_nah.nil?  && sum_reisebus.nil? && sum_linienbus.nil? 
            @balances.where(:user_id => current_user.id , means_of_transport: ["Bahn-Nahverkehr", "Reisebus", "Linienbus"]).sum(:track_length).round(2)
        end  
    end
    
# Emission Auto
    def emission_auto
        unless sum_auto.nil? 
            @balances.where(:user_id => current_user.id , :means_of_transport => "Auto").sum(:emission).round(3)
        end
    end

# Durchschnitt Strecke mit Auto     
    def average_auto
        unless sum_auto.nil? || sum_auto == 0 
            @balances.where(:user_id => current_user.id , :means_of_transport => "Auto").average(:track_length).round(2)
        end
    end
    
# Durchschnitt Strecke mit öffentlichen Transport
    def average_öffentlich
        unless sum_bahn_nah.nil? || sum_bahn_nah == 0 && sum_reisebus.nil? || sum_reisebus == 0 && sum_linienbus.nil? || sum_linienbus == 0 && sum_bahn_fern.nil? || sum_bahn_fern == 0 
            @balances.where(:user_id => current_user.id , means_of_transport: ["Bahn-Fernverkehr", "Bahn-Nahverkehr","Reisebus", "Linienbus"]).average(:track_length).round(2)
        end  
    end
    
# Durchschnitt Strecke zu Fuß
    def average_fuss
        unless sum_fahrrad.nil? || sum_fahrrad == 0 && sum_zu_fuß.nil? || sum_zu_fuß == 0
            Balance.where(:user_id => current_user.id, means_of_transport: ["Fahrrad", "zu Fuß"]).average(:track_length).round(2)
        end
    end
    
# Meistgenutztes Fahrzeug
    def max_anzahl
        unless sum_auto.nil? && sum_linienbus.nil? && sum_reisebus.nil? && sum_bahn_nah.nil? && sum_zu_fuß.nil? && sum_fahrrad.nil? && sum_elektro.nil? && sum_bahn_fern.nil? 
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
    end
    
# Fahrzeug mit höchster Streckenlänge
    def max_strecke
        unless track_length_auto.nil? && track_length_bahn_fern.nil? && track_length_bahn_nah.nil? && track_length_linienbus.nil? && 
        track_length_reisebus.nil? && track_length_fahrrad.nil? && track_length_zu_fuß.nil? && track_length_elektro.nil? 
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
    
# Rangzuordnung     
    def ribbon 
		case sum_emission 
		when 0..1752 then "1"
		when 1753..1971 then "2"
		when 1971..2190 then "3"
	    else  "4" 
		end 
    end
    
end
