document.addEventListener('turbolinks:load', function(){
  	$("button#add-reply").click(function(){
      if ($(this).parent().find('form').find(".comment-edit-area").first().css("display") == "block") {
        $(this).parent().find('form').find(".comment-edit-area").first().hide();
        $(this).parent().find('form').find(".comment-edit-button").first().hide();
      }
    	$(this).parent().find('form').first().find(".reply-area").toggle();
    	$(this).parent().find('form').first().find(".reply-button").toggle();
  	});
  	$("button#comment-edit").click(function(){
      if ($(this).parent().find('form').first().find(".reply-area").css("display") == "block") {
        $(this).parent().find('form').first().find(".reply-area").hide();
        $(this).parent().find('form').first().find(".reply-button").hide();
      }
    	$(this).parent().find('form').find(".comment-edit-area").first().toggle();
    	$(this).parent().find('form').find(".comment-edit-button").first().toggle();
  	});
  }
);
