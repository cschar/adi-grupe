console.log('arvenmap init');
console.log($('#arven').length);

$(document).on('turbolinks:load', function(){
    console.log("turbolink loaded ===")
    if($('#arven').length) {
        console.log('on arven page');
        setArven()
    }
});

var count = 0;
var output = ''
var markers = [];
var dumps = '';


function setArven(){
    console.log('setting map in arven')
    var map2 = L.map('arvenMap').fitWorld();

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

        // var dIcon = L.icon({
        //     iconUrl: 'kerm.png',
        //     // shadowUrl: 'kerm.png',
        //
        //     iconSize:     [40, 40], // size of the icon
        //     // shadowSize:   [10, 24], // size of the shadow
        //     iconAnchor:   [0, 40], // point of the icon which will correspond to marker's location
        //     // shadowAnchor: [4, 62],  // the same for the shadow
        //     popupAnchor:  [-3, -40] // point from which the popup should open relative to the iconAnchor
        // });
        //
        // var marker = L.marker(e.latlng, { icon: dIcon});
        var marker = L.marker(e.latlng);
        marker.bindPopup(div[0]);
        marker.addTo(map2)
        // marker.addTo(map).bindPopup("<div style='background:#aca'> a test dive that is very long </div>")
    }

    map2.on('click', onClick)

    var mapCallback = function(){
        var center = map2.getCenter()
        count = count + 1;
        output = [count.toString() + center.toString(),
            'markers : ' + markers.length.toString()
        ]
        $('#status').text(output)
        $('#feed').text(clickSpot.toString())
        $('#feed2').text(dumps)
    }
    setInterval(mapCallback, 2000);

}

