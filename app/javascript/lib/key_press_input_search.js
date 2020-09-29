window.CDMS.classes.KeyPressInputSearch = class {
  constructor(selector) {
    this.selector = selector;
    this.field = $(selector);

    this.dropdownId = `${this.field.attr('id')}-dropdown`;
    this.hiddenIdField = `${this.field.attr('id')}_id`;
    this.searchUrl = this.field.data('search-url');

    this.disableBrowserAutoComplete();
    this.applyEnvents();
    this.insertDropdown();
  }

  disableBrowserAutoComplete() {
    this.field.attr('autocomplete', 'off');
  }

  applyEnvents() {
    this.field.on('keyup', (e) => {
      if (!this.constructor.isLettersBackspaceOrDelete(e)) return;

      const term = $(this.field).val();

      if (term && term.length > 1) {
        this.searchEntity(term);
        return;
      }

      this.clearHiddenFieldVal();
      this.hideDropdown();
    });

    $(this.field).on('blur', () => {
      this.hideDropdown();
    });
  }

  searchEntity(term) {
    $.ajax({
      method: 'GET',
      dataType: 'JSON',
      url: `${this.searchUrl}/${term}`,
      success: (response) => {
        this.loadDropdownItens(response);
      },
    });
  }

  loadDropdownItens(items) {
    this.dropdown.html('');

    if (items.length === 0) {
      this.hideDropdown();
      return;
    }

    this.showDropdown();
    items.forEach((item) => {
      this.insertDropdownItem(item);
    });
  }

  clearHiddenFieldVal() {
    $(`#${this.hiddenIdField}`).val('');
  }

  insertDropdown() {
    this.field.after(`<div id='${this.dropdownId}' class="dropdown-menu dropdown-menu-search ml-3 p-1" aria-labelledby="${$(this.field).attr('id')}"></div>`);
    this.dropdown = $(`#${this.dropdownId}`);

    this.dropdown.on('mousedown', 'div.dropdown-item', (e) => {
      const { value } = e.target.attributes['data-value'];
      const { innerText } = e.target;

      this.field.val(innerText);
      $(`#${this.hiddenIdField}`).val(value);
    });
  }

  insertDropdownItem(item) {
    this.dropdown.append(`<div class="dropdown-item" data-value="${item.id}" >${item.name}</div>`);
  }

  showDropdown() {
    this.dropdown.addClass('show');
  }

  hideDropdown() {
    this.dropdown.removeClass('show');
  }

  static init(selector) {
    if (!window.CDMS.classes.KeyPressInputSearch.isOnPage(selector)) return;

    $(selector).each((index, el) => {
      new window.CDMS.classes.KeyPressInputSearch(el); // eslint-disable-line no-new
    });
  }

  static isOnPage(selector) {
    return $(selector).length > 0;
  }

  static isLettersBackspaceOrDelete(e) {
    return ((e.which <= 90 && e.which >= 48)
             || e.which === 8 || e.which === 46);
  }
};
