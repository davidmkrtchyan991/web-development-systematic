jQuery(document).ready(function() {
    jQuery('.toggle-nav').click(function(e) {
        jQuery(this).toggleClass('active');
        jQuery('.top-bar-nav-menu ul').toggleClass('active');
 
        e.preventDefault();
    });
});