$(function(){
    $("#balance_means_of_transport").change(function(){
        var means_of_transport_selection = $(this).val();
        var coefficient = 0;
        if (means_of_transport_selection == "Auto"){
            coefficient = 150;
        }
        else if (means_of_transport_selection == "Bahn"){
            coefficient = 40;
        }
        else if (means_of_transport_selection == "Bus"){
            coefficient = 20;
        }
        else if (means_of_transport_selection == "Bahn"){
            coefficient = 40;
        }
        else if (means_of_transport_selection == "Fahrrad"){
            coefficient = 1;
        }
        else if (means_of_transport_selection == "zu Fuß"){
            coefficient = 1;
        }
        else if (means_of_transport_selection == "Elektro-Pkw"){
            coefficient = 100;
        }
        else if (means_of_transport_selection == "Elektro-PKW mit Ökostrom"){
            coefficient = 7;
        }
        $("#price").text("$"+ coefficient);
        console.log(coefficient);
    });
});
    