{* Purpose of this template: edit view of generic item list content type *}

<div class="z-formrow">
    {gt text='Object type' domain='module_verysimpledownload' assign='objectTypeSelectorLabel'}
    {formlabel for='verySimpleDownloadObjectType' text=$objectTypeSelectorLabel}
        {verysimpledownloadObjectTypeSelector assign='allObjectTypes'}
        {formdropdownlist id='verySimpleDownloadOjectType' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
        <span class="z-sub z-formnote">{gt text='If you change this please save the element once to reload the parameters below.' domain='module_verysimpledownload'}</span>
</div>

{formvolatile}
{if $properties ne null && is_array($properties)}
    {nocache}
    {foreach key='registryId' item='registryCid' from=$registries}
        {assign var='propName' value=''}
        {foreach key='propertyName' item='propertyId' from=$properties}
            {if $propertyId eq $registryId}
                {assign var='propName' value=$propertyName}
            {/if}
        {/foreach}
        <div class="z-formrow">
            {modapifunc modname='VerySimpleDownload' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
            {gt text='Category' domain='module_verysimpledownload' assign='categorySelectorLabel'}
            {assign var='selectionMode' value='single'}
            {if $hasMultiSelection eq true}
                {gt text='Categories' domain='module_verysimpledownload' assign='categorySelectorLabel'}
                {assign var='selectionMode' value='multiple'}
            {/if}
            {formlabel for="verySimpleDownloadCatIds`$propertyName`" text=$categorySelectorLabel}
                {formdropdownlist id="verySimpleDownloadCatIds`$propName`" items=$categories.$propName dataField="catids`$propName`" group='data' selectionMode=$selectionMode}
                <span class="z-sub z-formnote">{gt text='This is an optional filter.' domain='module_verysimpledownload'}</span>
        </div>
    {/foreach}
    {/nocache}
{/if}
{/formvolatile}

<div class="z-formrow">
    {gt text='Sorting' domain='module_verysimpledownload' assign='sortingLabel'}
    {formlabel text=$sortingLabel}
    <div>
        {formradiobutton id='verySimpleDownloadSortRandom' value='random' dataField='sorting' group='data' mandatory=true}
        {gt text='Random' domain='module_verysimpledownload' assign='sortingRandomLabel'}
        {formlabel for='verySimpleDownloadSortRandom' text=$sortingRandomLabel}
        {formradiobutton id='verySimpleDownloadSortNewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {gt text='Newest' domain='module_verysimpledownload' assign='sortingNewestLabel'}
        {formlabel for='verySimpleDownloadSortNewest' text=$sortingNewestLabel}
        {formradiobutton id='verySimpleDownloadSortDefault' value='default' dataField='sorting' group='data' mandatory=true}
        {gt text='Default' domain='module_verysimpledownload' assign='sortingDefaultLabel'}
        {formlabel for='verySimpleDownloadSortDefault' text=$sortingDefaultLabel}
    </div>
</div>

<div class="z-formrow">
    {gt text='Amount' domain='module_verysimpledownload' assign='amountLabel'}
    {formlabel for='verySimpleDownloadAmount' text=$amountLabel}
        {formintinput id='verySimpleDownloadAmount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {gt text='Template' domain='module_verysimpledownload' assign='templateLabel'}
    {formlabel for='verySimpleDownloadTemplate' text=$templateLabel}
        {verysimpledownloadTemplateSelector assign='allTemplates'}
        {formdropdownlist id='verySimpleDownloadTemplate' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div id="customTemplateArea" class="z-formrow z-hide">
    {gt text='Custom template' domain='module_verysimpledownload' assign='customTemplateLabel'}
    {formlabel for='verySimpleDownloadCustomTemplate' text=$customTemplateLabel}
        {formtextinput id='verySimpleDownloadCustomTemplate' dataField='customTemplate' group='data' mandatory=false maxLength=80}
        <span class="z-sub z-formnote">{gt text='Example' domain='module_verysimpledownload'}: <em>itemlist_[objecttype]_display.tpl</em></span>
</div>

<div class="z-formrow z-hide">
    {gt text='Filter (expert option)' domain='module_verysimpledownload' assign='filterLabel'}
    {formlabel for='verySimpleDownloadFilter' text=$filterLabel}
        {formtextinput id='verySimpleDownloadFilter' dataField='filter' group='data' mandatory=false maxLength=255}
        <span class="z-sub z-formnote">
            ({gt text='Syntax examples'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)
        </span>
</div>

{pageaddvar name='javascript' value='prototype'}
<script type="text/javascript">
/* <![CDATA[ */
    function vesidoToggleCustomTemplate() {
        if ($F('verySimpleDownloadTemplate') == 'custom') {
            $('customTemplateArea').removeClassName('z-hide');
        } else {
            $('customTemplateArea').addClassName('z-hide');
        }
    }

    document.observe('dom:loaded', function() {
        vesidoToggleCustomTemplate();
        $('verySimpleDownloadTemplate').observe('change', function(e) {
            vesidoToggleCustomTemplate();
        });
    });
/* ]]> */
</script>
