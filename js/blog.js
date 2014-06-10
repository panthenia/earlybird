$(function(){
	var $div_li =$("div.page-content-left-nav ul li");	
	$div_li.hover(function () {
		$(this).addClass("li-checked")
		.siblings().removeClass("li-checked");
	var index=$div_li.index(this);
	$("div.tab_box >div")
	.eq(index).show()
	.siblings().hide();
		
	});	
});
$(function(){
	var $courses_li=$("div.courses-detail-nav ul li");
	$courses_li.hover(function(){
		$(this).addClass("courser-hover")
		.siblings().removeClass("courser-hover");
		var indexc=$courses_li.index(this);
		$("div.courser-detail-list-wrap >div")
	.eq(indexc).show()
	.siblings("div").hide();	
	});
	$("#goback").click(function(){
		$(this).parent().hide().siblings().show();
		
	});
	$(".courses-eyes a").click(function(){
		$(".courses-list-wrap").hide();
		$(".courses-detail-wrap").show();
	});
});
$(function(){
	var $myblogli=$("div.blog-tools ul li");
	$myblogli.hover(function(){
		$(this).addClass("toolshover")
		.siblings().removeClass("toolshover");
		var indexm=$myblogli.index(this);
		$("div.newblog-wrap >div")
		.eq(indexm).show()
		.siblings().hide();
	});
})
$(function(){
	$(".favarite-table tr:odd").addClass("odd");
	$(".favarite-table tr:even").addClass("even");
	
	$(".selectAll").click(function () {
		$("[name=items]:checkbox").attr("checked",true);
	});
	$(".deselectAll").click(function () {
		$("[name=items]:checkbox").attr("checked",false);
	});
	$(".selectAll").click(function () {
		$("[name=schoolname]:checkbox").attr("checked",true);
	});
	$(".deselectAll").click(function () {
		$("[name=schoolname]:checkbox").attr("checked",false);
	});
	$(".favorite-tooles").click(function(){
		$(this).parent().remove();
	});
	$(".question-tooles-fill").click(function(){
		$(".qusetion-wrap").hide();
		$(".question-edit-wrap").show();
	});
	$(".goback").click(function(){
		$(".question-edit-wrap").hide();
		$(".question-view-wrap").hide();
		$(".qusetion-wrap").show();
	});
	$(".question-tooles-view").click(function(){
		$(".qusetion-wrap").hide();
		$(".question-view-wrap").show();
	});
});
$(function(){
	$(".event-close").toggle(function(){
 			$(this).text('Close');
			$(this).next().children().attr('src', 'css/image/shutdown.jpg');	
			$(this).parent().next().slideDown();
		},function(){
			$(this).text('View');
			$(this).next().children().attr('src', 'css/image/eyes.jpg');
			$(this).parent().next().slideUp();
		});
});
$(function () {
	$(".wj-show").click(function(){
		$(this).parent().siblings().toggle(500);
	})
	$(".account-user").click(function(){
		$(".account-list").toggle(500);
	});
	$(".account-list").mouseleave(function(){
		$(this).hide();
	});
	$(".classgroup").click(function () {
		$(".list-share-what").show(); 
	});
	$(".closeschool").click(function () {
		$(".selectschool").slideUp();
	});
	$(".blog-fj").click(function () {
		$(".upphoto").toggle(500);
	});
	$(".shutdown").click(function () {
		$(".upphoto").slideUp();
	});
	$(".schooltools input").click(function () {
		$(".selectschool").slideUp();
	});
	$(".comment-edit textarea").focus(function(){
		$(this).parent().next().show(500);
		$(this).animate({
			width:"380",
		    height:"35"
		},500)
	}).blur(function(){
		$(this).parent().next().hide(500);
		$(this).animate({
			width:"430",
		    height:"26"
		},500);
	})
	$(".list-share-what li").each(function(){
		$(this).click(function () {
			$(".list-share-what").hide();
		$(".classgroup-detail strong").text($(this).text());
		if($(this).index()==0){
			$(".selectschool").slideDown();
		}
		});
	});
});
$(function(){
       $("#conv_search").keyup(function(){
	      $("table.chatList tbody tr")
	      .hide()
		  .filter(":contains('"+($(this).val())+"')")
		  .show();
	   }).keyup();
})