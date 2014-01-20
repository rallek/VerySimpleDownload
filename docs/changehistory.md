Meine Änderungen
=====

\modules\VerySimpleDownload\lib\VerySimpleDownload\UploadHandler.php
	File Extensions und File Size gesetzt
	
\modules\VerySimpleDownload\templates\user\download\edit.tpl
	Dateigröße und Extensions durch ModVar ersetzt
	{$modvars.VerySimpleDownload.myFileExtensions}
	$modvars.VerySimpleDownload.myFileSize
	
admin und user\view.tpl und display.tpl	
	{$download.fileUpload} anstatt {gt text='Download'}
	Aufruf von view_quickNav einschränken:
	{include file='user/download/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false sorting=false pageSizeSelector=false searchFilter=false}{* see template file for available options *}
	<p class="z-informationmsg">your download files</p> entfernen
	Nur user\display.tpl: 
		Den Status entfernen
	nur user\view.tpl:
		</br>{$download.downloadDescription|truncate:50} in erste Spalte einbauen

	
view_display.tpl
	level='ACCESS_READ anstatt level='ACCESS_EDIT
	{assign var='categorySelectorSize' value='1'} Value von 5 auf 1 wenn Multiselection ausgeschaltet werden soll
	
admin.png und editor.png auswechseln

Editor Plugins den Pfad zur editor.png anpassen
