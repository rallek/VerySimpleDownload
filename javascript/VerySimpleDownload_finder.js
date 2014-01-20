'use strict';

var currentVerySimpleDownloadEditor = null;
var currentVerySimpleDownloadInput = null;

/**
 * Returns the attributes used for the popup window. 
 * @return {String}
 */
function getPopupAttributes()
{
    var pWidth, pHeight;

    pWidth = screen.width * 0.75;
    pHeight = screen.height * 0.66;
    return 'width=' + pWidth + ',height=' + pHeight + ',scrollbars,resizable';
}

/**
 * Open a popup window with the finder triggered by a Xinha button.
 */
function VerySimpleDownloadFinderXinha(editor, vesidoURL)
{
    var popupAttributes;

    // Save editor for access in selector window
    currentVerySimpleDownloadEditor = editor;

    popupAttributes = getPopupAttributes();
    window.open(vesidoURL, '', popupAttributes);
}

/**
 * Open a popup window with the finder triggered by a CKEditor button.
 */
function VerySimpleDownloadFinderCKEditor(editor, vesidoURL)
{
    // Save editor for access in selector window
    currentVerySimpleDownloadEditor = editor;

    editor.popup(
        Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=VerySimpleDownload&type=external&func=finder&editor=ckeditor',
        /*width*/ '80%', /*height*/ '70%',
        'location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,scrollbars=yes'
    );
}



var verysimpledownload = {};

verysimpledownload.finder = {};

verysimpledownload.finder.onLoad = function (baseId, selectedId)
{
    $$('div.categoryselector select').invoke('observe', 'change', verysimpledownload.finder.onParamChanged);
    $('verySimpleDownloadSort').observe('change', verysimpledownload.finder.onParamChanged);
    $('verySimpleDownloadSortDir').observe('change', verysimpledownload.finder.onParamChanged);
    $('verySimpleDownloadPageSize').observe('change', verysimpledownload.finder.onParamChanged);
    $('verySimpleDownloadSearchGo').observe('click', verysimpledownload.finder.onParamChanged);
    $('verySimpleDownloadSearchGo').observe('keypress', verysimpledownload.finder.onParamChanged);
    $('verySimpleDownloadSubmit').addClassName('z-hide');
    $('verySimpleDownloadCancel').observe('click', verysimpledownload.finder.handleCancel);
};

verysimpledownload.finder.onParamChanged = function ()
{
    $('verySimpleDownloadSelectorForm').submit();
};

verysimpledownload.finder.handleCancel = function ()
{
    var editor, w;

    editor = $F('editorName');
    if (editor === 'xinha') {
        w = parent.window;
        window.close();
        w.focus();
    } else if (editor === 'tinymce') {
        vesidoClosePopup();
    } else if (editor === 'ckeditor') {
        vesidoClosePopup();
    } else {
        alert('Close Editor: ' + editor);
    }
};


function getPasteSnippet(mode, itemId)
{
    var itemUrl, itemTitle, itemDescription, pasteMode;

    itemUrl = $F('url' + itemId);
    itemTitle = $F('title' + itemId);
    itemDescription = $F('desc' + itemId);
    pasteMode = $F('verySimpleDownloadPasteAs');

    if (pasteMode === '2' || pasteMode !== '1') {
        return itemId;
    }

    // return link to item
    if (mode === 'url') {
        // plugin mode
        return itemUrl;
    } else {
        // editor mode
        return '<a href="' + itemUrl + '" title="' + itemDescription + '">' + itemTitle + '</a>';
    }
}


// User clicks on "select item" button
verysimpledownload.finder.selectItem = function (itemId)
{
    var editor, html;

    editor = $F('editorName');
    if (editor === 'xinha') {
        if (window.opener.currentVerySimpleDownloadEditor !== null) {
            html = getPasteSnippet('html', itemId);

            window.opener.currentVerySimpleDownloadEditor.focusEditor();
            window.opener.currentVerySimpleDownloadEditor.insertHTML(html);
        } else {
            html = getPasteSnippet('url', itemId);
            var currentInput = window.opener.currentVerySimpleDownloadInput;

            if (currentInput.tagName === 'INPUT') {
                // Simply overwrite value of input elements
                currentInput.value = html;
            } else if (currentInput.tagName === 'TEXTAREA') {
                // Try to paste into textarea - technique depends on environment
                if (typeof document.selection !== 'undefined') {
                    // IE: Move focus to textarea (which fortunately keeps its current selection) and overwrite selection
                    currentInput.focus();
                    window.opener.document.selection.createRange().text = html;
                } else if (typeof currentInput.selectionStart !== 'undefined') {
                    // Firefox: Get start and end points of selection and create new value based on old value
                    var startPos = currentInput.selectionStart;
                    var endPos = currentInput.selectionEnd;
                    currentInput.value = currentInput.value.substring(0, startPos)
                                        + html
                                        + currentInput.value.substring(endPos, currentInput.value.length);
                } else {
                    // Others: just append to the current value
                    currentInput.value += html;
                }
            }
        }
    } else if (editor === 'tinymce') {
        html = getPasteSnippet('html', itemId);
        window.opener.tinyMCE.activeEditor.execCommand('mceInsertContent', false, html);
        // other tinymce commands: mceImage, mceInsertLink, mceReplaceContent, see http://www.tinymce.com/wiki.php/Command_identifiers
    } else if (editor === 'ckeditor') {
        /** to be done*/
    } else {
        alert('Insert into Editor: ' + editor);
    }
    vesidoClosePopup();
};


