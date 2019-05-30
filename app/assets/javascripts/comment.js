document.addEventListener('turbolinks:load', function(){
    $("button#add-reply").click(function(){
      thisComment = $(this).parent();
      commentId = $(this).data('comment-id');
      if (thisComment.find('#edit_area_'+commentId).css("display") == "block") {
        thisComment.find("#edit_area_"+commentId).hide();
        thisComment.find("#edit_button_"+commentId).hide();
      }
      thisComment.find("#reply_area_"+commentId).toggle();
      thisComment.find("#reply_button_"+commentId).toggle();
    });

    $("button#comment-edit").click(function(){
      commentId = $(this).data('comment-id');
      thisComment = $(this).parent();
      if (thisComment.find('#reply_area_'+commentId).css("display") == "block") {
        thisComment.find("#reply_area_"+commentId).hide();
        thisComment.find("#reply_button_"+commentId).hide();
      }
      thisComment.find("#edit_area_"+commentId).toggle();
      thisComment.find("#edit_button_"+commentId).toggle();
    });
  }
);
