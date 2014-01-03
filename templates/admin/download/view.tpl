{* purpose of this template: downloads view view in admin area *}
{include file='admin/header.tpl'}
<div class="simpledownload-download simpledownload-view">
    {gt text='Download list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='view' size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>

    {if $canBeCreated}
        {checkpermissionblock component='Simpledownload:Download:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create download' assign='createTitle'}
            <a href="{modurl modname='Simpledownload' type='admin' func='edit' ot='download'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='Simpledownload' type='admin' func='view' ot='download'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='Simpledownload' type='admin' func='view' ot='download' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='admin/download/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <form action="{modurl modname='Simpledownload' type='admin' func='handleSelectedEntries'}" method="post" id="downloadsViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
            <input type="hidden" name="ot" value="download" />
            <table class="z-datatable">
                <colgroup>
                    <col id="cSelect" />
                    <col id="cDoctitel" />
                    <col id="cDocdescription" />
                    <col id="cUploaddocument" />
                    <col id="cItemActions" />
                </colgroup>
                <thead>
                <tr>
                    {assign var='catIdListMainString' value=','|implode:$catIdList.Main}
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleDownloads" />
                    </th>
                    <th id="hDoctitel" scope="col" class="z-left">
                        {sortlink __linktext='Doctitel' currentsort=$sort modname='Simpledownload' type='admin' func='view' ot='download' sort='doctitel' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hDocdescription" scope="col" class="z-left">
                        {sortlink __linktext='Docdescription' currentsort=$sort modname='Simpledownload' type='admin' func='view' ot='download' sort='docdescription' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hUploaddocument" scope="col" class="z-left">
                        {sortlink __linktext='Uploaddocument' currentsort=$sort modname='Simpledownload' type='admin' func='view' ot='download' sort='uploaddocument' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
                </tr>
                </thead>
                <tbody>
            
            {foreach item='download' from=$items}
                <tr class="{cycle values='z-odd, z-even'}">
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$download.id}" class="downloads-checkbox" />
                    </td>
                    <td headers="hDoctitel" class="z-left">
                        <a href="{modurl modname='Simpledownload' type='admin' func='display' ot='download' id=$download.id}" title="{gt text='View detail page'}">{$download.doctitel|notifyfilters:'simpledownload.filterhook.downloads'}</a>
                    </td>
                    <td headers="hDocdescription" class="z-left">
                        {$download.docdescription}
                    </td>
                    <td headers="hUploaddocument" class="z-left">
                          <a href="{$download.uploaddocumentFullPathURL}" title="{$download->getTitleFromDisplayPattern()|replace:"\"":""}"{if $download.uploaddocumentMeta.isImage} rel="imageviewer[download]"{/if}>
                          {if $download.uploaddocumentMeta.isImage}
                              {thumb image=$download.uploaddocumentFullPath objectid="download-`$download.id`" preset=$downloadThumbPresetUploaddocument tag=true img_alt=$download->getTitleFromDisplayPattern()}
                          {else}
                              {gt text='Download'} ({$download.uploaddocumentMeta.size|simpledownloadGetFileSize:$download.uploaddocumentFullPath:false:false})
                          {/if}
                          </a>
                    </td>
                    <td id="itemActions{$download.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                        {if count($download._actions) gt 0}
                            {foreach item='option' from=$download._actions}
                                <a href="{$option.url.type|simpledownloadActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                            {/foreach}
                            {icon id="itemActions`$download.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                            <script type="text/javascript">
                            /* <![CDATA[ */
                                document.observe('dom:loaded', function() {
                                    simdownInitItemActions('download', 'view', 'itemActions{{$download.id}}');
                                });
                            /* ]]> */
                            </script>
                        {/if}
                    </td>
                </tr>
            {foreachelse}
                <tr class="z-admintableempty">
                  <td class="z-left" colspan="5">
                {gt text='No downloads found.'}
                  </td>
                </tr>
            {/foreach}
            
                </tbody>
            </table>
            
            {if !isset($showAllEntries) || $showAllEntries ne 1}
                {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='Simpledownload' type='admin' func='view' ot='download'}
            {/if}
            <fieldset>
                <label for="simpledownloadAction">{gt text='With selected downloads'}</label>
                <select id="simpledownloadAction" name="action">
                    <option value="">{gt text='Choose action'}</option>
                    <option value="delete" title="{gt text='Delete content permanently.'}">{gt text='Delete'}</option>
                </select>
                <input type="submit" value="{gt text='Submit'}" />
            </fieldset>
        </div>
    </form>

</div>
{include file='admin/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{* init the "toggle all" functionality *}}
    if ($('toggleDownloads') != undefined) {
        $('toggleDownloads').observe('click', function (e) {
            Zikula.toggleInput('downloadsViewForm');
            e.stop()
        });
    }
    });
/* ]]> */
</script>
