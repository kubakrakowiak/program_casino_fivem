// Lucky Slot Machine
// Design and Development by Travis Luong

// declare globals
var WIDTH = 800;
var HEIGHT = 800;
var playerbet = 0;
var playermoney = 1500;
var freespins = 0;
// sequence, winnings
var WINNING_SEQUENCES = [
  // white book
  [[0, 0, 0, 0, 0], 5.0],
  [[0, 0, 0, 0], 2.5],
  [[0, 0, 0], 0.5],
  [[0, 0], 0.1],
  // green book
  [[1, 1, 1, 1, 1], 6.3],
  [[1, 1, 1, 1], 2.8],
  [[1, 1, 1], 0.7],
  [[1, 1], 0.15],
  // ia
  [[2, 2, 2, 2, 2], 7.6],
  [[2, 2, 2, 2], 3.2],
  [[2, 2, 2], 0.9],
  [[2, 2], 0.2],
  // money
  [[3, 3, 3, 3, 3], 8.9],
  [[3, 3, 3, 3], 3.6],
  [[3, 3, 3], 1.2],
  [[3, 3], 0.25],
  // seattle
  [[4, 4, 4, 4, 4], 9.4],
  [[4, 4, 4, 4], 4],
  [[4, 4, 4], 1.4],
  [[4, 4], 0.3],
  // car
  [[5, 5, 5, 5, 5], 10.9],
  [[5, 5, 5, 5], 5.4],
  [[5, 5, 5], 1.7],
  [[5, 5], 0.35],
  // fruit
  [[6, 6, 6, 6, 6], 15.4],
  [[6, 6, 6, 6], 6.9],
  [[6, 6, 6], 2.1],
  [[6, 6], 0.4],
  // dollar
  [[7, 7, 7, 7, 7], 25],
  [[7, 7, 7, 7], 8.2],
  [[7, 7, 7], 2.6],
  [[7, 7], 0.5],
  //Scatter
  [[8, 8, 8, 8, 8], 1004],
  [[8, 8, 8, 8], 1003],
  [[8, 8, 8], 1002],
  [[8, 8], 1001]


];

// [reel_number, row]
var LINE_MAP = [
  [[0, 1], [1, 1], [2, 1], [3, 1], [4, 1]],
  [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0]],
  [[0, 2], [1, 2], [2, 2], [3, 2], [4, 2]],
  [[0, 0], [1, 1], [2, 2], [3, 1], [4, 0]],
  [[0, 2], [1, 1], [2, 0], [3, 1], [4, 2]],
  [[0, 0], [1, 0], [2, 1], [3, 2], [4, 2]],
  [[0, 2], [1, 2], [2, 1], [3, 0], [4, 0]],
  [[0, 1], [1, 2], [2, 1], [3, 0], [4, 1]],
  [[0, 1], [1, 0], [2, 1], [3, 2], [4, 1]]
];


window.addEventListener('message', function(event){


	 var eData = event.data;

	 if(eData.show == true) {
      $(".showpage").addClass("show");
      $(".showpage").removeClass("hide");



    }else if(eData.show == false) {
      $(".showpage").addClass("hide");
      $(".showpage").removeClass("show");
    }



	if(eData.canspin == true) {

			spinnnn();
	}







});



  $(document).ready(function() {

    $(".showpage").addClass("hide");

    $('*').on('click', function(event) {
      var id = event.target.id;
      if(id.includes("listElem_")) {
        copyToClipboard("#"+id);
     }

    });
  });










// create the canvas
var canvas = $('<canvas width ="' + WIDTH + '" height="' + HEIGHT + '"></canvas>');
var ctx = canvas.get(0).getContext("2d");
$(canvas).appendTo('#stage');

// load images
var bg_img_ready = false;
var bg_img = new Image();
bg_img.onload = function () {
  bg_img_ready = true;
}
bg_img.src = "img/machine.png";

var tile1_img_ready = false;
var tile1_img = new Image();
tile1_img.onload = function () {
  tile1_img_ready = true;
}
tile1_img.src = "img/square.png";

var tile2_img_ready = false;
var tile2_img = new Image();
tile2_img.onload = function () {
  tile2_img_ready = true;
}
tile2_img.src = "img/cross.png";

var tile3_img_ready = false;
var tile3_img = new Image();
tile3_img.onload = function () {
  tile3_img_ready = true;
}
tile3_img.src = "img/spades.png";

