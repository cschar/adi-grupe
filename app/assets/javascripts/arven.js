console.log('arvenmap init');


var count = 0;
var output = ''
var dumps = '';
var myPoints = 0;

//marker data
var otherMarkers = [];
// int --> marker
var myMarkersObj = {};
var markerLookup = {};

//map data
var map2 = null;
var myLocation = [];
var myTrackingLayer = new L.FeatureGroup();
var myDrawnLayer = new L.FeatureGroup();
var otherDrawnLayer = new L.FeatureGroup();

//api data
var baseURL = '';
var lmarkers = [];
var selection = 'None'

$(document).on('turbolinks:load', function(){
    console.log("turbolink loaded ===")
    if($('#arven').length) {
        baseURL = gon.protocol_and_host;

        setArven()
        $('#setMarkers').click(function(){setMarkersOnMap()})
        $('#getMarkers').click(function(){
            console.log(baseURL)
            $.get(baseURL+'/lmarkers.json',function(data){
                console.log(data);
                lmarkers = data;
            })
        })
    }
});

function setArven(){
    console.log('setting map in arven')
    map2 = L.map('arvenMap').fitWorld();
    window.m = map2;
    map2.addLayer(myDrawnLayer);
    map2.addLayer(otherDrawnLayer);
    map2.addLayer(myTrackingLayer);

    var removeMarkers = function(){
        //TODO use layergroup
        // https://gis.stackexchange.com/questions/201958/remove-leaflet-markers-leaflet-id
        for ( var j =0; j < otherMarkers.length; j++){
            map2.removeLayer(otherMarkers[j])
        }
        otherDrawnLayer.clearLayers();

        for ( key in myMarkersObj){
            map2.removeLayer(myMarkersObj[key])
        }
        myDrawnLayer.clearLayers();
        myMarkersObj = {}
    }
    $('#removeMarkers').click(function(){ removeMarkers()})

    var refreshMap = function(){
        console.log("fetching data")
        $.get(baseURL+'/lmarkers.json',function(data){
            lmarkers = data;
            console.log("clearing and polling for new marker data")
            removeMarkers()
            setMarkersOnMap()
        })

        $.get(baseURL+'/users/info.json', function(data){
            console.log("points")
            console.log(data);
            myPoints = data.points
        })

    }

    $('#refreshMap').click(function() { refreshMap() })
    // setInterval(clearAndSet, 5000)


    $('#debugPrint').click(function(){
        console.log(myDrawnLayer)
        console.log('watched ' )
        console.log(mapWatch)
        console.log("myMarkersObj")
        console.log(myMarkersObj)

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
        myLocation = e.latlng;

        myTrackingLayer.clearLayers();
        var myMarker = L.marker(e.latlng).bindPopup("You are within " + radius + " meters from this point").openPopup();
        var myRadius = L.circle(e.latlng, radius)
        var myRPSRadius = L.circle(e.latlng, {radius:200, color:'green', 'fillOpacity':0.1})

        myTrackingLayer.addLayer(myMarker)
        myTrackingLayer.addLayer(myRadius)
        myTrackingLayer.addLayer(myRPSRadius)

    }

    function onLocationError(e) { alert(e.message);}

    map2.on('locationfound', onLocationFound);
    map2.on('locationerror', onLocationError);

    function refreshPosition(){
        console.log("refreshing position")
        map2.locate({setView: true,
            maxZoom: 16,
            watch: true,
            enableHighAccuracy: false});

    }

    refreshPosition()


    function userClick(e){


        if (Object.keys(myMarkersObj).length <= 5
             && distanceTo(e.latlng, myLocation) <= 0.0027
        ){
            //by default set new ones as rock
            marker = createCurrentUserMarker(e.latlng, gon.user_id, 'rock', null)
            marker.addTo(map2)
            dumpsf('setting up: ' + e.latlng.toString())
        }else{
            dumps += '<div class="dump-error""> out of bounds </div>'
        }


    }

    map2.on('click', userClick)

    var feedCallback = function(){

        count = count + 1;
        output = '<ul>'
        // output += '<li>' + '</li>'
        output += '<li>' +count.toString() + '</li>'
        //var center = map2.getCenter()
        output += '<li>' + 'myLocation :' + myLocation.toString() + '</li>'
        output += '<li>' + 'points: ' + myPoints + '</li>'
        output += '</ul>'


        $('#status').html(output)
        $('#feed1').html(getFeedText())

        $("#feed2").animate({ scrollTop: $('#feed2')[0].scrollHeight}, 1000);
        $('#feed2').html(getDumpsHtml())
    }
    setInterval(feedCallback, 2000);

}
function dumpsf(text){
    dumps += '<div class="dump-success">' + text + '</div>'

}
function getDumpsHtml(){
    return dumps
}
function getFeedText(){
    var feedtext = ''
    for ( key in myMarkersObj){
        var dist = distanceTo(myMarkersObj[key]._latlng, myLocation).toString().slice(0,7)
        feedtext += '<li> marker ' + key + ', distance: ' + dist + '</li>'
    }

    feedtext = '<ul>' + feedtext + '</ul>'
    return feedtext
}

function setMarkersOnMap(){
    console.log('setting markers')
    console.log(lmarkers)

    for( var i =0; i < lmarkers.length; i++){
        var lmarker = lmarkers[i];
        var marker = null;
        //case of new marker being loaded in
        if ( lmarker.user_id == gon.user_id){
            var latlng = new L.LatLng(lmarker.lat, lmarker.lng)
            marker = createCurrentUserMarker(latlng, gon.user_id, lmarker.ltype, lmarker.id)
            marker.addTo(map2)
        }else{
            marker = createOtherUserMarker(lmarker)
            marker.addTo(map2)
        }
    }

}


// var marker = L.marker(e.latlng, { icon: dIcon});

function createCurrentUserMarker(latlng, user_id, ltype, marker_id){
    //put uid in markerlookup so when intial delete jquery binding is made
    // it can go back and lookup w/ uid to get later-set marker_id
    // jquery stuff haha
    var uid =  Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
    var marker = L.marker(latlng);
    if(marker_id != null){
        myMarkersObj[marker_id] = marker;
        markerLookup[uid] = marker_id
    }

    setMarkerImage(marker, ltype)
    var marker_perimeter = L.circle(latlng, {radius: 200, color: "lightblue"})
    myDrawnLayer.addLayer(marker_perimeter)

    var linkR = $('<button class="btn btn-default btn-sm"> Set Rock</button>')
    var linkP = $('<button class="btn btn-default btn-sm"> Set Paper</button>')
    var linkS = $('<button class="btn btn-default btn-sm"> Set Scissors</button>')
    var linkSave = $('<button class="btn btn-default btn-xs"><h5>Set/Update </h5></button>')
    var linkDelete = $('<button class="btn btn-default btn-xs"><h5>remove</h5></button>')
    var rpsImg = $('<img class="rpsImage" src= "'+ltype +'.png"/>')
    selection = ltype

    linkR = linkR.click(function() {
        rpsImg.attr("src", "rock.png")
        marker.setIcon(rockIcon)
        selection = 'rock'
    })
    linkP = linkP.click(function() {
        marker.setIcon(paperIcon)
        rpsImg.attr("src", "paper2.gif")
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
                myMarkersObj[data.id] = marker
                markerLookup[uid] = data.id

            }).error(function(){
            console.log('error')
        })
    });

    linkDelete = linkDelete.click(function() {

        if (!markerLookup.hasOwnProperty(uid)){
            console.log('no key set')
            dumpsf('removing unset marker')
            map2.removeLayer(marker);
            // delete marker;
            myDrawnLayer.removeLayer(marker_perimeter)
            return
        }
        var csrf = document.getElementsByName('csrf-token')[0].getAttribute('content')
        $.ajax({
            url: baseURL+'/lmarkers/' + markerLookup[uid] + '.json',
            type: 'DELETE',
            headers: {
                "X-CSRF-TOKEN": csrf
            }
        }).done(
            function(data){
                dumpsf('deleted marker')
                map2.removeLayer(myMarkersObj[markerLookup[uid]])
                delete myMarkersObj[markerLookup[uid]];
                myDrawnLayer.removeLayer(marker_perimeter)
            })
        .error(function(){ dumpsf("error deleting marker")
        })
    });

    var name = 'lmarker @ ' + latlng.toString();
    var div = $("<div style='bacground:#aca'>" + name+" <br/> </div>")
    div.append(rpsImg[0])
    div.append(linkR[0])
    div.append(linkP[0])
    div.append(linkS[0])
    div.append(linkSave[0])
    div.append(linkDelete[0])



    marker.bindPopup(div[0]);
    return marker
}

