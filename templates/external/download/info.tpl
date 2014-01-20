{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="download{$download.id}">
<dt>{$download->getTitleFromDisplayPattern()|notifyfilters:'verysimpledownload.filter_hooks.downloads.filter'|htmlentities}</dt>
{if $download.downloadDescription ne ''}<dd>{$download.downloadDescription}</dd>{/if}
<dd>{assignedcategorieslist categories=$download.categories doctrine2=true}</dd>
</dl>
