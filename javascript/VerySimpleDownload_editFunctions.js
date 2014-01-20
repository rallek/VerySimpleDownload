'use strict';


/**
 * Resets the value of an upload / file input field.
 */
function vesidoResetUploadField(fieldName)
{
    if ($(fieldName) != undefined) {
        $(fieldName).setAttribute('type', 'input');
        $(fieldName).setAttribute('type', 'file');
    }
}

/**
 * Initialises the reset button for a certain upload input.
 */
function vesidoInitUploadField(fieldName)
{
    if ($('reset' + fieldName.capitalize() + 'Val') != undefined) {
        $('reset' + fieldName.capitalize() + 'Val').observe('click', function (evt) {
            evt.preventDefault();
            vesidoResetUploadField(fieldName);
        }).removeClassName('z-hide');
    }
}

