document.addEventListener('turbolinks:load', function(){
    $("button#add-reply").click(function(){
    thisComment = $(this).parent();
    commentId = $(this).data('comment-id');
    thisComment.find("#edit_area_" + commentId).hide();
    thisComment.find("#reply_area_" + commentId).toggle();
  });

    $("button#comment-edit").click(function(){
    thisComment = $(this).parent();
    commentId = $(this).data('comment-id');
    thisComment.find("#reply_area_" + commentId).hide();
    thisComment.find("#edit_area_" + commentId).toggle();
  });
  }
);
