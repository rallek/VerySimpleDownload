{* purpose of this template: downloads xml inclusion template in admin area *}
<download id="{$item.id}" createdon="{$item.createdDate|dateformat}" updatedon="{$item.updatedDate|dateformat}">
    <id>{$item.id}</id>
    <downloadTitle><![CDATA[{$item.downloadTitle}]]></downloadTitle>
    <downloadDescription><![CDATA[{$item.downloadDescription}]]></downloadDescription>
    <fileUpload{if $item.fileUpload ne ''} extension="{$item.fileUploadMeta.extension}" size="{$item.fileUploadMeta.size}" isImage="{if $item.fileUploadMeta.isImage}true{else}false{/if}"{if $item.fileUploadMeta.isImage} width="{$item.fileUploadMeta.width}" height="{$item.fileUploadMeta.height}" format="{$item.fileUploadMeta.format}"{/if}{/if}>{$item.fileUpload}</fileUpload>
    <workflowState>{$item.workflowState|verysimpledownloadObjectState:false|lower}</workflowState>
</download>
