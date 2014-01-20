{* purpose of this template: downloads display view in user area *}
{include file='user/header.tpl'}
<div class="verysimpledownload-download verysimpledownload-display">
    {gt text='Download' assign='templateTitle'}
    {assign var='templateTitle' value=$download->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'verysimpledownload.filter_hooks.downloads.filter'} {icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

    <dl>
        <dt>{gt text='State'}</dt>
        <dd>{$download.workflowState|verysimpledownloadGetListEntry:'download':'workflowState'|safetext}</dd>
        <dt>{gt text='Download title'}</dt>
        <dd>{$download.downloadTitle}</dd>
        <dt>{gt text='Download description'}</dt>
        <dd>{$download.downloadDescription}</dd>
        <dt>{gt text='File upload'}</dt>
        <dd>  <a href="{$download.fileUploadFullPathURL}" title="{$download->getTitleFromDisplayPattern()|replace:"\"":""}"{if $download.fileUploadMeta.isImage} rel="imageviewer[download]"{/if}>
          {if $download.fileUploadMeta.isImage}
              {thumb image=$download.fileUploadFullPath objectid="download-`$download.id`" preset=$downloadThumbPresetFileUpload tag=true img_alt=$download->getTitleFromDisplayPattern()}
          {else}
              {$download.fileUpload} ({$download.fileUploadMeta.size|verysimpledownloadGetFileSize:$download.fileUploadFullPath:false:false})
          {/if}
          </a>
        </dd>
        
    </dl>
    {include file='user/include_categories_display.tpl' obj=$download}
    {include file='user/include_standardfields_display.tpl' obj=$download}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='verysimpledownload.ui_hooks.downloads.display_view' id=$download.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($download._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$download._actions}
                <a href="{$option.url.type|verysimpledownloadActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    vesidoInitItemActions('download', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
    {/if}
</div>
{include file='user/footer.tpl'}
