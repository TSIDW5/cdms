require('lib/key_press_input_search');

$(document).on('turbolinks:load', () => {
  const selector = '#departments-members #department_user_user, #departments-add_member #department_user_user';
  const kpis = new window.CDMS.classes.KeyPressInputSearch(selector);
  kpis.init();
});
