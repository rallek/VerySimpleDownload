{* purpose of this template: downloads view view in user area *}
{include file='user/header.tpl'}
<div class="verysimpledownload-download verysimpledownload-view">
    {gt text='Download list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    

    {if $canBeCreated}
        {checkpermissionblock component='VerySimpleDownload:Download:' instance='::' level='ACCESS_COMMENT'}
            {gt text='Create download' assign='createTitle'}
            <a href="{modurl modname='VerySimpleDownload' type='user' func='edit' ot='download'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='VerySimpleDownload' type='user' func='view' ot='download'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='VerySimpleDownload' type='user' func='view' ot='download' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='user/download/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false sorting=false pageSizeSelector=false}{* see template file for available options *}

    <table class="z-datatable">
        <colgroup>
            <col id="cDownloadTitle" />
        </colgroup>
        <thead>
        <tr>
            {assign var='catIdListMainString' value=','|implode:$catIdList.Main}
            <th id="hDownloadTitle" scope="col" class="z-left">
                {sortlink __linktext='Download title' currentsort=$sort modname='VerySimpleDownload' type='user' func='view' ot='download' sort='downloadTitle' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>

        </tr>
        </thead>
        <tbody>
    
    {foreach item='download' from=$items}
        <tr class="{cycle values='z-odd, z-even'}">
            <td headers="hDownloadTitle" class="z-left">
                <a class="z-bold" href="{modurl modname='VerySimpleDownload' type='user' func='display' ot='download' id=$download.id}" title="{gt text='View detail page'}">{$download.downloadTitle|notifyfilters:'verysimpledownload.filterhook.downloads'}</a></br>
				<span class="z-sub">{$download.downloadDescription|truncate:50}</span></br>

            
                  <a href="{$download.fileUploadFullPathURL}" title="{$download->getTitleFromDisplayPattern()|replace:"\"":""}"{if $download.fileUploadMeta.isImage} rel="imageviewer[download]"{/if}>
                  {if $download.fileUploadMeta.isImage}
                      {thumb image=$download.fileUploadFullPath objectid="download-`$download.id`" preset=$downloadThumbPresetFileUpload tag=true img_alt=$download->getTitleFromDisplayPattern()}
                  {else}
                      {$download.fileUpload} ({$download.fileUploadMeta.size|verysimpledownloadGetFileSize:$download.fileUploadFullPath:false:false})
                  {/if}
                  </a>
            

        </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="5">
        {gt text='No downloads found.'}
          </td>
        </tr>
    {/foreach}
    
        </tbody>
    </table>
    
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='VerySimpleDownload' type='user' func='view' ot='download'}
    {/if}

    
    {notifydisplayhooks eventname='verysimpledownload.ui_hooks.downloads.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
{include file='user/footer.tpl'}
