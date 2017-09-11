$(function(){
    $("#protocol_selected_means_of_transport").change(function(){
        var means_of_transport = $(this).val();
        var emission = 0
        if (means_of_transport == "Auto"){
            emission = track_length * 150;
        }
        else if (means_of_transport == "Bahn"){
            emission = track_length * 40;
        }
        else if (means_of_transport == "Bus"){
            emission = track_length * 20;
        }
        else if (means_of_transport == "Fahrrad"){
            emission = track_length * 1;
        }
        else if (means_of_transport == "zu Fuß"){
            emission = track_length * 1;
        }
        else if (means_of_transport == "Elektro-Pkw"){
            emission = track_length * 100;
        }
        else if (means_of_transport == "Elektro-PKW mit Ökostrom"){
            emission = track_length * 7;
        }
        $("#balance").text("$" + emission);
    });
});