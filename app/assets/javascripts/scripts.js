$(document).ready(function() {
  /* loader.gif */
  $("#load").click(function() {
    $("#carregando").css("display", "block");
  });

  /* Remove #_=_ omniauth-facebook */
  if (window.location.href.indexOf('#_=_') > 0) {
    window.location = window.location.href.replace(/#.*/, '');
  }

  /* Progress Bar */
  $('body').show();
  $('.version').text(NProgress.version);
  NProgress.start();
  setTimeout(function() {
    NProgress.done();
    $('.fade').removeClass('out');
  }, 1000);
  $("#b-0").click(function() {
    NProgress.start();
  });
  $("#b-40").click(function() {
    NProgress.set(0.4);
  });
  $("#b-inc").click(function() {
    NProgress.inc();
  });
  $("#b-100").click(function() {
    NProgress.done();
  });

  /* Validation password */
  $('#password').keyup(function() {
    var pswd = $(this).val();
    if (pswd.length < 6) {
      $('#length').removeClass('valid').addClass('invalid');
    } else {
      $('#length').removeClass('invalid').addClass('valid');
    }
    if (pswd.match(/[A-z]/)) {
      $('#letter').removeClass('invalid').addClass('valid');
    } else {
      $('#letter').removeClass('valid').addClass('invalid');
    }

    //validate capital letter
    if (pswd.match(/[A-Z]/)) {
      $('#capital').removeClass('invalid').addClass('valid');
    } else {
      $('#capital').removeClass('valid').addClass('invalid');
    }

    //validate number
    if (pswd.match(/\d/)) {
      $('#number').removeClass('invalid').addClass('valid');
    } else {
      $('#number').removeClass('valid').addClass('invalid');
    }
  }).focus(function() {
    $('#pswd_info').show();
  }).blur(function() {
    $('#pswd_info').hide();
  });

  // form advertesiment mouseover mouseout

  $('#new-advertesiment').mouseover(function(){
    $('#new-advertesiment').css("height", "auto");
    $('.none').css("display", "block");
  });

  $('#new-advertesiment').mouseout(function(){
    $('.none').css("display", "none");
    $('#new-advertesiment').css("height", "85px");
  });

  // scrooling
  $(".scroll").click(function(event){
     event.preventDefault();
     $('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
  });

  // account-cancel
  $(document).ready(function() {
      $("#div-account-cancel").hide();
      $("#account-cancel").bind("click", function(event) {
        event.preventDefault();
        $("#div-account-cancel").slideToggle("slow");
      });
    });

  // button toTop
  $(function () {
    $(window).scroll(function () {
      if ($(this).scrollTop() != 0) {
        $('#toTop').fadeIn();
      } else {
        $('#toTop').fadeOut();
      }
    });
    $('#toTop').click(function () {
      $('body,html').animate({
        scrollTop: 0
      }, 800);
    });
  });

  // stars script
  var $input = $('#star_input');
  $('#star').starrr({
    max: 5,
    rating: $input.val(),
    change: function(e, value){
      $input.val(value).trigger('input');
    }
  });

  // script cariousel slider
  $('#carousel-text').html($('#slide-content-0').html());
  $('[id^=carousel-selector-]').click(function () {
    var id = this.id.substr(this.id.lastIndexOf("-") + 1);
    var id = parseInt(id);
    $('#myCarousel').carousel(id);
  });

  $('#myCarousel').on('slid.bs.carousel', function (e) {
    var id = $('.item.active').data('slide-number');
    $('#carousel-text').html($('#slide-content-' + id).html());
  });
});
