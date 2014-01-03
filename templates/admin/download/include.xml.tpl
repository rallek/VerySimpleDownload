{* purpose of this template: downloads xml inclusion template in admin area *}
<download id="{$item.id}" createdon="{$item.createdDate|dateformat}" updatedon="{$item.updatedDate|dateformat}">
    <id>{$item.id}</id>
    <doctitel><![CDATA[{$item.doctitel}]]></doctitel>
    <docdescription><![CDATA[{$item.docdescription}]]></docdescription>
    <uploaddocument{if $item.uploaddocument ne ''} extension="{$item.uploaddocumentMeta.extension}" size="{$item.uploaddocumentMeta.size}" isImage="{if $item.uploaddocumentMeta.isImage}true{else}false{/if}"{if $item.uploaddocumentMeta.isImage} width="{$item.uploaddocumentMeta.width}" height="{$item.uploaddocumentMeta.height}" format="{$item.uploaddocumentMeta.format}"{/if}{/if}>{$item.uploaddocument}</uploaddocument>
    <workflowState>{$item.workflowState|simpledownloadObjectState:false|lower}</workflowState>
</download>
