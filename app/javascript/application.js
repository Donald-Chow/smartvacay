// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"

// application.js (or any other JavaScript file)

// Show loading spinner on click
$(document).on('click', 'a, button, input[type="submit"]', function() {
  $('#loading-spinner').show();
});

// Hide loading spinner after page load
$(window).on('load', function() {
  $('#loading-spinner').hide();
});
