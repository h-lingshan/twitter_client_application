$(document).ready(function() {
  setInterval(refreshPartial,200000);
})
function refreshPartial(){
  $.ajax({
      url: "/time_line"
  })
}
