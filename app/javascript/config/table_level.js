$(document).on('turbolinks:load', () => {
    Array.from(document.getElementsByClassName('selected')).forEach(element => {
        element.addEventListener('click', function(e) {
            toggleHide(element.dataset.identifier);
            element.firstElementChild.classList.toggle('rotated');
        });
    });

    function toggleHide(identifier) {
        Array.from(document.querySelectorAll('[ data-identifier = "child-' + identifier + '"]')).forEach(element => {
            element.classList.toggle('d-none');
        });
    }
});