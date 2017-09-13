module BalancesHelper
    def used_transport
        pie_chart Balance.where(:user_id => current_user.id).group(:means_of_transport).count
    end  
    
    def bilanz
        line_chart Balance.where(:user_id => current_user.id).group(:date).sum(:emission), xtitle: ("Datum"), ytitle: "Emission"
    end  
    
end
