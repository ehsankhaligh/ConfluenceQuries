with CTEconfluenceDEV as (
            select DEV.FILENAME, DEV.PLUGINKEY  
            from [COSP-DV-SQLD01\DEV].[Confluence_DTECH].[dbo].[PLUGINDATA] AS DEV-- DEV Confluuence
			where DEV.PLUGINDATAID != 1966081 
			AND DEV.PLUGINDATAID != 1966082 
), 
    CTEconfluenceQA as (

            select QA.FILENAME, QA.PLUGINKEY 
            from [COSP-DV-SHSQQ02\I2_SQL12QA].[Confluence].[dbo].[PLUGINDATA] AS QA-- QA Confluence --runs slow 
			where QA.PLUGINDATAID != 43941890
			AND QA.PLUGINDATAID != 43941891
),
    CTEconfluencePRO as (
            select PRO.FILENAME, PRO.PLUGINKEY 
            from dbo.PLUGINDATA AS PRO-- PROD Confluence 
			where PRO.PLUGINDATAID != 50069507
			AND PRO.PLUGINDATAID != 50069508
)

select ISNULL(CONVERT(varchar(50),PRO.FILENAME) ,'  ***NOT INSTALLED***') 'Production Confluence pluginName & Version', 
       ISNULL(CONVERT(varchar(50),QA.FILENAME) ,'  ***NOT INSTALLED***') 'QA Confluence pluginName & Version', 
	   ISNULL(CONVERT(varchar(50),DEV.FILENAME) ,'  ***NOT INSTALLED***') 'DEV Confluence pluginName & Version' 
    from CTEconfluencePRO as PRO
full join CTEconfluenceQA as QA 
    on PRO.PLUGINKEY = QA.PLUGINKEY
full join CTEconfluenceDEV as DEV
    on PRO.PLUGINKEY = DEV.PLUGINKEY OR QA.PLUGINKEY = DEV.PLUGINKEY
order by ISNULL(CONVERT(varchar(50),PRO.FILENAME) ,'  ***NOT INSTALLED***')

	