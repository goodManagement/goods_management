$(function(){
    $('.search-panel .dropdown-menu').find('a').click(function() {
		var param = $(this).attr("value");
		var concept = $(this).text();
		$('.search-panel span#search_concept').text(concept);
		$('.input-group #search_kind').val(param);
	});
});
