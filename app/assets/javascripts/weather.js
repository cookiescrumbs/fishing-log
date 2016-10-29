$(document).ready(function() {

    var weatherElement = $('#weather-forecast')[0],
    lat = getLat(),
    lng = getLng();

    function getLat() {
        return parseFloat(weatherElement.dataset.lat) || null;
    }

    function getLng() {
        return parseFloat(weatherElement.dataset.lng) || null;
    }

    function addWeatherToPage(html){
        weatherElement.html(html);
    }

    function getWeatherForLocation(lat,lng){
        $.ajax({
          type: 'GET',
          url: '/weather',
          data:{
            'lat': lat,
            'lng': lng
          },
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: function(data) {
            console.log(data.html_forecast);
            addWeatherToPage(data.html_forecast)
          },
          failure: function(errMsg) {
            alert(errMsg);
          }
        });
    }

    getWeatherForLocation(lat,lng);

})