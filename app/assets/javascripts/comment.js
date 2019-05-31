var myFunc = function(obj, hideArea, toggleArea) {
    $(obj).click(function(){
    thisComment = $(this).parent();
    commentId = $(this).data('comment-id');
    thisComment.find(hideArea+commentId).hide();
    thisComment.find(toggleArea+commentId).toggle();
  });
};

document.addEventListener('turbolinks:load', function(){
    myFunc("button#add-reply", "#edit_area_", "#reply_area_");
    myFunc("button#comment-edit", "#reply_area_", "#edit_area_");
  }
);
