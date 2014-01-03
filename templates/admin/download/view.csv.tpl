{* purpose of this template: downloads view csv view in admin area *}
{simpledownloadTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true filename='Downloads.csv'}
{strip}"{gt text='Doctitel'}";"{gt text='Docdescription'}";"{gt text='Uploaddocument'}";"{gt text='Workflow state'}"
{/strip}
{foreach item='download' from=$items}
{strip}
    "{$download.doctitel}";"{$download.docdescription}";"{$download.uploaddocument}";"{$item.workflowState|simpledownloadObjectState:false|lower}"
{/strip}
{/foreach}
