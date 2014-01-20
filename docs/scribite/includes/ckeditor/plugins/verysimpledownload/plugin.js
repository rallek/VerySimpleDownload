CKEDITOR.plugins.add('VerySimpleDownload', {
    requires: 'popup',
    lang: 'en,nl,de',
    init: function (editor) {
        editor.addCommand('insertVerySimpleDownload', {
            exec: function (editor) {
                var url = Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=VerySimpleDownload&type=external&func=finder&editor=ckeditor';
                // call method in VerySimpleDownload_Finder.js and also give current editor
                VerySimpleDownloadFinderCKEditor(editor, url);
            }
        });
        editor.ui.addButton('verysimpledownload', {
            label: 'Insert VerySimpleDownload object',
            command: 'insertVerySimpleDownload',
         // icon: this.path + 'images/ed_verysimpledownload.png'
            icon: '/modules/VerySimpleDownload/images/editor.png'
        });
    }
});
