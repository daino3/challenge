
var map;
var polylineCoordinates = [];
var polyline;

function initialize() {
  var mapOptions = {
    center: { lat: 41.9, lng: -87.6847},
    zoom: 13
  };
  map = new google.maps.Map(document.getElementById('map'), mapOptions);
}

function clearPolylines(){
  if (polyline == undefined) {
    return false
  } else {
    polyline.setMap(null);
  }
}


$(document).ready(function() {
  initialize({})

  $('td.name').click(function() {
    clearPolylines();

    var url = '/bus_stops/' + $(this).data('id');
    $.get(url, function(response) {

      polylineCoordinates = _.map(response.bus_stops, function(bus_stop){
        return new google.maps.LatLng(bus_stop.latitude,bus_stop.longitude);
      })

      polyline = new google.maps.Polyline({
          path: polylineCoordinates,
          strokeColor: '#FF0000',
          strokeOpacity: 1.0,
          strokeWeight: 2,
          editable: true
      });

      polyline.setMap(map);

    })
  })
});
