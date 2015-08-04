$(document).ready(function() {

    function addAndOpenInfoWindow(map, marker, content){
        var infowindow = new google.maps.InfoWindow({
            content: content
        });
        infowindow.open(map, marker);
    }

    function updateMarkerPosition(latLng) {
      var lat = latLng.lat();
      var lng = latLng.lng();
      document.getElementById('latitude').value = lat;
      document.getElementById('longitude').value = lng;
      $('#display-latitude').text(lat);
      $('#display-longitude').text(lng);
    }

    //wait till map has loaded and add a draggable marker
    google.maps.event.addListenerOnce(map,'idle', function(){
        var marker = new google.maps.Marker({
          position: map.getCenter(),
          map: map,
          draggable: true
        });
        addAndOpenInfoWindow(
          map,
          marker,
          content = "Drag and drop this marker onto the water you'd like to add."
        );
      //Add listener to update lat / lng marker details on the form
       google.maps.event.addListener(marker, 'drag', function() {
          updateMarkerPosition(marker.getPosition());
        });

        google.maps.event.addListener(map, 'dragend', function() {
          var center = map.getCenter();
          marker.setPosition(center);
        });

        google.maps.event.addListener(map, 'zoom_changed', function() {
          var center = map.getCenter();
          marker.setPosition(center);
        });

        google.maps.event.addListener(searchBox, 'places_changed', function() {
          var center = map.getCenter();
          marker.setPosition(center);
        });
    });

});