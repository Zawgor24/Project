//= require rails-ujs
//= require popper
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require toastr
//= require_tree .

try {
    window.$ = window.jQuery = require('jquery');
    window.Popper = require('popper.js').default;
    require('bootstrap');
} catch (e) {}
