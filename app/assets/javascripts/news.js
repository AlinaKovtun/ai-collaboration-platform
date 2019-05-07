document.addEventListener('turbolinks:load', function(){
  tinymce.remove();
  tinyMCE.init({
    selector: 'textarea.tinymce'
  });
 }
);
