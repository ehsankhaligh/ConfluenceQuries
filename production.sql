--Production 

use [Confluence]
go

select FILENAME, PLUGINKEY from dbo.PLUGINDATA
order by FILENAME;