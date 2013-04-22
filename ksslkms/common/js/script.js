
$(document).ready(function(){

	var $ads;  
	$('[id^=adsref-]').each(function() {  
		$ads = $('#ads-' + this.id.substr(7)).empty();
		$('ins:first', this).appendTo($ads);  
	});
	
	/* Cut double <br> tag for MSIE when is .xml */
	if(window.location.href.match(/\.xml$/)){
	if(jQuery.browser.msie ){
	$(".indent").each(function(){
		$(this).html( $(this).html().replace(/<br><br>/ig,'<br>') );
	} );
	}
	}
} );

