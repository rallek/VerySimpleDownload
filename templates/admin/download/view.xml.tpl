{* purpose of this template: downloads view xml view in admin area *}
{verysimpledownloadTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<downloads>
{foreach item='item' from=$items}
    {include file='admin/download/include.xml'}
{foreachelse}
    <noDownload />
{/foreach}
</downloads>
