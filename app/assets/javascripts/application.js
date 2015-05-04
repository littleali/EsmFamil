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

//= require jquery.countdown
//= require jquery.countdown-fa

$(document).ready(function() {
    /* Activating Best In Place */
    jQuery(".best_in_place").best_in_place();
    // $(document).ready(function() {
    // $( "#Main" ).tabs();

    $('[id^=i_]').keydown(function(e) {
        var code = e.keyCode || e.which;

        if (code === 9) {  
            // e.preventDefault();
            var tabId = $(this).attr('id');
            var formId = 'f' + tabId.substring(1);
            $('#' + formId).submit();
            // alert('it works!');
        }
    });
    // $('[id^=i_]').click(function() {
    //     var tabId = $(this).attr('id');
    //     alert('Tab clicked: ' + tabId );

    //     // if (tabId == 'i') {
    //     //     $('#LoginForm').submit();
    //     // }else if (tabId == 'ui-id-2') {
    //     //     $('#form2').submit();
    //     // }else if (tabId == 'ui-id-3') {
    //     //     $('#form3').submit();
    //     // }
    // });
    // });
});
$('.best_in_place').bind("ajax:success", function () {$(this).closest('tr').effect('highlight'); });

client = new Faye.Client('/faye');
window.client = client;


//
//$(function() {
//    $('span.best_in_place').each(function() {
//        var attrs, el;
//        el = $(this);
//        attrs = el.data('html-attrs');
//        if (attrs && attrs['tabindex']) {
//            el.attr('tabindex', attrs['tabindex']);
//        }
//    }).focus(function() {
//        var el;
//        el = $(this);
//        el.click();
//    });
//});

//$(function() {
//    $('.best_in_place[data-html-attrs]').each(function() {
//        var attrs, el;
//        el = $(this);
//        attrs = el.data('html-attrs');
//        if (attrs && attrs['tabindex']) {
//            el.attr('tabindex', attrs['tabindex']);
//        }
//    }).focus(function() {
//        var el;
//        el = $(this);
//        el.click();
//    });
//});


$(function() {
    $('span.best_in_place[data-bip-html-attrs]').each(function() {
        var attrs, el;
        el = $(this);
        attrs = el.data('bip-html-attrs');
        if (attrs && attrs['tabindex']) {
            el.attr('tabindex', attrs['tabindex']);
        }
    }).focus(function() {
        var el;
        el = $(this);
        el.click();
    });
});

