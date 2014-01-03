{* Purpose of this template: edit view of generic item list content type *}

<div class="z-formrow">
    {gt text='Object type' domain='module_simpledownload' assign='objectTypeSelectorLabel'}
    {formlabel for='simpledownloadObjectType' text=$objectTypeSelectorLabel}
        {simpledownloadObjectTypeSelector assign='allObjectTypes'}
        {formdropdownlist id='simpledownloadOjectType' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
        <span class="z-sub z-formnote">{gt text='If you change this please save the element once to reload the parameters below.' domain='module_simpledownload'}</span>
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
            {modapifunc modname='Simpledownload' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
            {gt text='Category' domain='module_simpledownload' assign='categorySelectorLabel'}
            {assign var='selectionMode' value='single'}
            {if $hasMultiSelection eq true}
                {gt text='Categories' domain='module_simpledownload' assign='categorySelectorLabel'}
                {assign var='selectionMode' value='multiple'}
            {/if}
            {formlabel for="simpledownloadCatIds`$propertyName`" text=$categorySelectorLabel}
                {formdropdownlist id="simpledownloadCatIds`$propName`" items=$categories.$propName dataField="catids`$propName`" group='data' selectionMode=$selectionMode}
                <span class="z-sub z-formnote">{gt text='This is an optional filter.' domain='module_simpledownload'}</span>
        </div>
    {/foreach}
    {/nocache}
{/if}
{/formvolatile}

<div class="z-formrow">
    {gt text='Sorting' domain='module_simpledownload' assign='sortingLabel'}
    {formlabel text=$sortingLabel}
    <div>
        {formradiobutton id='simpledownloadSortRandom' value='random' dataField='sorting' group='data' mandatory=true}
        {gt text='Random' domain='module_simpledownload' assign='sortingRandomLabel'}
        {formlabel for='simpledownloadSortRandom' text=$sortingRandomLabel}
        {formradiobutton id='simpledownloadSortNewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {gt text='Newest' domain='module_simpledownload' assign='sortingNewestLabel'}
        {formlabel for='simpledownloadSortNewest' text=$sortingNewestLabel}
        {formradiobutton id='simpledownloadSortDefault' value='default' dataField='sorting' group='data' mandatory=true}
        {gt text='Default' domain='module_simpledownload' assign='sortingDefaultLabel'}
        {formlabel for='simpledownloadSortDefault' text=$sortingDefaultLabel}
    </div>
</div>

<div class="z-formrow">
    {gt text='Amount' domain='module_simpledownload' assign='amountLabel'}
    {formlabel for='simpledownloadAmount' text=$amountLabel}
        {formintinput id='simpledownloadAmount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {gt text='Template' domain='module_simpledownload' assign='templateLabel'}
    {formlabel for='simpledownloadTemplate' text=$templateLabel}
        {simpledownloadTemplateSelector assign='allTemplates'}
        {formdropdownlist id='simpledownloadTemplate' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div id="customTemplateArea" class="z-formrow z-hide">
    {gt text='Custom template' domain='module_simpledownload' assign='customTemplateLabel'}
    {formlabel for='simpledownloadCustomTemplate' text=$customTemplateLabel}
        {formtextinput id='simpledownloadCustomTemplate' dataField='customTemplate' group='data' mandatory=false maxLength=80}
        <span class="z-sub z-formnote">{gt text='Example' domain='module_simpledownload'}: <em>itemlist_[objecttype]_display.tpl</em></span>
</div>

<div class="z-formrow z-hide">
    {gt text='Filter (expert option)' domain='module_simpledownload' assign='filterLabel'}
    {formlabel for='simpledownloadFilter' text=$filterLabel}
        {formtextinput id='simpledownloadFilter' dataField='filter' group='data' mandatory=false maxLength=255}
        <span class="z-sub z-formnote">
            ({gt text='Syntax examples'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)
        </span>
</div>

{pageaddvar name='javascript' value='prototype'}
<script type="text/javascript">
/* <![CDATA[ */
    function simdownToggleCustomTemplate() {
        if ($F('simpledownloadTemplate') == 'custom') {
            $('customTemplateArea').removeClassName('z-hide');
        } else {
            $('customTemplateArea').addClassName('z-hide');
        }
    }

    document.observe('dom:loaded', function() {
        simdownToggleCustomTemplate();
        $('simpledownloadTemplate').observe('change', function(e) {
            simdownToggleCustomTemplate();
        });
    });
/* ]]> */
</script>
