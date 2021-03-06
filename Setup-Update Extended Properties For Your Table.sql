/*
Data Warehouse Services
AnalyticsSBX Database
Extended Properties Update Script

Instructions:
Please set the following variables: @SchemaName, @TableName, & @ExpireDate
For the @ExpireDate, you have a couple coding styles to customize per your needs
	Example 1: CONVERT(VARCHAR(10), GETDATE()+30, 112) 
				Will populate an expiration date 30 days out from today
	Example 2: 20181031
				Will populate an expiration date based on YYYYMMDD value
Execute Script
*/
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

USE [AnalyticsSBX];
GO

DECLARE @SchemaName AS VARCHAR(MAX)
DECLARE @TableName  AS VARCHAR(MAX)
DECLARE @ExpireDate AS VARCHAR(MAX)

SET @SchemaName = 'dbo'
SET @TableName = 'CMS_NDC_Crosswalk'
SET @ExpireDate = CONVERT(VARCHAR(10), GETDATE()+90, 112)  

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

DECLARE @ErrorMessage AS VARCHAR(MAX)
DECLARE @CreatedBy  AS VARCHAR(MAX)
DECLARE @CreateDate AS VARCHAR(MAX)
DECLARE @DynamicSQL AS VARCHAR(MAX)

----- Default Parameters -----
IF ISDATE(@ExpireDate) = 0 
	BEGIN
		SET @ErrorMessage = 'Script Failed: Invalid Expiration Date' + CHAR(13) + @ExpireDate 
		GOTO CompleteScript
	END 
