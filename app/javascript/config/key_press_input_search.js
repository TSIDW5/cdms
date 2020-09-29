require('lib/key_press_input_search');

$(document).on('turbolinks:load', () => {
  window.CDMS.classes.KeyPressInputSearch.init('input[data-search="keypress"]');
});
