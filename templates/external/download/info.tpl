{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="download{$download.id}">
<dt>{$download->getTitleFromDisplayPattern()|notifyfilters:'simpledownload.filter_hooks.downloads.filter'|htmlentities}</dt>
{if $download.docdescription ne ''}<dd>{$download.docdescription}</dd>{/if}
<dd>{assignedcategorieslist categories=$download.categories doctrine2=true}</dd>
</dl>
