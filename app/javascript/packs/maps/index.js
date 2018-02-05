console.log("maps")

var map;

window.addTransactionMarkers = function addTransactionMarkers() {
    var element = document.querySelector("#transactions-list");
    var transactions = window.transactions = JSON.parse(element.dataset.transactions);

    map.removeMarkers();

    transactions.forEach(function(transaction) {
        if (transaction.latitude && transaction.longitude) {
            var marker = map.addMarker({
                lat: transaction.latitude,
                lng: transaction.longitude,
                title: transaction.address,
                infoWindow: {
                    content: `<div>
            <i class="fa fa-car pull-left"></i>
<p><a href='/transactions/${transaction.id}'>${transaction.address}</a></p>

</div>`
                }
            });
        }
    });

    setSafeBounds(element);
}

window.addLocationMarkers = function addLocationMarkers() {
    var element = document.querySelector("#locations-list");
    var locations = window.locations = JSON.parse(element.dataset.locations);

    map.removeMarkers();

    locations.forEach(function(location) {
        if (location.latitude && location.longitude) {
            var marker = map.addMarker({
                lat: location.latitude,
                lng: location.longitude,
                title: location.my_tostring,
                infoWindow: {
                    content: `<div>
            <i class="fa fa-flask pull-left"></i>
<p><a href='/locations/${location.id}'>${location.my_tostring}</a></p>

</div>`
                }
            });
        }
    });

    setSafeBounds(element);
}

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

    // map.removeMarkers();

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
    // map.fitZoom()
    map.zoomOut(8);  //not working? use setTimeout instead sigh

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

    if(window.location.pathname.indexOf('/grupes') >= 0 ){
        addSingleLocationInfoMarker()
        zoom()

    }

    if(window.location.pathname.match(/locations\/\d/)){
        addSingleLocationInfoMarker()
        zoom()
    }

    if(window.location.pathname == '/locations') {
        addLocationMarkers();
    }
    if(window.location.pathname == '/transactions') {
        addTransactionMarkers();

        var checkedDrag = document.querySelector("#map").getAttribute("data-checkedDrag")
        checkedDrag = (checkedDrag == 'true')

        var checkbox = $('#mapDragCheckbox')
        if(checkedDrag){
            checkbox.prop('checked', true);
        }

        map.addListener("dragend", function() {

            var isChecked = checkbox.is(":checked")
            if(isChecked) {
                var bounds = map.getBounds();
                var location = bounds.getSouthWest().toUrlValue() + "," + bounds.getNorthEast().toUrlValue();
                Turbolinks.visit(`/transactions?l=${location}&checkedDrag=${isChecked}`);
            }
        });

        //map.addListener("zoom_changed", function(){  console.log("map zoomed ")   })

        document.querySelector("#redo-search").addEventListener("click", function(e) {
            e.preventDefault();

            var bounds = map.getBounds();
            var location = bounds.getSouthWest().toUrlValue() + "," + bounds.getNorthEast().toUrlValue();

            Turbolinks.visit(`/transactions?l=${location}`);
        });

    }
});

