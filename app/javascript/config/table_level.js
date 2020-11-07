$(document).on('turbolinks:load', () => {
  function toggleHide(identifier) {
    Array.from(document.querySelectorAll(`[ data-identifier = "child-${identifier}"]`)).forEach((element) => {
      element.classList.toggle('d-none');
    });
  }
  Array.from(document.getElementsByClassName('selected')).forEach((element) => {
    element.addEventListener('click', () => {
      toggleHide(element.dataset.identifier);
      element.firstElementChild.classList.toggle('rotated');
    });
  });
});
