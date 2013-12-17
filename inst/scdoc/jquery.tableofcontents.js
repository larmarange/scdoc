// Original script: https://github.com/shamess/jQuery-Table-of-Contents-Plugin 
// Adapted for scdoc
(function ( $ ) {
	var methods = {
		init : function ( options ) {
			// merge passed settings with our own
			settings = $.extend(
			{
				// only look for H# tags inside the scope
				scope: 'body',
				// the only tags we'll make headers from
				header_tags: [ 'h1', 'h2', 'h3', 'h4', 'h5', 'h6' ],
				// will the list be a UL, or OR?
				list_type: 'ul',
				// a list of elements to exclude
				exclude: ['.notoc'],
				// prefix for generated id
				prefix: 'toc_',
				// empty the $(this) before adding table? true for empty, false for append
				empty: false
			}, options );

			if (settings.empty == true) $(this).children().remove();
			
			
			var toc_id = 1,
                // whilst looping over the array of elements, this'll hold how deep we are
                // into indenting
                current_depth = null,
                // this is the text that'll populate the table. We'll be building it up as
                // a string (of html)
                table_text = "",
                headers = settings.header_tags.join(', '),
                exclude = settings.exclude.join(', ');
			
			// get all the tags we're looking for
			$(settings.scope).find(headers).not(exclude).each(function() {
				// what type of header is this?
				header_tag = this.tagName;
				if (header_tag == 'FIGURE') header_level = 1;
				else if (header_tag == 'TABLE') header_level = 1;
				else header_level = header_tag.substr(1,1);

				if (current_depth < header_level) { // if the current_depth is lower than this elements header_level, then we need to start a new <ul>
					table_text += "<ul>";
				} else if (current_depth > header_level) { // if it's greater, then we close the UL we've opened
					table_text += "</ul></li>";
				} else if (current_depth == header_level) {
					table_text += "</li>";
				}

				current_depth = header_level;

				// does the element already have an id?
				if  ($(this).attr('id')) {
					id = $(this).attr('id');
				} else {
					id = settings.prefix + toc_id;
					$(this).attr('id', id);
				}
				
				// now we need to start on the text for the table.
				if (header_tag == 'FIGURE') t = $(this).children('figcaption:first').text();
				else if (header_tag == 'TABLE') t = $(this).children('caption:first').text();
				else t = $(this).text();
				table_text += '<li><a href="#' + id + '">' + t + '</a>';
				
				toc_id++;
			});
			
			$(this).append($(table_text));
			
			return $(this);
		}
	};
	
	$.fn.tableofcontents = function (method) {
		// Method calling logic
		if ( methods[method] ) {
			return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if ( typeof method === 'object' || undefined == method ) {
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'Method ' +  method + ' does not exist on jQuery.tableofcontents' );
		}
	}
}) (jQuery);