var tile4_img_ready = false;
var tile4_img = new Image();
tile4_img.onload = function () {
  tile4_img_ready = true;
}
tile4_img.src = "img/heart.png";

var tile5_img_ready = false;
var tile5_img = new Image();
tile5_img.onload = function () {
  tile5_img_ready = true;
}
tile5_img.src = "img/cards.png";

var tile6_img_ready = false;
var tile6_img = new Image();
tile6_img.onload = function () {
  tile6_img_ready = true;
}
tile6_img.src = "img/dice.png";

var tile7_img_ready = false;
var tile7_img = new Image();
tile7_img.onload = function () {
  tile7_img_ready = true;
}
tile7_img.src = "img/chip.png";

var dollar_img_ready = false;
var dollar_img = new Image();
dollar_img.onload = function () {
  dollar_img_ready = true;
}
dollar_img.src = "img/dollar.png";




var horseshoe_img_ready = false;
var horseshoe_img = new Image();
horseshoe_img.onload = function () {
  horseshoe_img_ready = true;
}
horseshoe_img.src = "img/horseshoe.png";


// load audio
//var spin_sound = new Audio("sound/spin.mp3");
//var bet_sound = new Audio("sound/bet.mp3");
//var coin_sound = new Audio("sound/coin.wav");

// compare line and winning sequence
// return false if no match and true if match
function results_sequence_match(results, winning_sequence) {
  for (var i = 0; i < winning_sequence.length; i++) {
    if (winning_sequence[i] != results[i]) {
      return false;
    }
  };
  return true;
}

// get results from reel based on line_map argument
// return the results of one line
function get_results_line_from_reel(line_map) {
  var results = [];
  for (var i = 0; i < line_map.length; i++) {
    var reel_number = line_map[i][0];
    var row = line_map[i][1];
    results.push(reels_top[reel_number].tiles[row]);
  };
  return results;
}

// return array of all results
function get_all_results(lines_to_get) {
  all_results = [];
  for (var i = 0; i < lines_to_get; i++) {
    all_results.push(get_results_line_from_reel(LINE_MAP[i]));
  };
  return all_results;
}

// calculate winnings from results
function calculate_winnings(all_results) {
  game_state.highlight_tiles = [];
  for (var i = 0; i < all_results.length; i++) {
    for (var j = 0; j < WINNING_SEQUENCES.length; j++) {
      if (results_sequence_match(all_results[i], WINNING_SEQUENCES[j][0])) {

		if (WINNING_SEQUENCES[j][1] == 1001) {
		freespins += 1
		} else if (WINNING_SEQUENCES[j][1] == 1002) {
		freespins += 3
		break;
		} else if (WINNING_SEQUENCES[j][1] == 1003) {
		freespins += 5
		break;
		} else if (WINNING_SEQUENCES[j][1] == 1004) {
		freespins += 10
		break;
		} else {
        game_state.win += (WINNING_SEQUENCES[j][1]*playerbet);
        game_state.highlight_tiles.push(i);
        game_state.current_line_winnings_map.push([i, WINNING_SEQUENCES[j][1]]);
        break;
		}
      }
    };
  };
}

function rotate_highlight_tiles() {
  game_state.show_highlight_tiles = true;
  game_state.current_highlight_tiles_counter++;
  var current_index = game_state.current_highlight_tiles_counter % game_state.highlight_tiles.length;
  game_state.current_highlight_tiles = game_state.highlight_tiles[current_index];
}

function GameState(win, paid, credits, bet, tiles, highlight_tiles, show_highlight_tiles) {
  this.win = win;
  this.paid = paid;
  this.credits = credits;
  this.bet = bet;
  this.tiles = tiles;
  this.highlight_tiles = highlight_tiles;
  this.show_highlight_tiles = show_highlight_tiles;
  this.current_highlight_tiles = 0;
  this.current_highlight_tiles_counter = 0;
  this.rotate_highlight_loop = null;
  this.spin_click_shield = false;
  this.show_lines = true;
  this.current_line_winnings_map = [];
  this.transfer_win_to_credits = function() {
   if (freespins >= 1) {

    setTimeout(function(){

			freespins -= 1
			spinnnn()
		}, 1500);
		}

    var i = this.win;
    var counter = 0;
    while (i > 0) {
      i -= 1;
      counter += 0;
      setTimeout(function(){
       // coin_sound.currentTime = 0;
        //coin_sound.play();
        game_state.paid += 1;
		playermoney +=1;
        game_state.credits += 1;
        if (game_state.win == game_state.paid) {
		  $.post('http://slotmachine_1/payforplayer', JSON.stringify(game_state.win));






		  game_state.spin_click_shield = false;

        }
      }, counter);
    }
  }
}

