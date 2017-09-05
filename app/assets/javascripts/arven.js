console.log('arvenmap init');

var count = 0;
var output = ''
var allMarkers = [];
var dumps = '';
var clickSpot = '';
var map2 = null;
var lmarkers = [];
var baseURL = 'http://localhost:3000';
var selection = 'None'
var recentMarker = null;  //for changing icon image

$(document).on('turbolinks:load', function(){
    console.log("turbolink loaded ===")
    if($('#arven').length) {
        console.log('on arven page');
        setArven()
        console.log('token')
        console.log(document.getElementsByName('csrf-token')[0].getAttribute('content'))
        $('#getMarkers').click(function(){
            $.get(baseURL+'/lmarkers.json',function(data){
                console.log(data);
                lmarkers = data;
            }).success(function(data){


            })
        })

        $('#setMarkers').click(function(){
            setMarkersOnMap()
        })



    }
});


function setArven(){
    console.log('setting map in arven')
    map2 = L.map('arvenMap').fitWorld();
    $('#removeMarkers').click(function(){
        //TODO use layergroup
        // https://gis.stackexchange.com/questions/201958/remove-leaflet-markers-leaflet-id
        for ( var j =0; j < allMarkers.length; j++){
            map2.removeLayer(allMarkers[j])
        }
    })

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

    //
    map2.locate({setView: true,
        maxZoom: 16,
        watch: false,
        enableHighAccuracy: false});
    // map2.panTo(new L.LatLng(46.0122, -75.986));
    // map2.setView(new L.LatLng(45.56618, -75.782), 12);

    function onClick(e){
        console.log('clicked:')
        console.log(e)
        clickSpot = e.latlng.toString();
        var user_id = 1; // replace with gon js
        marker = createCurrentUserMarker(e.latlng, user_id)
        marker.addTo(map2)

    }

    map2.on('click', onClick)

    var mapCallback = function(){
        var center = map2.getCenter()
        count = count + 1;
        output = [count.toString() + center.toString(),
            'markers : ' + allMarkers.length.toString()
        ]
        var feedText = clickSpot.toString()
        feedText += '\n  '+ selection;
        $('#status').text(output)
        $('#feed').text()
        $('#feed2').text(dumps)
    }
    setInterval(mapCallback, 2000);

}


function setMarkersOnMap(){
    console.log('setting markers')
    console.log(lmarkers)

    var div = $("<div style='background:#aca'> a test dive that is very long <br/> </div>")

    for( var i =0; i < lmarkers.length; i++){
        var lmarker = lmarkers[i];
        var latlng = new L.LatLng(lmarker.lat, lmarker.lng)

        var marker = null;
        //gon js
        if ( lmarker.user_id == 1){
            marker = createCurrentUserMarker(latlng, 1)
        }else{
            marker = createOtherUserMarker(lmarker)
        }
        // var marker = L.marker(latlng);
        // marker.bindPopup(div[0]);
        allMarkers.push(marker)
        marker.addTo(map2)
    }

}



/* icons */
var rockIcon = L.icon({
    iconUrl: 'rock.png',
    // shadowUrl: 'kerm.png',

    iconSize:     [40, 40], // size of the icon
    // shadowSize:   [10, 24], // size of the shadow
    iconAnchor:   [0, 40], // point of the icon which will correspond to marker's location
    // shadowAnchor: [4, 62],  // the same for the shadow
    popupAnchor:  [10, -40] // point from which the popup should open relative to the iconAnchor
});

var scissorsIcon = L.icon({
    // iconUrl: 'scissors.png',
    iconUrl: 'scissors2.png',
    // shadowUrl: 'kerm.png',

    iconSize:     [40, 40], // size of the icon
    // shadowSize:   [10, 24], // size of the shadow
    iconAnchor:   [0, 40], // point of the icon which will correspond to marker's location
    // shadowAnchor: [4, 62],  // the same for the shadow
    popupAnchor:  [10, -40] // point from which the popup should open relative to the iconAnchor
});

