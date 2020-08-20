require('@rails/ujs').start();
require('turbolinks').start();

require('config/bootstrap');
require('config/jmask');
require('lib/choose_file');
require('jquery-mask-plugin');

document.addEventListener('turbolinks:load', () => {
  const inputs = $('[data-mask]').toArray();
  inputs.forEach((element) => {
    const mask = element.getAttribute('data-mask');
    $(element).mask(mask);
  });
});