function vesidoClosePopup()
{
    window.opener.focus();
    window.close();
}




//=============================================================================
// VerySimpleDownload item selector for Forms
//=============================================================================

verysimpledownload.itemSelector = {};
verysimpledownload.itemSelector.items = {};
verysimpledownload.itemSelector.baseId = 0;
verysimpledownload.itemSelector.selectedId = 0;

verysimpledownload.itemSelector.onLoad = function (baseId, selectedId)
{
    verysimpledownload.itemSelector.baseId = baseId;
    verysimpledownload.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    $('verySimpleDownloadObjectType').observe('change', verysimpledownload.itemSelector.onParamChanged);

    if ($(baseId + '_catidMain') != undefined) {
        $(baseId + '_catidMain').observe('change', verysimpledownload.itemSelector.onParamChanged);
    } else if ($(baseId + '_catidsMain') != undefined) {
        $(baseId + '_catidsMain').observe('change', verysimpledownload.itemSelector.onParamChanged);
    }
    $(baseId + 'Id').observe('change', verysimpledownload.itemSelector.onItemChanged);
    $(baseId + 'Sort').observe('change', verysimpledownload.itemSelector.onParamChanged);
    $(baseId + 'SortDir').observe('change', verysimpledownload.itemSelector.onParamChanged);
    $('verySimpleDownloadSearchGo').observe('click', verysimpledownload.itemSelector.onParamChanged);
    $('verySimpleDownloadSearchGo').observe('keypress', verysimpledownload.itemSelector.onParamChanged);

    verysimpledownload.itemSelector.getItemList();
};

verysimpledownload.itemSelector.onParamChanged = function ()
{
    $('ajax_indicator').removeClassName('z-hide');

    verysimpledownload.itemSelector.getItemList();
};

verysimpledownload.itemSelector.getItemList = function ()
{
    var baseId, pars, request;

    baseId = verysimpledownload.itemSelector.baseId;
    pars = 'ot=' + baseId + '&';
    if ($(baseId + '_catidMain') != undefined) {
        pars += 'catidMain=' + $F(baseId + '_catidMain') + '&';
    } else if ($(baseId + '_catidsMain') != undefined) {
        pars += 'catidsMain=' + $F(baseId + '_catidsMain') + '&';
    }
    pars += 'sort=' + $F(baseId + 'Sort') + '&' +
            'sortdir=' + $F(baseId + 'SortDir') + '&' +
            'searchterm=' + $F(baseId + 'SearchTerm');

    request = new Zikula.Ajax.Request('ajax.php?module=VerySimpleDownload&func=getItemListFinder', {
        method: 'post',
        parameters: pars,
        onFailure: function(req) {
            Zikula.showajaxerror(req.getMessage());
        },
        onSuccess: function(req) {
            var baseId;
            baseId = verysimpledownload.itemSelector.baseId;
            verysimpledownload.itemSelector.items[baseId] = req.getData();
            $('ajax_indicator').addClassName('z-hide');
            verysimpledownload.itemSelector.updateItemDropdownEntries();
            verysimpledownload.itemSelector.updatePreview();
        }
    });
};

verysimpledownload.itemSelector.updateItemDropdownEntries = function ()
{
    var baseId, itemSelector, items, i, item;

    baseId = verysimpledownload.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    itemSelector.length = 0;

    items = verysimpledownload.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.options[i] = new Option(item.title, item.id, false);
    }

    if (verysimpledownload.itemSelector.selectedId > 0) {
        $(baseId + 'Id').value = verysimpledownload.itemSelector.selectedId;
    }
};

verysimpledownload.itemSelector.updatePreview = function ()
{
    var baseId, items, selectedElement, i;

    baseId = verysimpledownload.itemSelector.baseId;
    items = verysimpledownload.itemSelector.items[baseId];

    $(baseId + 'PreviewContainer').addClassName('z-hide');

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (verysimpledownload.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id === verysimpledownload.itemSelector.selectedId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (selectedElement !== null) {
        $(baseId + 'PreviewContainer').update(window.atob(selectedElement.previewInfo))
                                      .removeClassName('z-hide');
    }
};

verysimpledownload.itemSelector.onItemChanged = function ()
{
    var baseId, itemSelector, preview;

    baseId = verysimpledownload.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    preview = window.atob(verysimpledownload.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    $(baseId + 'PreviewContainer').update(preview);
    verysimpledownload.itemSelector.selectedId = $F(baseId + 'Id');
};
