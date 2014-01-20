// VerySimpleDownload plugin for Xinha
// developed by Ralf Koester
//
// requires VerySimpleDownload module (http://support.zikula.de)
//
// Distributed under the same terms as xinha itself.
// This notice MUST stay intact for use (see license.txt).

'use strict';

function VerySimpleDownload(editor) {
    var cfg, self;

    this.editor = editor;
    cfg = editor.config;
    self = this;

    cfg.registerButton({
        id       : 'VerySimpleDownload',
        tooltip  : 'Insert VerySimpleDownload object',
     // image    : _editor_url + 'plugins/VerySimpleDownload/img/ed_VerySimpleDownload.gif',
        image    : '/modules/VerySimpleDownload/images/editor.png',
        textMode : false,
        action   : function (editor) {
            var url = Zikula.Config.baseURL + 'index.php'/*Zikula.Config.entrypoint*/ + '?module=VerySimpleDownload&type=external&func=finder&editor=xinha';
            VerySimpleDownloadFinderXinha(editor, url);
        }
    });
    cfg.addToolbarElement('VerySimpleDownload', 'insertimage', 1);
}

VerySimpleDownload._pluginInfo = {
    name          : 'VerySimpleDownload for xinha',
    version       : '1.0.0',
    developer     : 'Ralf Koester',
    developer_url : 'http://support.zikula.de',
    sponsor       : 'ModuleStudio 0.6.1',
    sponsor_url   : 'http://modulestudio.de',
    license       : 'htmlArea'
};
