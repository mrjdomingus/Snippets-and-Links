-- First download and install from https://ola.hallengren.com/sql-server-index-and-statistics-maintenance.html
EXECUTE dbo.IndexOptimize @Databases = 'AxDB,DYNAMICSXREFDB',
@FragmentationLow = NULL,
@FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationLevel1 = 5,
@FragmentationLevel2 = 30,
@UpdateStatistics = 'ALL',
@OnlyModifiedStatistics = 'Y',
@LogToTable='Y'
