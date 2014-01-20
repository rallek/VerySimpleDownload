{* Purpose of this template: Display downloads in html mailings *}
{*
<ul>
{foreach item='download' from=$items}
    <li>
        <a href="{modurl modname='VerySimpleDownload' type='user' func='display' ot=$objectType id=$download.id fqurl=true}">{$download->getTitleFromDisplayPattern()}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No downloads found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_download_display_description.tpl'}
