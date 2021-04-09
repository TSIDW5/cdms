const behavior = (val) => (val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009');

const options = {
  onKeyPress: (val, e, field, opts) => {
    const args = [val, e, field, opts];
    field.mask(behavior.apply({}, args), opts);
  },
};

$(document).on('turbolinks:load', () => {
  $('.phone_mask').mask(behavior, options);
});
