{* Purpose of this template: Display search options *}
<input type="hidden" id="simpledownloadActive" name="active[Simpledownload]" value="1" checked="checked" />
<div>
    <input type="checkbox" id="simpledownloadDownloads" name="simpledownloadSearchTypes[]" value="download"{if $active_download} checked="checked"{/if} />
    <label for="active_simpledownloadDownloads">{gt text='Downloads' domain='module_simpledownload'}</label>
</div>
