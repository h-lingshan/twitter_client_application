$(document).ready(function () {
  setInterval(refreshPartial,300000);
})
function refreshPartial(){
  $.ajax({
      url: "/recommendations"
  })
}
