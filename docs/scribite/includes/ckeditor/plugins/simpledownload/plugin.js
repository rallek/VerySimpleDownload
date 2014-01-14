CKEDITOR.plugins.add('Simpledownload', {
    requires: 'popup',
    lang: 'en,nl,de',
    init: function (editor) {
        editor.addCommand('insertSimpledownload', {
            exec: function (editor) {
                var url = Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=Simpledownload&type=external&func=finder&editor=ckeditor';
                // call method in Simpledownload_Finder.js and also give current editor
                SimpledownloadFinderCKEditor(editor, url);
            }
        });
        editor.ui.addButton('simpledownload', {
            label: 'Insert Simpledownload object',
            command: 'insertSimpledownload',
         // icon: this.path + 'images/ed_simpledownload.png'
            icon: '/modules/Simpledownload/images/editor.png'
        });
    }
});
