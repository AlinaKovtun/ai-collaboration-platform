document.addEventListener('turbolinks:load', function(){
  tinyMCE.init({
    selector: 'textarea.tinymce'
  });

  if(window.opener) {
    window.opener.location = '';
    window.close();
  }
 }
);
