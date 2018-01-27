console.log("maps")

var map;

window.addMarkers = function addMarkers() {
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

document.addEventListener("turbolinks:load", function() {
    console.log("turbo loaded , making map")
    map = window.map = new GMaps({
        div: '#map',
        lat: 38.5816,
        lng: -121.4944
    });

    addMarkers();

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
});

