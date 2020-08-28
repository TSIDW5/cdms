require('@rails/ujs').start();
require('turbolinks').start();

require('config/bootstrap');
require('jquery-mask-plugin');

document.addEventListener('turbolinks:load', () => {
   $('.mask-cpf').mask('000.000.000-00');
});