function createOtherUserMarker(lmarker){

        var marker = L.marker([lmarker.lat, lmarker.lng]);
        otherMarkers.push(marker)
        setMarkerImage(marker, lmarker.ltype)
        L.circle(marker._latlng, {radius: 200, color: "orange"}).addTo(otherDrawnLayer);

        var Fireball = $('<button class="btn btn-default btn-sm"> Cast fireball</button>')
        var imgName = lmarker.ltype.toString() +'.png'
        var rpsImg = $('<img class="rpsImage" src="' + imgName + '"/>')

        Fireball.click(function() {
            console.log('fireball @' + lmarker.user_id)
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

        var info = [lmarker.lat,lmarker.lng].toString() +
            "<br/> player: " + lmarker.user_id+
            " <br/>marker "+lmarker.id +" --" + lmarker.ltype +" lmarker";
        var div = $("<div style='background:#aca'>" + info +" </div>")
        div.append(rpsImg[0])
        div.append(Fireball[0])


        marker.bindPopup(div[0]);
        return marker
}

function setMarkerImage(marker, ltype){
    if(ltype == 'paper') {
        marker.setIcon(paperIcon)
    }
    if(ltype == 'rock') {
        marker.setIcon(rockIcon)
    }
    if(ltype == 'scissors') {
        marker.setIcon(scissorsIcon)
    }
}



/* icons */
// [ x , y ]
// -40y ---> higher on y axis
// 20x --> left on x axis
var rockIcon = L.icon({
    iconUrl: 'rock.png',
    // shadowUrl: 'kerm.png',

    iconSize:     [40, 40], // size of the icon
    // shadowSize:   [10, 24], // size of the shadow
    iconAnchor:   [20, 10], // point of the icon which will correspond to marker's location
    // shadowAnchor: [4, 62],  // the same for the shadow
    popupAnchor:  [10, -20] // point from which the popup should open relative to the iconAnchor
});

var scissorsIcon = L.icon({
    // iconUrl: 'scissors.png',
    iconUrl: 'scissors2.png',
    // shadowUrl: 'kerm.png',

    iconSize:     [40, 40], // size of the icon
    // shadowSize:   [10, 24], // size of the shadow
    iconAnchor:   [20, 10], // point of the icon which will correspond to marker's location
    // shadowAnchor: [4, 62],  // the same for the shadow
    popupAnchor:  [10, -40] // point from which the popup should open relative to the iconAnchor
});

var paperIcon = L.icon({
    iconUrl: 'paper2.png',
    // iconUrl: 'paper2.png',
    // shadowUrl: 'white_square.png',

    iconSize:     [40, 40], // size of the icon
    // shadowSize:   [50, 50], // size of the shadow
    iconAnchor:   [20, 10], // point of the icon which will correspond to marker's location
    // shadowAnchor: [10, 50],  // the same for the shadow
    popupAnchor:  [20, -40] // point from which the popup should open relative to the iconAnchor
});


//
// $('#refreshPosition').click(function(){ refreshPosition() });
//
// function setPosition(){
//     var lat = $('#lat').val()
//     var lng = $('#lng').val()
//
//     map2.setView(new L.LatLng(lat, lng), 12);
//     myLocation = new L.LatLng(lat, lng)
//     console.log("set position" + lat + ' ' + lng)
// }
// $('#setPosition').click(function(){ setPosition() })
//
// $('#toggleWatch').click(function(){
//     mapWatch = !mapWatch; })
//



function distanceTo(currentPostion, target) {
    var dx = currentPostion.lng - target.lng;
    var dy = currentPostion.lat - target.lat;
    return Math.sqrt(dx*dx + dy*dy);
}