var game_state = new GameState(0, 0, 50, 0, [], [], true);

game_state.tiles.push(new Tile('whitebook', tile1_img, '1'));
game_state.tiles.push(new Tile('greenbook', tile2_img, '1'));
game_state.tiles.push(new Tile('ia', tile3_img, '1'));
game_state.tiles.push(new Tile('money', tile4_img, '1'));
game_state.tiles.push(new Tile('seattle', tile5_img, '1'));
game_state.tiles.push(new Tile('car', tile6_img, '1'));
game_state.tiles.push(new Tile('fruit', tile7_img, '1'));
game_state.tiles.push(new Tile('dollar', dollar_img, '1'));
game_state.tiles.push(new Tile('horseshoe', horseshoe_img, '1'));
function Tile(name, img, value) {
  this.name = name;
  this.img = img;
  this.value = value;
}

function Reel(x, y, x_vel, y_vel, y_acc, tiles) {
  this.x = x;
  this.y = y;
  this.x_vel = x_vel;
  this.y_vel = y_vel;
  this.y_acc = y_acc;
  this.tiles = tiles;
  this.draw = function() {
    for (var i = 0; i < this.tiles.length; i++) {
      // drawImage(image, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight)
      y_offset = this.y + 100 * i + 19;
      ctx.drawImage(game_state.tiles[this.tiles[i]].img, 0, 0, 100, 100, this.x, y_offset, 100, 100);
    };
  };
  this.update = function(modifier) {
    // update velocity
    // this.y_vel += this.y_acc;

    // update position
    this.y += this.y_vel;

    // console.log(this.y);


  };
}

function ButtonObject(x, y, width, height, handler) {
  this.x = x;
  this.y = y;
  this.width = width;
  this.height = height;

    // mouse parameter holds the mouse coordinates
    this.handleClick = function(mouse) {

        // perform hit test between bounding box
        // and mouse coordinates

        if (this.x < mouse.x &&
          this.x + this.width > mouse.x &&
          this.y < mouse.y &&
          this.y + this.height > mouse.y) {

            // hit test succeeded, handle the click event!

        handler();
        return true;
      }

        // hit test did not succeed
        return false;
    }

    // draw function
    this.draw = function() {
      ctx.fillStyle = "white";
      ctx.fillRect(this.x, this.y, this.width, this.height);
    }
}

// subclass of ButtonObject
function BetButton(x, y, width, height, handler, bet_amount) {
  ButtonObject.apply(this, arguments);
  this.bet_amount = bet_amount;
  this.handleClick = function(mouse) {

        if (this.x < mouse.x &&
          this.x + this.width > mouse.x &&
          this.y < mouse.y &&
          this.y + this.height > mouse.y) {

		  if (game_state.spin_click_shield) {

		} else {







          handler(bet_amount);
        game_state.show_lines = true;
        game_state.show_highlight_tiles = false;
      //  bet_sound.currentTime = 0;
        //bet_sound.play();
          return true;
      }
	  }
  }
}







function post(name, data) {
    $.post('http://slotmachine_1/'+name, JSON.stringify(data));
}


function CloseButton(x,y,width,height) {

  ButtonObject.apply(this, arguments);

  this.handleClick = function(mouse) {

        if (this.x < mouse.x &&
          this.x + this.width > mouse.x &&
          this.y < mouse.y &&
          this.y + this.height > mouse.y) {

          post("close", {});

          return true;
      }
  }
}




var change_bet_amount = function(bet_amount) {
  game_state.bet = bet_amount;
 if (freespins == 0) {
  if (game_state.spin_click_shield) {

  } else {

	 playerbet +=100;
  }


  if (playerbet >= 10001){
	playerbet = 0;
  }


 }

}

var spin_handler = function(){
if (freespins <=0 ) {
if (game_state.spin_click_shield) {

  } else {
$.post('http://slotmachine_1/playerpays', JSON.stringify(playerbet));

  }
}
}

var reels_top = [];


