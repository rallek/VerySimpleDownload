'use strict';

var currentSimpledownloadEditor = null;
var currentSimpledownloadInput = null;

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
function SimpledownloadFinderXinha(editor, simdownURL)
{
    var popupAttributes;

    // Save editor for access in selector window
    currentSimpledownloadEditor = editor;

    popupAttributes = getPopupAttributes();
    window.open(simdownURL, '', popupAttributes);
}

/**
 * Open a popup window with the finder triggered by a CKEditor button.
 */
function SimpledownloadFinderCKEditor(editor, simdownURL)
{
    // Save editor for access in selector window
    currentSimpledownloadEditor = editor;

    editor.popup(
        Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=Simpledownload&type=external&func=finder&editor=ckeditor',
        /*width*/ '80%', /*height*/ '70%',
        'location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,scrollbars=yes'
    );
}



var simpledownload = {};

simpledownload.finder = {};

simpledownload.finder.onLoad = function (baseId, selectedId)
{
    $$('div.categoryselector select').invoke('observe', 'change', simpledownload.finder.onParamChanged);
    $('simpledownloadSort').observe('change', simpledownload.finder.onParamChanged);
    $('simpledownloadSortDir').observe('change', simpledownload.finder.onParamChanged);
    $('simpledownloadPageSize').observe('change', simpledownload.finder.onParamChanged);
    $('simpledownloadSearchGo').observe('click', simpledownload.finder.onParamChanged);
    $('simpledownloadSearchGo').observe('keypress', simpledownload.finder.onParamChanged);
    $('simpledownloadSubmit').addClassName('z-hide');
    $('simpledownloadCancel').observe('click', simpledownload.finder.handleCancel);
};

simpledownload.finder.onParamChanged = function ()
{
    $('simpledownloadSelectorForm').submit();
};

simpledownload.finder.handleCancel = function ()
{
    var editor, w;

    editor = $F('editorName');
    if (editor === 'xinha') {
        w = parent.window;
        window.close();
        w.focus();
    } else if (editor === 'tinymce') {
        simdownClosePopup();
    } else if (editor === 'ckeditor') {
        simdownClosePopup();
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
    pasteMode = $F('simpledownloadPasteAs');

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
simpledownload.finder.selectItem = function (itemId)
{
    var editor, html;

    editor = $F('editorName');
    if (editor === 'xinha') {
        if (window.opener.currentSimpledownloadEditor !== null) {
            html = getPasteSnippet('html', itemId);

            window.opener.currentSimpledownloadEditor.focusEditor();
            window.opener.currentSimpledownloadEditor.insertHTML(html);
        } else {
            html = getPasteSnippet('url', itemId);
            var currentInput = window.opener.currentSimpledownloadInput;

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
    simdownClosePopup();
};


function simdownClosePopup()
{
    window.opener.focus();
    window.close();
}




//=============================================================================
// Simpledownload item selector for Forms
//=============================================================================

simpledownload.itemSelector = {};
simpledownload.itemSelector.items = {};
simpledownload.itemSelector.baseId = 0;
simpledownload.itemSelector.selectedId = 0;

simpledownload.itemSelector.onLoad = function (baseId, selectedId)
{
    simpledownload.itemSelector.baseId = baseId;
    simpledownload.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    $('simpledownloadObjectType').observe('change', simpledownload.itemSelector.onParamChanged);

    if ($(baseId + '_catidMain') != undefined) {
        $(baseId + '_catidMain').observe('change', simpledownload.itemSelector.onParamChanged);
    } else if ($(baseId + '_catidsMain') != undefined) {
        $(baseId + '_catidsMain').observe('change', simpledownload.itemSelector.onParamChanged);
    }
    $(baseId + 'Id').observe('change', simpledownload.itemSelector.onItemChanged);
    $(baseId + 'Sort').observe('change', simpledownload.itemSelector.onParamChanged);
    $(baseId + 'SortDir').observe('change', simpledownload.itemSelector.onParamChanged);
    $('simpledownloadSearchGo').observe('click', simpledownload.itemSelector.onParamChanged);
    $('simpledownloadSearchGo').observe('keypress', simpledownload.itemSelector.onParamChanged);

    simpledownload.itemSelector.getItemList();
};

simpledownload.itemSelector.onParamChanged = function ()
{
    $('ajax_indicator').removeClassName('z-hide');

    simpledownload.itemSelector.getItemList();
};

simpledownload.itemSelector.getItemList = function ()
{
    var baseId, pars, request;

    baseId = simpledownload.itemSelector.baseId;
    pars = 'ot=' + baseId + '&';
    if ($(baseId + '_catidMain') != undefined) {
        pars += 'catidMain=' + $F(baseId + '_catidMain') + '&';
    } else if ($(baseId + '_catidsMain') != undefined) {
        pars += 'catidsMain=' + $F(baseId + '_catidsMain') + '&';
    }
    pars += 'sort=' + $F(baseId + 'Sort') + '&' +
            'sortdir=' + $F(baseId + 'SortDir') + '&' +
            'searchterm=' + $F(baseId + 'SearchTerm');

    request = new Zikula.Ajax.Request('ajax.php?module=Simpledownload&func=getItemListFinder', {
        method: 'post',
        parameters: pars,
        onFailure: function(req) {
            Zikula.showajaxerror(req.getMessage());
        },
        onSuccess: function(req) {
            var baseId;
            baseId = simpledownload.itemSelector.baseId;
            simpledownload.itemSelector.items[baseId] = req.getData();
            $('ajax_indicator').addClassName('z-hide');
            simpledownload.itemSelector.updateItemDropdownEntries();
            simpledownload.itemSelector.updatePreview();
        }
    });
};

simpledownload.itemSelector.updateItemDropdownEntries = function ()
{
    var baseId, itemSelector, items, i, item;

    baseId = simpledownload.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    itemSelector.length = 0;

    items = simpledownload.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.options[i] = new Option(item.title, item.id, false);
    }

    if (simpledownload.itemSelector.selectedId > 0) {
        $(baseId + 'Id').value = simpledownload.itemSelector.selectedId;
    }
};

simpledownload.itemSelector.updatePreview = function ()
{
    var baseId, items, selectedElement, i;

    baseId = simpledownload.itemSelector.baseId;
    items = simpledownload.itemSelector.items[baseId];

    $(baseId + 'PreviewContainer').addClassName('z-hide');

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (simpledownload.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id === simpledownload.itemSelector.selectedId) {
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

simpledownload.itemSelector.onItemChanged = function ()
{
    var baseId, itemSelector, preview;

    baseId = simpledownload.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    preview = window.atob(simpledownload.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    $(baseId + 'PreviewContainer').update(preview);
    simpledownload.itemSelector.selectedId = $F(baseId + 'Id');
};
