console.log('arvenmap init');
console.log($('#arven').length);

$(document).on('turbolinks:load', function(){
    console.log("turbolink loaded ===")
    if($('#arven').length) {
        console.log('on arven page');
        // setArven()
    }
});


function setArven(){
    var map2 = L.map('map').fitWorld();

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
        maxZoom: 18,
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
        '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
        'Imagery © <a href="http://mapbox.com">Mapbox</a>',
        id: 'mapbox.streets'
    }).addTo(map2);

    function onLocationFound(e) {
        var radius = e.accuracy / 2;

        L.marker(e.latlng).addTo(map2)
            .bindPopup("You are within " + radius + " meters from this point").openPopup();

        L.circle(e.latlng, radius).addTo(map2);
    }

    function onLocationError(e) {
        alert(e.message);
    }


    map2.on('locationfound', onLocationFound);
    map2.on('locationerror', onLocationError);


    map2.locate({setView: true,
        maxZoom: 16,
        watch: false,
        enableHighAccuracy: false});

    function onClick(e){
        clickSpot = e.latlng.toString();
        var link1 = $('<a href="#" class="speciallink"><h2>TestLink</h2><br/></a>')
        var link2 = $('<a href="#" class="speciallink"><h1>TestLink2</h1></a>')

        link1 = link1.click(function() {
            dumps = dumps + ' clicked'
        })[0];
        link2 = link2.click(function() {
            dumps = dumps + ' clicked2'
        })[0];

        var div = $("<div style='background:#aca'> a test dive that is very long <br/> </div>")
        div.append(link1)
        div.append(link2)


        var marker = L.marker(e.latlng);
        marker.bindPopup(div[0]);
        marker.addTo(map2)
        // marker.addTo(map).bindPopup("<div style='background:#aca'> a test dive that is very long </div>")
    }

    map2.on('click', onClick)
}

$(function(){
    console.log('arvenmap jquery init')
    console.log($('#arven').length);
    if($('#arven').length) { console.log('on arven page') }
    //

})