function spinnnn() {







  //spin_sound.currentTime = 0;
  //spin_sound.play();
  setTimeout(function(){
   // spin_sound.pause();
  }, 1600);
  game_state.spin_click_shield = true;
  clearInterval(game_state.rotate_highlight_loop);
  game_state.current_highlight_tiles_counter = 0;
  game_state.rotate_highlight_loop = 0;
  game_state.paid = 0;
  game_state.win = 0;
 // playermoney -= playerbet;
  game_state.show_highlight_tiles = false;
  game_state.show_lines = false;
  game_state.current_line_winnings_map = [];
  for (var i = 0; i < reels_bottom.length; i++) {
    reels_top = generate_reels(-1000);
    animate_reels(i);
  };
  setTimeout(function(){
    calculate_winnings(get_all_results(game_state.bet));
    game_state.transfer_win_to_credits();
    game_state.rotate_highlight_loop = setInterval(rotate_highlight_tiles, 2000);
    if (game_state.win == game_state.paid) {
      game_state.spin_click_shield = false;
    }
  }, 1500);

}
















var animate_reels = function(index){
  setTimeout(function(){
    reels_top[index].y_vel = 15;
    reels_bottom[index].y_vel = 15;
  }, 100 * index);
}

var button_object_array = [
  // x, y, width, height, click handler
  new ButtonObject(550, 450, 86, 80,spin_handler),
  new BetButton(473, 450, 64, 57, change_bet_amount, 9),
  new BetButton(396, 450, 64, 57, change_bet_amount, 9),
  new BetButton(319, 450, 64, 57, change_bet_amount, 9),
  new BetButton(242, 450, 64, 57, change_bet_amount, 9),
  new CloseButton(165, 450, 64, 57), //close
  ];

// returns an array of random numbers between 0 and length of tiles array
function generate_random_tile_list (num) {
  var random_tile_list = [];
  for (var i = 0; i < num; i++) {
    var random_num = Math.floor(Math.random() * game_state.tiles.length);
    random_tile_list.push(random_num);
  };
  return random_tile_list;
}

var generate_reels = function(starting_y){
  var reels = [];
  reels.push(new Reel(150, starting_y, 0, 0, 0, generate_random_tile_list(10)));
  reels.push(new Reel(250, starting_y, 0, 0, 0, generate_random_tile_list(10)));
  reels.push(new Reel(350, starting_y, 0, 0, 0, generate_random_tile_list(10)));
  reels.push(new Reel(450, starting_y, 0, 0, 0, generate_random_tile_list(10)));
  reels.push(new Reel(550, starting_y, 0, 0, 0, generate_random_tile_list(10)));
  return reels;
}

var reels_bottom = generate_reels(0);

// console.log(reels);

function draw_reel (reel) {
  for (var i = 0; i < reel.tiles.length; i++) {
    // drawImage(image, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight)
    y_offset = 100 * i;
    ctx.drawImage(game_state.tiles[reel.tiles[i]].img, 0, 0, 100, 100, reel.x, y_offset, 100, 100);
  };
}

// draw_reel(reels[0], 0);

// handle keyboard controls
var keysDown = {};

addEventListener("keydown", function (e) {
  keysDown[e.keyCode] = true;
  switch(e.keyCode){
    case 37: case 39: case 38:  case 40: // arrow keys
    case 32: e.preventDefault(); break; // space
    default: break; // do not block other keys
  }
  if (e.keyCode == 32) {

  }
}, false);

addEventListener("keyup", function (e) {
  delete keysDown[e.keyCode];
}, false);

// handle clicks
// http://www.ibm.com/developerworks/library/wa-games/
// calculate position of the canvas DOM element on the page
var canvasPosition = {
  x: canvas.offset().left,
  y: canvas.offset().top
};

canvas.on('click', function(e) {

  // use pageX and pageY to get the mouse position
  // relative to the browser window
  var mouse = {
    x: e.pageX - canvasPosition.x,
    y: e.pageY - canvasPosition.y
  }

  // iterate through all button objects
  // and call the onclick handler of each
  for (var i = 0; i < button_object_array.length; i++) {
    button_object_array[i].handleClick(mouse);
  };

  // now you have local coordinates,
  // which consider a (0,0) origin at the
  // top-left of canvas element
});


// reset the game
var reset = function () {

};

