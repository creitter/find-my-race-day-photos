(function($) {
  var ready = function() {
    $("a.photographer_nav").click(function(event) { 
      event.stopPropagation();
      event.preventDefault();
      $.cookie('view', 'photographer');
      toggleView($("div.photographer"));
    });

    $("a.athlete_nav").click(function(event) { 
      event.stopPropagation();
      event.preventDefault();
      $.cookie('view', 'athlete');
      toggleView($("div.athlete"));
    });
    
    if ($.cookie('view') == 'athlete') {
      $("a.athlete_nav").click();
    } else {
      $("a.photographer_nav").click();
    }
    
  };
  
  //http://stackoverflow.com/questions/17600093/rails-javascript-not-loading-after-clicking-through-link-to-helper
  // Compatability for regular pages.
  $(document).ready(ready);

  // Rails 4.0 uses Turbolinks so we use on>page:load
  $(document).on('page:load', ready);
  
  
  function toggleView(show_view) {
    $("div.view").hide();
    $(show_view).show();
  }
})(jQuery);