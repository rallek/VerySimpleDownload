{* purpose of this template: downloads rss feed in user area *}
{simpledownloadTemplateHeaders contentType='application/rss+xml'}<?xml version="1.0" encoding="{charset assign='charset'}{if $charset eq 'ISO-8859-15'}ISO-8859-1{else}{$charset}{/if}" ?>
<rss version="2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
    xmlns:admin="http://webns.net/mvcb/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:content="http://purl.org/rss/1.0/modules/content/"
    xmlns:atom="http://www.w3.org/2005/Atom">
{*<rss version="0.92">*}
{gt text='Latest downloads' assign='channelTitle'}
{gt text='A direct feed showing the list of downloads' assign='channelDesc'}
    <channel>
        <title>{$channelTitle}</title>
        <link>{$baseurl|escape:'html'}</link>
        <atom:link href="{php}echo substr(\System::getBaseURL(), 0, strlen(\System::getBaseURL())-1);{/php}{getcurrenturi}" rel="self" type="application/rss+xml" />
        <description>{$channelDesc} - {$modvars.ZConfig.slogan}</description>
        <language>{lang}</language>
        {* commented out as $imagepath is not defined and we can't know whether this logo exists or not
        <image>
            <title>{$modvars.ZConfig.sitename}</title>
            <url>{$baseurl|escape:'html'}{$imagepath}/logo.jpg</url>
            <link>{$baseurl|escape:'html'}</link>
        </image>
        *}
        <docs>http://blogs.law.harvard.edu/tech/rss</docs>
        <copyright>Copyright (c) {php}echo date('Y');{/php}, {$baseurl}</copyright>
        <webMaster>{$modvars.ZConfig.adminmail|escape:'html'} ({usergetvar name='uname' uid=2})</webMaster>

{foreach item='download' from=$items}
    <item>
        <title><![CDATA[{if isset($download.updatedDate) && $download.updatedDate ne null}{$download.updatedDate|dateformat} - {/if}{$download->getTitleFromDisplayPattern()|notifyfilters:'simpledownload.filterhook.downloads'}]]></title>
        <link>{modurl modname='Simpledownload' type='user' func='display' ot='download' id=$download.id fqurl='1'}</link>
        <guid>{modurl modname='Simpledownload' type='user' func='display' ot='download' id=$download.id fqurl='1'}</guid>
        {if isset($download.createdUserId)}
            {usergetvar name='uname' uid=$download.createdUserId assign='cr_uname'}
            {usergetvar name='name' uid=$download.createdUserId assign='cr_name'}
            <author>{usergetvar name='email' uid=$download.createdUserId} ({$cr_name|default:$cr_uname})</author>
        {/if}

        <category><![CDATA[{gt text='Categories'}: {foreach name='categoryLoop' key='propName' item='catMapping' from=$download.categories}{$catMapping.category.name|safetext}{if !$smarty.foreach.categoryLoop.last}, {/if}{/foreach}]]></category>

        <description>
            <![CDATA[
            {$download.docdescription|replace:'<br>':'<br />'}
            ]]>
        </description>
        {if isset($download.createdDate) && $download.createdDate ne null}
            <pubDate>{$download.createdDate|dateformat:"%a, %d %b %Y %T +0100"}</pubDate>
        {/if}
    </item>
{/foreach}
    </channel>
</rss>