// update game objects
var update = function (modifier) {
  for (var i = 0; i < reels_bottom.length; i++) {
    reels_bottom[i].update(modifier);
  };
  for (var i = 0; i < reels_top.length; i++) {
    if (reels_top[i].y >= 0) {
      reels_top[i].y_vel = 0;
      reels_bottom = reels_top;
      reels_bottom[i].y = 0;
    }
    reels_top[i].update(modifier);
  };
};

// draw everything
var render = function () {
  // draw white background
  ctx.fillStyle = "rgba(0,0,0,0)";
  ctx.fillRect(0, 0, WIDTH, HEIGHT);

  // draw reels
  for (var i = 0; i < reels_bottom.length; i++) {
    reels_bottom[i].draw();
  };
  for (var i = 0; i < reels_top.length; i++) {
    reels_top[i].draw();
  };

  for (var i = 0; i < button_object_array.length; i++) {
    button_object_array[i].draw();
  };

  // draw bg img
  ctx.drawImage(bg_img, 0, 0, 800, 600, 0, 0, 800, 600);

  // draw game states
  if (freespins == 0) {
  ctx.fillStyle = "#000000"
  ctx.font = "25px 'Titan One', cursive";
  ctx.textAlign = "right";
  ctx.textBaseline = "top";
 // ctx.fillText(game_state.win, 265, 358);
  ctx.fillText("Win " + game_state.paid+"$", 385, 367);

  ctx.fillText("Bet " +playerbet+"$", 595, 367);


  // draw game state highlight tiles
  } else {
	   ctx.fillStyle = "#000000"
	ctx.font = "21px 'Titan One', cursive";
	ctx.textAlign = "right";
	ctx.textBaseline = "top";
	  ctx.fillText("Freespins " +freespins, 395, 367);
  ctx.fillText("Win " + game_state.paid+"$", 625, 367);
  }


  if (game_state.show_highlight_tiles && game_state.highlight_tiles.length && !game_state.show_lines) {
    var winnings_x_coord = 155;
    var winnings_y_coord = 0;
    switch(game_state.current_highlight_tiles) {
      case 0:
        ctx.fillStyle = "rgba(0, 147, 68, 0.5)";
        winnings_y_coord = 125;
        break;
      case 1:
        ctx.fillStyle = "rgba(214, 223, 35, 0.5)";
        winnings_y_coord = 25;
        break;
      case 2:
        ctx.fillStyle = "rgba(42, 56, 143, 0.5)";
        winnings_y_coord = 225;
        break;
      case 3:
        ctx.fillStyle = "rgba(237, 28, 36, 0.5)";
        winnings_y_coord = 25;
        break;
      case 4:
        ctx.fillStyle = "rgba(211, 91, 146, 0.5)";
        winnings_y_coord = 225;
        break;
      case 5:
        ctx.fillStyle = "rgba(251, 175, 63, 0.5)";
        winnings_y_coord = 25;
        break;
      case 6:
        ctx.fillStyle = "rgba(101, 44, 144, 0.5)";
        winnings_y_coord = 225;
        break;
      case 7:
        ctx.fillStyle = "rgba(140, 198, 62, 0.5)";
        winnings_y_coord = 125;
        break;
      case 8:
        ctx.fillStyle = "rgba(0, 173, 239, 0.5)";
        winnings_y_coord = 125;
        break;
    }
    for (var j = 0; j < 5; j++) {
      var x_coord = LINE_MAP[game_state.current_highlight_tiles][j][0] * 100 + 150;
      var y_coord = LINE_MAP[game_state.current_highlight_tiles][j][1] * 100 + 20;
      ctx.fillRect(x_coord, y_coord, 100, 100);
    };
    for (var i = 0; i < game_state.current_line_winnings_map.length; i++) {
      if (game_state.current_line_winnings_map[i][0] == game_state.current_highlight_tiles) {
        ctx.textAlign = "left";
        ctx.fillStyle = "#231F20";
        ctx.fillText(game_state.current_line_winnings_map[i][1], winnings_x_coord, winnings_y_coord);
      }
    };
  }

  // draw number balls

};

// the main game loop
var main = function () {
  var now = Date.now();
  var delta = now - then;

  update(delta / 1000);
  render();

  then = now;
};

// let's play this game!
reset();
var then = Date.now();
var main_loop = setInterval(main, 16); // run script every 16 milliseconds, approx 60 FPS
