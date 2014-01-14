{* purpose of this template: build the Form to edit an instance of download *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/Simpledownload/javascript/Simpledownload_editFunctions.js'}
{pageaddvar name='javascript' value='modules/Simpledownload/javascript/Simpledownload_validation.js'}

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
<div class="simpledownload-download simpledownload-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {simpledownloadFormFrame}
    {formsetinitialfocus inputId='doctitel'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {formlabel for='doctitel' __text='Doctitel' mandatorysym='1' cssClass=''}
            {formtextinput group='download' id='doctitel' mandatory=true readOnly=false __title='Enter the doctitel of the download' textMode='singleline' maxLength=255 cssClass='required' }
            {simpledownloadValidationError id='doctitel' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='docdescription' __text='Docdescription' cssClass=''}
            {formtextinput group='download' id='docdescription' mandatory=false __title='Enter the docdescription of the download' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
        
        <div class="z-formrow">
            {assign var='mandatorySym' value='1'}
            {if $mode ne 'create'}
                {assign var='mandatorySym' value='0'}
            {/if}
            {formlabel for='uploaddocument' __text='Uploaddocument' mandatorysym=$mandatorySym cssClass=''}<br />{* break required for Google Chrome *}
            {if $mode eq 'create'}
                {formuploadinput group='download' id='uploaddocument' mandatory=true readOnly=false cssClass='required validate-upload' }
            {else}
                {formuploadinput group='download' id='uploaddocument' mandatory=false readOnly=false cssClass=' validate-upload' }
                <span class="z-formnote"><a id="resetUploaddocumentVal" href="javascript:void(0);" class="z-hide">{gt text='Reset to empty value'}</a></span>
            {/if}
            
                <span class="z-formnote">{gt text='Allowed file extensions:'} <span id="uploaddocumentFileExtensions">pdf, zip, doc, docx, xls, xlsx</span></span>
            {if $mode ne 'create'}
                {if $download.uploaddocument ne ''}
                    <span class="z-formnote">
                        {gt text='Current file'}:
                        <a href="{$download.uploaddocumentFullPathUrl}" title="{$formattedEntityTitle|replace:"\"":""}"{if $download.uploaddocumentMeta.isImage} rel="imageviewer[download]"{/if}>
                        {if $download.uploaddocumentMeta.isImage}
                            {thumb image=$download.uploaddocumentFullPath objectid="download-`$download.id`" preset=$downloadThumbPresetUploaddocument tag=true img_alt=$formattedEntityTitle}
                        {else}
                            {gt text='Download'} ({$download.uploaddocumentMeta.size|simpledownloadGetFileSize:$download.uploaddocumentFullPath:false:false})
                        {/if}
                        </a>
                    </span>
                {/if}
            {/if}
            {simpledownloadValidationError id='uploaddocument' class='required'}
            {simpledownloadValidationError id='uploaddocument' class='validate-upload'}
        </div>
    </fieldset>
    
    {include file='admin/include_categories_edit.tpl' obj=$download groupName='downloadObj'}
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$download}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$download.id}
        {notifydisplayhooks eventname='simpledownload.ui_hooks.downloads.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='simpledownload.ui_hooks.downloads.form_edit' id=null assign='hooks'}
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
    {/simpledownloadFormFrame}
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

        simdownAddCommonValidationRules('download', '{{if $mode ne 'create'}}{{$download.id}}{{/if}}');
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

        Zikula.UI.Tooltips($$('.simpledownload-form-tooltips'));
        simdownInitUploadField('uploaddocument');
    });

/* ]]> */
</script>
