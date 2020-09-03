$(document).on('turbolinks:load', () => {
  $('.custom-file-input').change(function () {
    $(this).siblings('.custom-file-label').text(this.files[0].name);
  });
});
