var myFunc = function(obj, hideArea, hideButton, toggleArea, toggleButton) {
    $(obj).click(function(){
    thisComment = $(this).parent();
    commentId = $(this).data('comment-id');
    thisComment.find(hideArea+commentId).hide();
    thisComment.find(hideButton+commentId).hide();
    thisComment.find(toggleArea+commentId).toggle();
    thisComment.find(toggleButton+commentId).toggle();
  });
};

document.addEventListener('turbolinks:load', function(){
    myFunc("button#add-reply", "#edit_area_", "#edit_button_", "#reply_area_", "#reply_button_");
    myFunc("button#comment-edit", "#reply_area_", "#reply_button_", "#edit_area_", "#edit_button_");
  }
);
