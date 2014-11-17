// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require lodash.min
//= require jquery_nested_form
//= require ckeditor/init
//= require chosen.jquery.min
//= require jquery.validate.min
//= require nanobar.min
//= require slick
//= require image_preview
//= require posts
//= require jquery.tagsinput.min
//= require_tree .

$(function(){ $(document).foundation(); });

$(document).ready(function(){
  $('.slideshow').slick({
    dots: true,
    infinite: true,
    prevArrow: $('#prevArrow'),
    nextArrow: $('#nextArrow'),
    autoplay: true,
    autoplaySpeed: 10000,
    lazyLoad: 'progressive'
  });
});

// animate scroll to
$(function() {
  $('a[href*=#]:not([href=#])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top - 45
        }, 1000);
        return false;
      }
    }
  });
});
