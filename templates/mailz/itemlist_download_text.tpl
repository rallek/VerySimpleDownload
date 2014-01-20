{* Purpose of this template: Display downloads in text mailings *}
{foreach item='download' from=$items}
{$download->getTitleFromDisplayPattern()}
{modurl modname='VerySimpleDownload' type='user' func='display' ot=$objectType id=$download.id fqurl=true}
-----
{foreachelse}
{gt text='No downloads found.'}
{/foreach}
