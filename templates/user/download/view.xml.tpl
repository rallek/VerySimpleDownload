{* purpose of this template: downloads view xml view in user area *}
{verysimpledownloadTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<downloads>
{foreach item='item' from=$items}
    {include file='user/download/include.xml'}
{foreachelse}
    <noDownload />
{/foreach}
</downloads>
