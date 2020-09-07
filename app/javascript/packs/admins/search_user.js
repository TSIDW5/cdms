const setupScript = () => {
  const searchElement = $('[data-id="search-path"]');
  const newElement = $('[data-id="new-path"]');
  const baseUrl = window.origin;
  const searchUrl = `${baseUrl}${searchElement.data('path')}`;
  const registerUrl = `${baseUrl}${newElement.data('path')}`;
  const searchInput = $('#user_search');
  const dropDown = $('[data-id="dropdown"]');
  const addButton = $('[data-id="add"]');
  const entityId = $('[data-id="entity-id"]').val();
  const userForm = $('[data-id="form_user"]');
  const entityName = $('#entity-name').val();

  const templateUser = ({ name, id }) => `
    <div class="dropdown-item" onclick="
      document.querySelector('#user-id').value = '${id}',
      document.querySelector('#user_search').value = '${name}'
    " data-user-option>
      ${name}
    </div>
  `;

  const showDropDown = () => dropDown.show();
  const hideDropDown = () => dropDown.hide();

  const handleAddUser = (e) => {
    e.preventDefault();

    const hasAuthenticityToken = Boolean($('[name="csrf-token"]').length);
    const userId = $('#user-id').val();
    const userTypeId = $('#user_type').val();

    $.post({
      url: registerUrl,
      data: {
        user_id: Number(userId),
        type_id: Number(userTypeId),
        ...(hasAuthenticityToken ? { authenticity_token: $('[name="csrf-token"]')[0].content } : {}),
      },
      success: ({ ok, errors }) => {
        if (ok) {
          window.location.reload();
        } else {
          // eslint-disable-next-line no-alert
          window.alert(errors.join(' '));
        }
      },
    });
  };

  const handleChangeSearchValue = (e) => {
    const keyword = e.target.value;

    $.get({
      url: searchUrl,
      data: { keyword, [entityName]: entityId },
      success: ({ users }) => {
        const usersWithTemplate = users.map(templateUser);

        if (users.length === 0) {
          hideDropDown();
        } else {
          showDropDown();
          dropDown.html(usersWithTemplate.join(''));
        }
      },
    });
  };

  searchInput.keypress(handleChangeSearchValue);
  searchInput.blur(() => setTimeout(hideDropDown, 100));
  addButton.click(handleAddUser);
  userForm.submit(handleAddUser);
};

setupScript();
