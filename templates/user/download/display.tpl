{* purpose of this template: downloads display view in user area *}
{include file='user/header.tpl'}
<div class="simpledownload-download simpledownload-display">
    {gt text='Download' assign='templateTitle'}
    {assign var='templateTitle' value=$download->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'simpledownload.filter_hooks.downloads.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

    <dl>
        <dt>{gt text='Doctitel'}</dt>
        <dd>{$download.doctitel}</dd>
        <dt>{gt text='Docdescription'}</dt>
        <dd>{$download.docdescription}</dd>
        <dt>{gt text='Uploaddocument'}</dt>
        <dd>  <a href="{$download.uploaddocumentFullPathURL}" title="{$download->getTitleFromDisplayPattern()|replace:"\"":""}"{if $download.uploaddocumentMeta.isImage} rel="imageviewer[download]"{/if}>
          {if $download.uploaddocumentMeta.isImage}
              {thumb image=$download.uploaddocumentFullPath objectid="download-`$download.id`" preset=$downloadThumbPresetUploaddocument tag=true img_alt=$download->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$download.uploaddocumentMeta.size|simpledownloadGetFileSize:$download.uploaddocumentFullPath:false:false})
          {/if}
          </a>
        </dd>
        
    </dl>
    {include file='user/include_categories_display.tpl' obj=$download}
    {include file='user/include_standardfields_display.tpl' obj=$download}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='simpledownload.ui_hooks.downloads.display_view' id=$download.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($download._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$download._actions}
                <a href="{$option.url.type|simpledownloadActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    simdownInitItemActions('download', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
    {/if}
</div>
{include file='user/footer.tpl'}
