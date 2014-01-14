// Simpledownload plugin for Xinha
// developed by Ralf Koester
//
// requires Simpledownload module (http://zikula.de)
//
// Distributed under the same terms as xinha itself.
// This notice MUST stay intact for use (see license.txt).

'use strict';

function Simpledownload(editor) {
    var cfg, self;

    this.editor = editor;
    cfg = editor.config;
    self = this;

    cfg.registerButton({
        id       : 'Simpledownload',
        tooltip  : 'Insert Simpledownload object',
     // image    : _editor_url + 'plugins/Simpledownload/img/ed_Simpledownload.gif',
        image    : '/modules/Simpledownload/images/editor.png',
        textMode : false,
        action   : function (editor) {
            var url = Zikula.Config.baseURL + 'index.php'/*Zikula.Config.entrypoint*/ + '?module=Simpledownload&type=external&func=finder&editor=xinha';
            SimpledownloadFinderXinha(editor, url);
        }
    });
    cfg.addToolbarElement('Simpledownload', 'insertimage', 1);
}

Simpledownload._pluginInfo = {
    name          : 'Simpledownload for xinha',
    version       : '0.0.1',
    developer     : 'Ralf Koester',
    developer_url : 'http://zikula.de',
    sponsor       : 'ModuleStudio 0.6.1',
    sponsor_url   : 'http://modulestudio.de',
    license       : 'htmlArea'
};
