$(function () {
	$(".account-user").click(function(){
	$(".account-list").toggle(500);
	});
	$(".account-list").mouseleave(function(){
		$(this).hide();
	});
})
