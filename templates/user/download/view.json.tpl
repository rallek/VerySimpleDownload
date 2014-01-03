{* purpose of this template: downloads view json view in user area *}
{simpledownloadTemplateHeaders contentType='application/json'}
[
{foreach item='item' from=$items name='downloads'}
    {if not $smarty.foreach.downloads.first},{/if}
    {$item->toJson()}
{/foreach}
]
