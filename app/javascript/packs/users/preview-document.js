$( document ).ready(function() {
    let oldTitle = '';
    $('#print-button').on('click', () => {
        let title = document.title;
        oldTitle  = title;
        title = title
            .replace(/\s/g, "_")
            .replace(/[^a-zA-Zs-]/g, "")
            .substring(0, 20);

        document.title = title;
        window.print();
    })

    window.onafterprint=function(){
        document.title = oldTitle;
    }
});