leaflet

map2.panTo(new L.LatLng(x, y));
map2.setView(new L.LatLng(x, y), 12);


    // map2.locate({setView: true,
    //     maxZoom: 16,
    //     watch: false,
    //     enableHighAccuracy: false});

var drawnItems = new L.FeatureGroup();
var circle = L.circle(latlng, {radius: 200, color: "orange"})
circle.addTo(drawnItems);

map2.addLayer(drawnItems);

drawnItems.removeLayer(circle)


var marker = L.marker([50,50])
marker.addTo(map2)
map2.removeLayer(marker)