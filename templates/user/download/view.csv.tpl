{* purpose of this template: downloads view csv view in user area *}
{verysimpledownloadTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true filename='Downloads.csv'}
{strip}"{gt text='Download title'}";"{gt text='Download description'}";"{gt text='File upload'}";"{gt text='Workflow state'}"
{/strip}
{foreach item='download' from=$items}
{strip}
    "{$download.downloadTitle}";"{$download.downloadDescription}";"{$download.fileUpload}";"{$item.workflowState|verysimpledownloadObjectState:false|lower}"
{/strip}
{/foreach}
