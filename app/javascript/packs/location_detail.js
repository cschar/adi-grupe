

var map;


function setSafeBounds(element) {
    var l = element.dataset.l;
    if (l) {
        var latlngs   = l.split(',');
        var southWest = new google.maps.LatLng(latlngs[0], latlngs[1]);
        var northEast = new google.maps.LatLng(latlngs[2], latlngs[3]);
        var bounds    = new google.maps.LatLngBounds(southWest, northEast);
        map.fitBounds(bounds, 0);

    } else {
        //fitZoom will make the map slightly shift on the same location
        map.fitZoom();
    }
}


function addSingleLocationInfoMarker(){
    var element = window.eee = document.querySelector("#single-location-info");
    var grupelocation = JSON.parse(element.dataset.locationinfo);

    var marker = map.addMarker({
        lat: grupelocation.latitude,
        lng: grupelocation.longitude,
        title: grupelocation.name,
        infoWindow: {
            content: `<div>
            <i class="fa fa-flask fa-4x pull-left"></i>
<p><a href='/locations/${grupelocation.id}'>${grupelocation.name}</a></p>

</div>`
        }
    });


    setSafeBounds(element);

}

document.addEventListener("turbolinks:load", function() {
    console.log("turbo loaded , making map")
    map = window.map = new GMaps({
        div: '#map',
        lat: 38.5816,
        lng: -121.4944
    });

    var zoom = function(){
        setTimeout(function(){
                map.zoomOut(8)
                console.log("zoomin out")
            },
            1500)
    }
    addSingleLocationInfoMarker()
    zoom()
});

