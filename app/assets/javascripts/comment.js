document.addEventListener('turbolinks:load', function(){
  $(document).ready(function(){
  	$("button#add-reply").click(function(){
    	$(this).parent().find('form').first().find(".reply-area").toggle();
    	$(this).parent().find('form').first().find(".reply-button").toggle();
  	});
  });
  }
);
