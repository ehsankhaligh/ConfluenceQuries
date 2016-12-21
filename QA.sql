--Confluence QA 
use [Confluence]
go 

select QA.PLUGINDATAID, QA.PLUGINKEY, QA.FILENAME 
from dbo.PLUGINDATA as QA

order by QA.FILENAME