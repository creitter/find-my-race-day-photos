(function($) {
  var ready = function() {
    $("a.photographer_nav").click(function(event) { 
      event.stopPropagation();
      event.preventDefault();
      $.cookie('view', 'photographer');
      toggleView($("div.photographer"), this);
    });

    $("a.athlete_nav").click(function(event) { 
      event.stopPropagation();
      event.preventDefault();
      $.cookie('view', 'athlete');
      toggleView($("div.athlete"), this);
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
  
  function toggleView(show_view, link) {
    $("div.view").hide().removeClass("active");
    $(show_view).show().addClass("active");
    $("li", $(link).closest("div.tabs")).removeClass("active");
    $(link).parent().addClass("active");
  }
})(jQuery);