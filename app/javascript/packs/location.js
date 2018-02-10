/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb




console.log('Hello World from Webpacker location.js');


var map;

window.addLocationMarkers = function addLocationMarkers(mapObj) {
    var element = document.querySelector("#locations-list");
    var locations = window.locations = JSON.parse(element.dataset.locations);

    mapObj.removeMarkers();

    locations.forEach(function(loc) {
        if (loc.latitude && loc.longitude) {
            var marker = mapObj.addMarker({
                lat: loc.latitude,
                lng: loc.longitude,
                title: loc.my_tostring,
                infoWindow: {
                    content: `<div>
            <i class="fa fa-flag-o fa-2x pull-left"></i>
<p><a href='/locations/${loc.id}'>${loc.my_tostring}</a></p>

</div>`
                }
            });
        }
    });

    setSafeBounds(element, mapObj);
}


function setSafeBounds(element, mapObj) {
    var l = element.dataset.l;
    if (l) {
        var latlngs   = l.split(',');
        var southWest = new google.maps.LatLng(latlngs[0], latlngs[1]);
        var northEast = new google.maps.LatLng(latlngs[2], latlngs[3]);
        var bounds    = new google.maps.LatLngBounds(southWest, northEast);
        mapObj.fitBounds(bounds, 0);

    } else {
        //fitZoom will make the map slightly shift on the same location
        mapObj.fitZoom();
    }
}


document.addEventListener("turbolinks:load", function() {
    console.log("turbo loaded , making map locatoin.js")
    var mapObj = window.map = new GMaps({
        div: '#map',
        lat: 38.5816,
        lng: -121.4944
    });

    map = mapObj;

        addLocationMarkers(mapObj);

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
                Turbolinks.visit(`/locations?l=${location}&checkedDrag=${isChecked}`);
            }
        });

        //map.addListener("zoom_changed", function(){  console.log("map zoomed ")   })

        document.querySelector("#redo-search").addEventListener("click", function(e) {
            e.preventDefault();

            var bounds = map.getBounds();
            var coords = bounds.getSouthWest().toUrlValue() + "," + bounds.getNorthEast().toUrlValue();

            Turbolinks.visit(`/locations?l=${coords}`);
        });


});