SET @CreateDate = CONVERT(VARCHAR(10), GETDATE(), 112)						-- Defaulted to Today\
SET @CreatedBy = UPPER((SELECT REPLACE(SUSER_SNAME(), 'CTCA\', '')))		-- Defaulted To User Executing The Script
----- Default Parameters -----

-- Does the table even exist?
IF OBJECT_ID('[AnalyticsSBX].[' + @SchemaName + '].[' + @TableName + ']') IS NULL 
	BEGIN
	PRINT '[' + @SchemaName + '].[' + @TableName + '] - This table does not exist and/or you do not have permissions to view this object.'
	GOTO CompleteScript
	END 


-- Insert/Update CreatedBy Extended Property
SET @DynamicSQL = '
					EXEC sys.sp_addextendedproperty 
					@name = ''CreatedBy'', 
					@value = ''' + @CreatedBy + ''', 
					@level0type = ''SCHEMA'', @level0name = ''' + @SchemaName + ''', 
					@level1type = ''TABLE'',  @level1name = ''' + @TableName + ''';
				  '
BEGIN TRY 
	EXEC(@DynamicSQL)
	PRINT '[' + @SchemaName + '].[' + @TableName + '] - CreatedBy		- Extended Property added as: ' + @CreatedBy 
END TRY
        
BEGIN CATCH
	PRINT '[' + @SchemaName + '].[' + @TableName + '] - CreatedBy		- Extended Property already exists for this table.'
	SET @DynamicSQL = (SELECT CAST(ex.Value AS VARCHAR(MAX))
								From sys.objects so
								LEFT OUTER JOIN sys.extended_properties ex 
								ON so.Object_ID = ex.Major_ID

								LEFT OUTER JOIN sys.schemas s
								ON s.schema_id = so.schema_id

								WHERE so.Type_Desc = 'user_table'
								AND ex.Name = 'CreatedBy'
								AND s.Name = @SchemaName
								AND so.Name = @TableName
								)
	PRINT '	Original Value	: ' + @DynamicSQL 
	PRINT '	New Value		: ' + @CreatedBy

	SET @DynamicSQL = '
					EXEC sys.sp_updateextendedproperty 
					@name = ''CreatedBy'', 
					@value = ''' + @CreatedBy + ''', 
					@level0type = ''SCHEMA'', @level0name = ''' + @SchemaName + ''', 
					@level1type = ''TABLE'',  @level1name = ''' + @TableName + ''';
				  '
	EXEC(@DynamicSQL)
END CATCH 


-- Insert CreatedDate Extended Property
SET @DynamicSQL = '
					EXEC sys.sp_addextendedproperty 
					@name = ''CreatedDate'', 
					@value = ''' + ''', 
					@level0type = ''SCHEMA'', @level0name = ''' + @SchemaName + ''', 
					@level1type = ''TABLE'',  @level1name = ''' + @TableName + ''';
				  '
BEGIN TRY 
	EXEC(@DynamicSQL)
	PRINT '[' + @SchemaName + '].[' + @TableName + '] - CreatedDate	- Extended Property added as: ' + @CreateDate 
END TRY
        
BEGIN CATCH
	PRINT '[' + @SchemaName + '].[' + @TableName + '] - CreatedDate	- Extended Property already exists for this table.'
	SET @DynamicSQL = (SELECT CAST(ex.Value AS VARCHAR(MAX))
								From sys.objects so
								LEFT OUTER JOIN sys.extended_properties ex 
								ON so.Object_ID = ex.Major_ID

								LEFT OUTER JOIN sys.schemas s
								ON s.schema_id = so.schema_id

								WHERE so.Type_Desc = 'user_table'
								AND ex.Name = 'CreatedDate'
								AND s.Name = @SchemaName
								AND so.Name = @TableName
								)
	PRINT '	Original Value	: ' + @DynamicSQL 

	IF ISNUMERIC(@DynamicSQL) = 0
		BEGIN
        SET @DynamicSQL = '
					EXEC sys.sp_updateextendedproperty 
					@name = ''CreatedDate'', 
					@value = ''' + @CreateDate + ''', 
					@level0type = ''SCHEMA'', @level0name = ''' + @SchemaName + ''', 
					@level1type = ''TABLE'',  @level1name = ''' + @TableName + ''';
				  '
		EXEC(@DynamicSQL)
		PRINT '	New Value		: ' + @CreateDate
		END 

END CATCH 


-- Insert/Update ExpireDate Extended Property
SET @DynamicSQL = '
					EXEC sys.sp_addextendedproperty 
					@name = ''ExpireDate'', 
					@value = ''' + @ExpireDate + ''', 
					@level0type = ''SCHEMA'', @level0name = ''' + @SchemaName + ''', 
					@level1type = ''TABLE'',  @level1name = ''' + @TableName + ''';
				  '
BEGIN TRY 
	EXEC(@DynamicSQL)
	PRINT '[' + @SchemaName + '].[' + @TableName + '] - ExpireDate		- Extended Property added as: ' + @ExpireDate 
END TRY
        
BEGIN CATCH
	PRINT '[' + @SchemaName + '].[' + @TableName + '] - ExpireDate		- Extended Property already exists for this table.'
	SET @DynamicSQL = (SELECT CAST(ex.Value AS VARCHAR(MAX))
								From sys.objects so
								LEFT OUTER JOIN sys.extended_properties ex 
								ON so.Object_ID = ex.Major_ID

								LEFT OUTER JOIN sys.schemas s
								ON s.schema_id = so.schema_id

								WHERE so.Type_Desc = 'user_table'
								AND ex.Name = 'ExpireDate'
								AND s.Name = @SchemaName
								AND so.Name = @TableName
								)
	PRINT '	Original Value	: ' + @DynamicSQL
	PRINT '	New Value		: ' + @ExpireDate

	SET @DynamicSQL = '
					EXEC sys.sp_updateextendedproperty 
					@name = ''ExpireDate'', 
					@value = ''' + @ExpireDate + ''', 
					@level0type = ''SCHEMA'', @level0name = ''' + @SchemaName + ''', 
					@level1type = ''TABLE'',  @level1name = ''' + @TableName + ''';
				  '
	EXEC(@DynamicSQL)
END CATCH 

CompleteScript:	

PRINT @ErrorMessage
GO