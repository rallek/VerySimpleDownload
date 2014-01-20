{* purpose of this template: module configuration *}
{include file='admin/header.tpl'}
<div class="verysimpledownload-config">
    {gt text='Settings' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='config' size='small' __alt='Settings'}
        <h3>{$templateTitle}</h3>
    </div>

    {form cssClass='z-form'}
        {* add validation summary and a <div> element for styling the form *}
        {verysimpledownloadFormFrame}
            {formsetinitialfocus inputId='pageSize'}
            {gt text='Variables' assign='tabTitle'}
            <fieldset>
                <legend>{$tabTitle}</legend>
            
                <p class="z-confirmationmsg">{gt text='Here you can manage all basic settings for this application.'}</p>
            
                <div class="z-formrow">
                    {formlabel for='pageSize' __text='Page size' cssClass=''}
                        {formintinput id='pageSize' group='config' maxLength=255 __title='Enter the page size. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='here you can change the allowed file extensions' assign='toolTip'}
                    {formlabel for='myFileExtensions' __text='My file extensions' cssClass='verysimpledownload-form-tooltips ' title=$toolTip}
                        {formtextinput id='myFileExtensions' group='config' maxLength=255 __title='Enter the my file extensions.'}
                </div>
                <div class="z-formrow">
                    {gt text='here you can change the allowed file size' assign='toolTip'}
                    {formlabel for='myFileSize' __text='My file size' cssClass='verysimpledownload-form-tooltips ' title=$toolTip}
                        {formintinput id='myFileSize' group='config' maxLength=255 __title='Enter the my file size. Only digits are allowed.'}
                </div>
            </fieldset>

            <div class="z-buttons z-formbuttons">
                {formbutton commandName='save' __text='Update configuration' class='z-bt-save'}
                {formbutton commandName='cancel' __text='Cancel' class='z-bt-cancel'}
            </div>
        {/verysimpledownloadFormFrame}
    {/form}
</div>
{include file='admin/footer.tpl'}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        Zikula.UI.Tooltips($$('.verysimpledownload-form-tooltips'));
    });
/* ]]> */
</script>