var paperIcon = L.icon({
    iconUrl: 'paper2.gif',
    // iconUrl: 'paper2.png',
    // shadowUrl: 'white_square.png',

    iconSize:     [40, 40], // size of the icon
    // shadowSize:   [50, 50], // size of the shadow
    iconAnchor:   [0, 40], // point of the icon which will correspond to marker's location
    // shadowAnchor: [10, 50],  // the same for the shadow
    popupAnchor:  [10, -40] // point from which the popup should open relative to the iconAnchor
});
// var marker = L.marker(e.latlng, { icon: dIcon});

function createCurrentUserMarker(latlng, user_id){
    var marker = L.marker(latlng);
    var linkR = $('<button class="btn btn-default btn-sm"> Set Rock</button>')
    var linkP = $('<button class="btn btn-default btn-sm"> Set Paper</button>')
    var linkS = $('<button class="btn btn-default btn-sm"> Set Scissors</button>')
    var linkSave = $('<button class="btn btn-default btn-sm"><h4>Save Location</h4></button>')
    var rpsImg = $('<img class="rpsImage" src="kerm.png"/>')
    linkR = linkR.click(function() {
        rpsImg.attr("src", "rock.png")
        marker.setIcon(rockIcon)
        selection = 'rock'
    })
    linkP = linkP.click(function() {
        marker.setIcon(paperIcon)
        rpsImg.attr("src", "paper.png")
        selection = 'paper'
    })
    linkS = linkS.click(function() {
        marker.setIcon(scissorsIcon)
        rpsImg.attr("src", "scissors.png")
        selection = 'scissors'
    })

    linkSave = linkSave.click(function() {

        var csrf = document.getElementsByName('csrf-token')[0].getAttribute('content')
        $.ajax({
            url: baseURL+'/lmarkers.json',
            type: 'post',
            data:{'lmarker[lat]': latlng.lat,
                'lmarker[lng]': latlng.lng,
                'lmarker[ltype]': selection,
                'lmarker[user_id]': user_id},
            headers: {
                "X-CSRF-TOKEN": csrf
            }
        }).done(
            function(data){
                console.log('post click success w')
                console.log(data);
            }).error(function(){
            console.log('error')
        })
    });

    var div = $(`<div style='bacground:#aca'> lmarker @ ${latlng} <br/> </div>`)
    div.append(rpsImg[0])
    div.append(linkR[0])
    div.append(linkP[0])
    div.append(linkS[0])
    div.append(linkSave[0])



    marker.bindPopup(div[0]);
    return marker
}

function createOtherUserMarker(lmarker){

        var marker = L.marker([lmarker.lat, lmarker.lng]);
        if(lmarker.ltype == 'paper') {

            marker.setIcon(paperIcon)
        }
        if(lmarker.ltype == 'rock') {
            marker.setIcon(rockIcon)
        }
        if(lmarker.ltype == 'scissors') {
                marker.setIcon(scissorsIcon)
        }
        var Fireball = $('<button class="btn btn-default btn-sm"> Cast fireball</button>')

        var rpsImg = $(`<img class="rpsImage" src="${lmarker.ltype}.png"/>`)

    //  Fireball.click(function() {  // works ? without reassign?
        Fireball = Fireball.click(function() {

            var csrf = document.getElementsByName('csrf-token')[0].getAttribute('content')
            //     $.ajax({
            //         url: baseURL+'/control/fireball',
            //         type: 'post',
            //         data:{'lmarker[lat]': e.latlng.lat,
            //             'lmarker[lng]': e.latlng.lng,
            //             'lmarker[ltype]': selection,
            //             'lmarker[user_id]': user_id},
            //         headers: {
            //             "X-CSRF-TOKEN": csrf
            //         }
            //     }).done(
            //         function(data){
            //             console.log("fireball set to "+ lmarker.user_id)
            //             console.log(data);
            //         }).error(function(){
            //         console.log('error')
            //     })
        });


        var div = $(`<div style='background:#aca'>${[lmarker.lat,lmarker.lng]} <br/> ${lmarker.user_id} -- ${lmarker.ltype} lmarker </div>`)
        div.append(rpsImg[0])
        div.append(Fireball[0])


        marker.bindPopup(div[0]);

        return marker

}