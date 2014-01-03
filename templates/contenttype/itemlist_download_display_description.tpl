{* Purpose of this template: Display downloads within an external context *}
<dl>
    {foreach item='download' from=$items}
        <dt>{$download->getTitleFromDisplayPattern()}</dt>
        {if $download.docdescription}
            <dd>{$download.docdescription|truncate:200:"..."}</dd>
        {/if}
        <dd><a href="{modurl modname='Simpledownload' type='user' func='display' ot=$objectType id=$download.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
