
function gameListingHandlers() {
  this.gameNameClicked = function(evt) {
    var id = evt.target.id.split('-')[1];
    // Show the dialog
    var gd = $("#game-detail");
    gd.css({top: '' + (evt.clientY - 15) + 'px', left: '160px'});
    gd.find('.game-detail-image').hide(); // just in case we don't get an image
    gd.find('.game-detail-liker').attr('id', 'gdliker-'+ id); // save Id in the dialog
    gd.show();

    $.get("/games/" + id + ".json", function(data, status){
      if (status === 'success') {
        gd.find('.game-detail-name').text(data.name);
        gd.find('.game-detail-likes').text(''+ data.likes + ' like' + (data.likes === 1 ? '' : 's'));
        gd.find('.game-detail-year').text(data.year);
        gd.find('.game-detail-publisher').text(data.manufacturer);
        gd.find('.game-detail-notes').text(data.notes);
        gd.find('.game-detail-active').text(data.is_active ? "true" : "false");
        if (data.image) {
          var img_div = gd.find('.game-detail-image');
          img_div.css('background-image', 'url(' + data.image + ')');
          img_div.show();
        }
        var window_height = $(window).height();
        var gd_height = gd.height();
        if (gd.offset().top + gd_height + 28 > window_height) {
          gd.css('top', '' + (window_height - (gd_height + 28)) + 'px');
        }
      }
    });
    evt.preventDefault();
    evt.stopPropagation();
  };

  this.likeGame = function(evt) {
    var id = parseInt(evt.target.id.split('-')[1]);
    $.post( "/likes.json", {like: {game_id: id }} ).done(function(data) {
      if (id === data.game_id && data.likes) { // extra robustness can't hurt
        $('#game-detail .game-detail-likes').text(''+ data.likes + ' like' + (data.likes === 1 ? '' : 's'));
      }
    });
    evt.preventDefault();
    evt.stopPropagation();
  };

  this.closeGameDetail = function(evt) {
    $("#game-detail").hide();
    evt.preventDefault();
    evt.stopPropagation();
  };

  this.testfunc = function(a, b) {
    return a + b;
  }
}

var game_listing_handlers = new gameListingHandlers();
