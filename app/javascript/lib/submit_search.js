$(document).on('turbolinks:load', () => {
  window.CDMS.submitSearch();
});

window.CDMS.submitSearch = () => {
  const el = 'input.enter-to-submit-search';
  const btn = '.submit-search';
  const baseUrl = $(el).data('url');

  const requestSearch = () => {
    const term = $(el).val();
    let url = baseUrl;

    if (term && term.trim().length > 0) {
      url += `/${encodeURI(term)}`;
    }

    return window.location.assign(url);
  };

  $(btn).click(() => requestSearch());

  $(el).keypress((e) => {
    const keycode = e.keyCode || e.which;
    if (keycode === 13) {
      requestSearch();
    }
  });
};
