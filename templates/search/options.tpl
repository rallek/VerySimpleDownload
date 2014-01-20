{* Purpose of this template: Display search options *}
<input type="hidden" id="verySimpleDownloadActive" name="active[VerySimpleDownload]" value="1" checked="checked" />
<div>
    <input type="checkbox" id="verySimpleDownloadDownloads" name="verySimpleDownloadSearchTypes[]" value="download"{if $active_download} checked="checked"{/if} />
    <label for="active_verySimpleDownloadDownloads">{gt text='Downloads' domain='module_verysimpledownload'}</label>
</div>
