$(document).ready(function(e){
    $('.search-panel .dropdown-menu').find('a').click(function(e) {
		e.preventDefault();
		var param = $(this).attr("href").replace("#","");
		var concept = $(this).text();
		$('.search-panel span#search_concept').text(concept);
		$('.input-group #search_param').val(param);
	});
  $('input[type="checkbox"]').on('change', function() {
    var btn = document.getElementById('btn');
    if($(this).prop("checked")=="1"){
        $('.btn').removeClass("disabled");
        btn.removeAttribute('disabled');
    } else {
        $('.btn').addClass("disabled");
        btn.setAttribute('disabled', 'disabled');
    }

  });

});
