{* Purpose of this template: Display one certain download within an external context *}
<div id="download{$download.id}" class="verysimpledownload-external-download">
{if $displayMode eq 'link'}
    <p class="verysimpledownload-external-link">
    <a href="{modurl modname='VerySimpleDownload' type='user' func='display' ot='download' id=$download.id}" title="{$download->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$download->getTitleFromDisplayPattern()|notifyfilters:'verysimpledownload.filter_hooks.downloads.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='VerySimpleDownload::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="verysimpledownload-external-title">
            <strong>{$download->getTitleFromDisplayPattern()|notifyfilters:'verysimpledownload.filter_hooks.downloads.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="verysimpledownload-external-snippet">
        &nbsp;
    </div>

    {* you can distinguish the context like this: *}
    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}

    {* you can enable more details about the item: *}
    {*
        <p class="verysimpledownload-external-description">
            {if $download.downloadDescription ne ''}{$download.downloadDescription}<br />{/if}
            {assignedcategorieslist categories=$download.categories doctrine2=true}
        </p>
    *}
{/if}
</div>
