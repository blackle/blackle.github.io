function pad(n, width, z) {
  z = z || '0';
  n = n + '';
  return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}


$(document).ready(function(){
  var KEY_MASK = {};

  $(document).keydown(function(event){
    KEY_MASK[event.keyCode] = true;
  });

  $(document).keyup(function(event){
    KEY_MASK[event.keyCode] = false;
  });

  var body = $('body'); 
  var SCROLL_DATA = {
    y: 9160 + 40 + 300 - 203 - $(window).height()/2,
    x: 9160 + 40 + 300 - 203 - $(window).width()/2,
    velx: 0,
    vely: 0,
    sizex: $(window).width(),
    sizey: $(window).height(),
    maxsizex: 17640 + 800 + 80+40+40,
    maxsizey: 17640 + 800 + 80+40+40,
  }
  $( window ).resize(function() {
    console.log('resize!');
    SCROLL_DATA.sizex = $(window).width();
    SCROLL_DATA.sizey = $(window).height();
  });


  function tickForbody(body, prop, into, out, friction) {
    var velprop = 'vel'+prop;
    if(KEY_MASK[into]) {
      body[velprop] -= 4;
    }
    if(KEY_MASK[out]) {
      body[velprop] += 4;
    }

    body[velprop] *= friction;

    body[prop] += body[velprop];

    if(body[prop] < 0) {
      body[prop] = 0;
      body[velprop] *= -1;
    }
    var maxdiff = body['maxsize'+prop]-body['size'+prop];
    if(body[prop] > maxdiff) {
      body[prop] = maxdiff;
      body[velprop] *= -1;
    }
  }

  function checkCell(cell) {
    var diffy = (cell.pos.top + 300) - (SCROLL_DATA.y + SCROLL_DATA.sizey/2);
    var diffx = (cell.pos.left + 300) - (SCROLL_DATA.x + SCROLL_DATA.sizex/2);
    
    if(Math.abs(diffx) < 100 && Math.abs(diffy) < 100) {
      return true;
    }
    return false;
  }

  var percision = 3;
  var friction = 0.95;

  var faces=[];
  var total = 0;
  var totalnum = 49;

  var available = [];
  for(var i = 1; i <= 625; i++) {
    if(i != 313) {
      available.push(i);
    }
  }
  available.sort(function() {
    return .5 - Math.random();
  });

  var spooky = new Audio('sounds/beep4.ogg');
  spooky.loop = true;
  spooky.volume = 0.0;
  spooky.play();

  for(var x = 1; x <= totalnum; x++) {
    //var myAudio = new Audio('sounds/beep'+(x%8 +1)+'.ogg');

    //myAudio.addEventListener('ended', function() {
    //  this.currentTime = 0;
    //  this.play();
    //}, false);

    var obj = $( "<div></div>", {
      "class": "unhooked",
      "id": "f"+x,
    });

    $("<img/>", {
      "src": "images/" + pad(x, 4, "0") + ".gif",
    }).appendTo(obj);


    obj.appendTo("#box"+available.pop());
    //obj.appendTo("#box"+x);



    faces.push({
      obj: obj,
      pos: obj.position(),
      on: false,
     // audio: myAudio
    });
    // console.log(x);
    // console.log(faces[x].pos);
  }

  function tick(){
    if(total != totalnum){
      $(window).scrollLeft(SCROLL_DATA.x.toFixed(percision));
      $(window).scrollTop(SCROLL_DATA.y.toFixed(percision));

      // console.log(SCROLL_DATA.x);


      for(var x = 0; x < totalnum; x++) {
        if(faces[x].on == false && checkCell(faces[x])){
          faces[x].on = true;
          faces[x].obj.removeClass('unhooked');
          faces[x].obj.addClass('hooked');
          total++;
          spooky.volume = Math.pow(total,3)/Math.pow(totalnum,3);
	  $('.total').text(total);
        }
      }
      if(total == totalnum) {
        $(".middle").remove();
        $(".cell").removeClass('cell');
        spooky.pause();
      }

      // console.log(checkCell($('.unhooked')));

      tickForbody(SCROLL_DATA, 'x', 37, 39, friction);
      tickForbody(SCROLL_DATA, 'y', 38, 40, friction);
      if(KEY_MASK[32]) {
        friction = 0.60;
      } else {
        friction = 0.95;
      }
    }

  }

  setInterval(tick, 30);
});
