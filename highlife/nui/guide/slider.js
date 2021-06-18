var currentIndex = 0,
  items = $(".slidescontainer > div"),
  itemAmt = items.length;

var item = $(".slidescontainer div").eq(0);
items.hide();
item.css("display", "inline-block");

if ($(".slidescontainer div").eq(0)) {
  $("#spawnbtn").hide();
  $("#btnLeft").addClass('disabled');
}

function cycleItems(resetIndex) {
  if (resetIndex != null) {
    if (resetIndex == true) {
      currentIndex = 0;
    }
  }
  var item = $(".slidescontainer div").eq(currentIndex);
  items.hide();
  item.css("display", "inline-block");
}

$("#btnRight").click(function () {
  if (currentIndex !== itemAmt -1) {
    currentIndex += 1;
    if (currentIndex == 0) {
      $("#spawnbtn").hide();
      $("#btnLeft").removeClass('disabled');
      $("#btnReft").show();
    }
    if (currentIndex == itemAmt - 1) {
      $("#spawnbtn").show();
      $("#btnRight").addClass('disabled');
      $("#btnLeft").removeClass('disabled');
    }
    if (currentIndex < itemAmt - 1 && currentIndex > 0) {
      $("#btnRight").removeClass('disabled');
      $("#btnLeft").removeClass('disabled');
    }
    cycleItems();
  }
});

$("#btnLeft").click(function () {
  if (currentIndex > 0) {
    currentIndex -= 1;
  }
  if (currentIndex == 0) {
    $("#btnLeft").addClass('disabled');
  }
  if (currentIndex < itemAmt - 1 && currentIndex > 0) {
    $("#btnRight").removeClass('disabled');
    $("#btnLeft").removeClass('disabled');
    $("#spawnbtn").addClass('disabled');
  }

  if (currentIndex == 0) {
    $("#spawnbtn").addClass('disabled');
    $("#btnLeft").addClass('disabled');
    $("#btnRight").removeClass('disabled');
  }
  /*if (currentIndex < 0) {
    currentIndex = itemAmt - 1;
  }*/
  cycleItems();
});
