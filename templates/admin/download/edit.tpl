{* purpose of this template: build the Form to edit an instance of download *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/VerySimpleDownload/javascript/VerySimpleDownload_editFunctions.js'}
{pageaddvar name='javascript' value='modules/VerySimpleDownload/javascript/VerySimpleDownload_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit download' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create download' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit download' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="verysimpledownload-download verysimpledownload-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {verysimpledownloadFormFrame}
    {formsetinitialfocus inputId='downloadTitle'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {gt text='The title for the download' assign='toolTip'}
            {formlabel for='downloadTitle' __text='Download title' mandatorysym='1' cssClass='verysimpledownload-form-tooltips' title=$toolTip}
            {formtextinput group='download' id='downloadTitle' mandatory=true readOnly=false __title='Enter the download title of the download' textMode='singleline' maxLength=255 cssClass='required' }
            {verysimpledownloadValidationError id='downloadTitle' class='required'}
        </div>
        
        <div class="z-formrow">
            {gt text='the description of the download' assign='toolTip'}
            {formlabel for='downloadDescription' __text='Download description' cssClass='verysimpledownload-form-tooltips' title=$toolTip}
            {formtextinput group='download' id='downloadDescription' mandatory=false __title='Enter the download description of the download' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
        
        <div class="z-formrow">
            {gt text='please select a file for uploading' assign='toolTip'}
            {assign var='mandatorySym' value='1'}
            {if $mode ne 'create'}
                {assign var='mandatorySym' value='0'}
            {/if}
            {formlabel for='fileUpload' __text='File upload' mandatorysym=$mandatorySym cssClass='verysimpledownload-form-tooltips' title=$toolTip}<br />{* break required for Google Chrome *}
            {if $mode eq 'create'}
                {formuploadinput group='download' id='fileUpload' mandatory=true readOnly=false cssClass='required validate-upload' }
            {else}
                {formuploadinput group='download' id='fileUpload' mandatory=false readOnly=false cssClass=' validate-upload' }
                <span class="z-formnote"><a id="resetFileUploadVal" href="javascript:void(0);" class="z-hide">{gt text='Reset to empty value'}</a></span>
            {/if}
            
                <span class="z-formnote">{gt text='Allowed file extensions:'} <span id="fileUploadFileExtensions">{$modvars.VerySimpleDownload.myFileExtensions}</span></span>
            <span class="z-formnote">{gt text='Allowed file size:'} {$modvars.VerySimpleDownload.myFileSize|verysimpledownloadGetFileSize:'':false:false}</span>
            {if $mode ne 'create'}
                {if $download.fileUpload ne ''}
                    <span class="z-formnote">
                        {gt text='Current file'}:
                        <a href="{$download.fileUploadFullPathUrl}" title="{$formattedEntityTitle|replace:"\"":""}"{if $download.fileUploadMeta.isImage} rel="imageviewer[download]"{/if}>
                        {if $download.fileUploadMeta.isImage}
                            {thumb image=$download.fileUploadFullPath objectid="download-`$download.id`" preset=$downloadThumbPresetFileUpload tag=true img_alt=$formattedEntityTitle}
                        {else}
                            {gt text='Download'} ({$download.fileUploadMeta.size|verysimpledownloadGetFileSize:$download.fileUploadFullPath:false:false})
                        {/if}
                        </a>
                    </span>
                {/if}
            {/if}
            {verysimpledownloadValidationError id='fileUpload' class='required'}
            {verysimpledownloadValidationError id='fileUpload' class='validate-upload'}
        </div>
    </fieldset>
    
    {include file='admin/include_categories_edit.tpl' obj=$download groupName='downloadObj'}
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$download}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$download.id}
        {notifydisplayhooks eventname='verysimpledownload.ui_hooks.downloads.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='verysimpledownload.ui_hooks.downloads.form_edit' id=null assign='hooks'}
    {/if}
    {if is_array($hooks) && count($hooks)}
        {foreach key='providerArea' item='hook' from=$hooks}
            <fieldset>
                {$hook}
            </fieldset>
        {/foreach}
    {/if}
    
    {* include return control *}
    {if $mode eq 'create'}
        <fieldset>
            <legend>{gt text='Return control'}</legend>
            <div class="z-formrow">
                {formlabel for='repeatCreation' __text='Create another item after save'}
                    {formcheckbox group='download' id='repeatCreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
    {foreach item='action' from=$actions}
        {assign var='actionIdCapital' value=$action.id|@ucwords}
        {gt text=$action.title assign='actionTitle'}
        {*gt text=$action.description assign='actionDescription'*}{* TODO: formbutton could support title attributes *}
        {if $action.id eq 'delete'}
            {gt text='Really delete this download?' assign='deleteConfirmMsg'}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass confirmMessage=$deleteConfirmMsg}
        {else}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass}
        {/if}
    {/foreach}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
    {/verysimpledownloadFormFrame}
{/form}
</div>
{include file='admin/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='removeImageArray'}


<script type="text/javascript">
/* <![CDATA[ */

    var formButtons, formValidator;

    function handleFormButton (event) {
        var result = formValidator.validate();
        if (!result) {
            // validation error, abort form submit
            Event.stop(event);
        } else {
            // hide form buttons to prevent double submits by accident
            formButtons.each(function (btn) {
                btn.addClassName('z-hide');
            });
        }

        return result;
    }

    document.observe('dom:loaded', function() {

        vesidoAddCommonValidationRules('download', '{{if $mode ne 'create'}}{{$download.id}}{{/if}}');
        {{* observe validation on button events instead of form submit to exclude the cancel command *}}
        formValidator = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = formValidator.validate();
        {{/if}}

        formButtons = $('{{$__formid}}').select('div.z-formbuttons input');

        formButtons.each(function (elem) {
            if (elem.id != 'btnCancel') {
                elem.observe('click', handleFormButton);
            }
        });

        Zikula.UI.Tooltips($$('.verysimpledownload-form-tooltips'));
        vesidoInitUploadField('fileUpload');
    });

/* ]]> */
</script>
