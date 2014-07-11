(function ($, window, document) {

    (function($,sr){

        // debouncing function from John Hann
        // http://unscriptable.com/index.php/2009/03/20/debouncing-javascript-methods/
        var debounce = function (func, threshold, execAsap) {
            var timeout;

            return function debounced () {
                var obj = this, args = arguments;
                function delayed () {
                    if (!execAsap)
                        func.apply(obj, args);
                    timeout = null; 
                }

                if (timeout)
                    clearTimeout(timeout);
                else if (execAsap)
                    func.apply(obj, args);

                timeout = setTimeout(delayed, threshold || 100); 
            };
        };

        // smartresize 
        jQuery.fn[sr] = function(fn){  return fn ? this.bind('resize', debounce(fn)) : this.trigger(sr); };

    })(jQuery,'smartresize');


    $.prototype.outerHTML = function (html) {
        //  Returns the HTML that makes up the current jQuery object
        return (html) ? this.before(html).remove() : $('<div/>').append(this.eq(0).clone()).html();
    };
    

    // Add in the functions below if the browser width is 700px +

    $(document).ready(function() {

        // Cache the link HTML
        var link_html = $('.map-link').outerHTML();

        // Cache the HTML that makes the iframe
        var iframe_html = '<div class="iframe"><iframe width="400" height="340" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.co.uk/maps?q=battersea+power+station&amp;ie=UTF8&amp;hl=en&amp;hq=&amp;t=m&amp;vpsrc=6&amp;hnear=Battersea+Power+Station,+Wandsworth,+Greater+London+SW8+5,+United+Kingdom&amp;ll=51.482024,-0.143852&amp;spn=0.036347,0.068493&amp;z=13&amp;output=embed"></iframe></div>';

        // set up a window resize selector
        $(window).smartresize(function() {
            // only fire our function if the res < 699px
            if ($(window).width() > 825) {
                // Change the Amiando registration link into the iframe embedded form

                $('a.map-link').replaceWith(iframe_html);
            } else {
                $('.iframe').replaceWith(link_html);
            }
        });

        // trigger the resize for the first time
        $(window).trigger('resize');

    });

}

(jQuery, this, this.document));