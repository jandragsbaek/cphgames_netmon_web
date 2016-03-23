function reloadItems(){
  $.ajax({
    url: "/dashboard/uptime_partial",
    type: "GET",
    dataType: "script"
  });
}


setInterval(reloadItems, 15000)

function blink(elem, times, speed) {
  if (times > 0 || times < 0) {
    if ($(elem).hasClass("blink")) 
      $(elem).removeClass("blink");
    else
      $(elem).addClass("blink");
  }

  clearTimeout(function () {
    blink(elem, times, speed);
  });

  if (times > 0 || times < 0) {
    setTimeout(function () {
      blink(elem, times, speed);
    }, speed);
    times -= .5;
  }
}

blink('.dead', -1, 250);
