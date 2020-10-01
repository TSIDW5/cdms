require('selectize/selectize.min.js');

$(document).on('turbolinks:before-cache', () => {
  window.CDMS.selectize.destroy();
});

$(document).on('turbolinks:load', () => {
  window.CDMS.selectize.init();
});

window.CDMS.selectize = {};

window.CDMS.selectize.init = () => {
  const selects = $('select.apply-selectize');

  if (selects.length > 0) {
    selects.selectize();
    $('.selectize-input input[placeholder]').attr('style', 'width: 100%;');
  }
};

window.CDMS.selectize.destroy = () => {
  $('select.apply-selectize').each((i, e) => {
    if (e.selectize !== undefined) {
      e.selectize.destroy();
    }
  });
};
