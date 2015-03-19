(function($) {
  var ready = function() {
    
    // Photo set functions
    $('.jcarousel').jcarousel({
        // Configuration goes here
    });
    
    $('#nextPhotoSetBtn').click(function() {
      $('.jcarousel').jcarousel('scroll', '+=1');
    });


    $('#prevPhotoSetBtn').click(function() {
      $('.jcarousel').jcarousel('scroll', '-=1');      
    });
    
    $('.photo').click(function(event) {
      var photoId = $(this).data('photo-id');
      var showBig = $('#showBig');
      var img = $('img', this)[0].cloneNode();
      img.src = img.src.replace("thumb", "large");
      showBig.empty();
      
      showBig.append('<img src="' + img.src + '"></div>');
      showBig.show();
      showBig.parent().css({position: 'relative'});
      showBig.css({top: this.offsetHeight + this.offsetTop, left: this.offsetLeft + this.offsetWidth, position:'absolute'});
    });
    
    
  };    
 
 
//http://stackoverflow.com/questions/17600093/rails-javascript-not-loading-after-clicking-through-link-to-helper
// Compatability for regular pages.
  $(document).ready(ready);

// Rails 4.0 uses Turbolinks so we use on>page:load
  $(document).on('page:load', ready);

})(jQuery);