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
//= require turbolinks
// require_tree .

//= require bootstrap.min
//= require jalali
//= require calendar
//= require calendar-setup
//= require calendar-fa
//= require pnotify.custom.min

//= require faye


//= require jquery
//= require best_in_place
//= require best_in_place.jquery-ui

$(document).ready(function() {
    /* Activating Best In Place */
    jQuery(".best_in_place").best_in_place();
});
$('.best_in_place').bind("ajax:success", function () {$(this).closest('tr').effect('highlight'); });

client = new Faye.Client('/faye');
window.client = client;