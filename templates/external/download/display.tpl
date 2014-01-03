{* Purpose of this template: Display one certain download within an external context *}
<div id="download{$download.id}" class="simpledownload-external-download">
{if $displayMode eq 'link'}
    <p class="simpledownload-external-link">
    <a href="{modurl modname='Simpledownload' type='user' func='display' ot='download' id=$download.id}" title="{$download->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$download->getTitleFromDisplayPattern()|notifyfilters:'simpledownload.filter_hooks.downloads.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='Simpledownload::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="simpledownload-external-title">
            <strong>{$download->getTitleFromDisplayPattern()|notifyfilters:'simpledownload.filter_hooks.downloads.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="simpledownload-external-snippet">
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
        <p class="simpledownload-external-description">
            {if $download.docdescription ne ''}{$download.docdescription}<br />{/if}
            {assignedcategorieslist categories=$download.categories doctrine2=true}
        </p>
    *}
{/if}
</div>
