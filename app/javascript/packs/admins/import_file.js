$(function () {
    
    const baseUrl = window.origin;
    const registerUrl = `${baseUrl}${newElement.data('path')}`;

    var form;
    $('#fileUpload').change(function (event) {
        form = new FormData();
        form.append('fileUpload', event.target.files[0]); // para apenas 1 arquivo
        //var name = event.target.files[0].content.name; // para capturar o nome do arquivo com sua extenção
    });


    $('#btnEnviar').click(function () {
      const hasAuthenticityToken = Boolean($('[name="csrf-token"]').length);  
      
      $.post({
        url: registerUrl,
        data: {
            form,
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
});