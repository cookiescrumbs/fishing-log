$(document).ready(function() {
    var input = document.getElementsByTagName("input")[0];
    input.addEventListener("input", function(event){
        ga('send', 'event',  {
            hitType: 'search',
            eventCategory: 'search',
            eventAction: 'search',
            eventLabel: event.srcElement.value
          });
    });
});