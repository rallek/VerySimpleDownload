{* Purpose of this template: Display downloads within an external context *}
{foreach item='download' from=$items}
    <h3>{$download->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='Simpledownload' type='user' func='display' ot=$objectType id=$download.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
