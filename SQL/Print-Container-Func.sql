/****** Object:  UserDefinedFunction [dbo].[Print_Container_Func]    Script Date: 30-10-2020 09:31:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ivan Kashperuk
-- Create date: 2020-10-28
-- Description:	Display contents of an X++ container from SQL database field
-- Adapted to scalar-valued function by Marcel Domingus
-- Also see: https://kashperuk.blogspot.com/2020/10/tool-display-contents-of-x-container.html
-- Example use: SELECT TOP 3 info, [dbo].[Print_Container_Func](info) AS readable_info FROM BATCH WHERE NOT (info IS NULL)
-- =============================================
CREATE FUNCTION [dbo].[Print_Container_Func]
(
	-- Add the parameters for the function here
	@container varbinary(max)
)
RETURNS varchar(max)
AS
BEGIN
  DECLARE @pos AS int;
  SET @pos = 1;
  DECLARE @offset AS int;
  DECLARE @indent AS int;
  DECLARE @result AS varchar(max);
  SET @indent = 0;
  IF SUBSTRING(@container, @pos, 2) = 0x07FD
  BEGIN
    SET @result = '<container>' + CHAR(13);
    SET @indent = @indent + 2;
    SET @pos = @pos + 2;
    WHILE @indent > 0
    BEGIN
      IF SUBSTRING(@container, @pos, 1) = 0x00 --STRING
      BEGIN
        SET @result = @result + REPLICATE(' ', @indent) + '<string>'
        SET @pos = @pos + 1;
        SET @offset = 0;
        DECLARE @string AS varchar(max);
        SET @string = '';
        WHILE SUBSTRING(@container, @pos + @offset, 2) <> 0x0000
        BEGIN
          SET @string = @string +
          CHAR(CAST(REVERSE(SUBSTRING(@container, @pos + @offset, 2)) AS binary(2)))
          SET @offset = @offset + 2;
        END
        SET @pos = @pos + @offset + 2;
        SET @result = @result + @string + '</string>' + CHAR(13);
      END
      ELSE
      IF SUBSTRING(@container, @pos, 1) = 0x01 --INT
      BEGIN
        SET @result = @result + REPLICATE(' ', @indent) + '<int>'
        SET @pos = @pos + 1;
        DECLARE @int AS int;
        SET @int = CAST(CAST(REVERSE(SUBSTRING(@container, @pos, 4)) AS binary(4)) AS int);
        SET @pos = @pos + 4;
        SET @result = @result + CAST(@int AS varchar(max)) + '</int>' + CHAR(13);
      END
      ELSE
      IF SUBSTRING(@container, @pos, 1) = 0x02 --REAL
      BEGIN
        SET @result = @result + REPLICATE(' ', @indent) + '<real>'
        SET @pos = @pos + 1;
        DECLARE @temp AS binary(8);
        SET @temp = CAST(REVERSE(SUBSTRING(@container, @pos + 2, 8)) AS binary(8));
        DECLARE @val bigint;
        SET @val = 0;
        DECLARE @dec AS int;
        SET @offset = 1;
        WHILE (@offset <= 8)
        BEGIN
          SET @val = (@val * 100) +
          (CAST(SUBSTRING(@temp, @offset, 1) AS int) / 0x10 * 10) +
          (CAST(SUBSTRING(@temp, @offset, 1) AS int) % 0x10);
          SET @offset = @offset + 1;
        END
        WHILE @val <> 0
          AND @val % 10 = 0
          SET @val = @val / 10;
        SET @dec = (CAST(SUBSTRING(@container, @pos, 1) AS int) + 0x80) % 0x100;
        DECLARE @real AS real;
        SET @real = CAST(@val AS real);
        WHILE @dec >= LEN(CAST(@val AS varchar)) + 0x80
        BEGIN
          SET @real = CAST(@real AS real) * 10.0;
          SET @dec = @dec - 1;
        END
        SET @dec = (CAST(SUBSTRING(@container, @pos, 1) AS int) + 0x80) % 0x100 + 1;
        WHILE @dec < LEN(CAST(@val AS varchar)) + 0x80
        BEGIN
          SET @real = CAST(@real AS real) / 10.0;
          SET @dec = @dec + 1;
        END
        IF SUBSTRING(@container, @pos + 1, 1) = 0x80
          SET @real = 0 - CAST(@real AS real);
        SET @pos = @pos + 10;
        SET @result = @result + @real + '</real>' + CHAR(13);
      END
      ELSE
      IF SUBSTRING(@container, @pos, 1) = 0x03 --DATE
      BEGIN
        SET @result = @result + REPLICATE(' ', @indent) + '<date>'
        SET @pos = @pos + 1;
        DECLARE @year char(4);
        DECLARE @month char(2);
        DECLARE @day char(2);
        SET @year = SUBSTRING(@container, @pos, 1) + 1900;
        SET @month = SUBSTRING(@container, @pos + 1, 1) + 1;
        SET @day = SUBSTRING(@container, @pos + 2, 1) + 1;
        IF LEN(@month) < 2
          SET @month = '0' + @month;
        IF LEN(@day) < 2
          SET @day = '0' + @day;
        DECLARE @date AS date;
        SET @date = CAST(@year + '-' + @month + '-' + @day AS date);
        SET @pos = @pos + 3;
        SET @result = @result + CONVERT(varchar(max), @date) + '</date>' + CHAR(13);
      END
      ELSE
      IF SUBSTRING(@container, @pos, 1) = 0x04 --ENUM
      BEGIN
        SET @result = @result + REPLICATE(' ', @indent) + '<enum>'
        SET @pos = @pos + 1;
        DECLARE @enum AS int;
        SET @enum = CAST(SUBSTRING(@container, @pos, 1) AS int);
        SET @pos = @pos + 3;
        SET @result = @result + @enum + '</enum>' + CHAR(13);
      END
      ELSE
      IF SUBSTRING(@container, @pos, 1) = 0x06 --DATETIME
      BEGIN
        SET @result = @result + REPLICATE(' ', @indent) + '<datetime>'
        SET @pos = @pos + 1;
        DECLARE @year2 char(4);
        DECLARE @month2 char(2);
        DECLARE @day2 char(2);
        DECLARE @hour char(2);
        DECLARE @min char(2);
        DECLARE @sec char(2);
        SET @year2 = SUBSTRING(@container, @pos, 1) + 1900;
        SET @month2 = SUBSTRING(@container, @pos + 1, 1) + 1;
        SET @day2 = SUBSTRING(@container, @pos + 2, 1) + 1;
        SET @hour = SUBSTRING(@container, @pos + 3, 1) + 0;
        SET @min = SUBSTRING(@container, @pos + 4, 1) + 0;
        SET @sec = SUBSTRING(@container, @pos + 5, 1) + 0;
        IF LEN(@month2) < 2
          SET @month2 = '0' + @month2;
        IF LEN(@day2) < 2
          SET @day2 = '0' + @day2;
        IF LEN(@hour) < 2
          SET @hour = '0' + @hour;
        IF LEN(@min) < 2
          SET @min = '0' + @min;
        IF LEN(@sec) < 2
          SET @sec = '0' + @sec;
        DECLARE @datetime AS datetime;
        SET @datetime = CAST(@year2 + '-' + @month2 + '-' + @day2 + ' ' + @hour + ':' + @min + ':' + @sec AS datetime);
        SET @pos = @pos + 12;
        SET @result = @result + @datetime + '</datetime>' + CHAR(13);
      END
      ELSE
      IF SUBSTRING(@container, @pos, 1) = 0x07 --CONTAINER
      BEGIN
        SET @result = @result + REPLICATE(' ', @indent) + '<container>' + CHAR(13);
        SET @pos = @pos + 3;
        SET @indent = @indent + 2;
      END
      ELSE
      IF SUBSTRING(@container, @pos, 1) = 0xFF --CONTAINER END
      BEGIN
        SET @pos = @pos + 1;
        SET @indent = @indent - 2;
        SET @result = @result + REPLICATE(' ', @indent) + '</container>' + CHAR(13);
      END
      ELSE
      IF SUBSTRING(@container, @pos, 1) = 0x2D --GUID
      BEGIN
        SET @pos = @pos + 1;
        SET @offset = 0;
        DECLARE @guid AS uniqueidentifier
        SET @guid = CAST(CAST(
        REVERSE(SUBSTRING(@container, @pos, 4)) +
        REVERSE(SUBSTRING(@container, @pos + 4, 4)) +
        REVERSE(SUBSTRING(@container, @pos + 8, 4)) +
        REVERSE(SUBSTRING(@container, @pos + 12, 4)
        ) AS binary(16)) AS uniqueidentifier);
        SET @pos = @pos + 16;
        SET @result = @result + REPLICATE(' ', @indent) + '<guid>' + CAST(@guid AS varchar(80)) + '</guid>' + CHAR(13)
      END
      ELSE
      IF SUBSTRING(@container, @pos, 1) = 0x30 --BLOB
      BEGIN
        SET @pos = @pos + 1;
        SET @offset = CAST(CAST(REVERSE(SUBSTRING(@container, @pos, 4)) AS binary(4)) AS int);
        SET @pos = @pos + 4;
        DECLARE @blob AS varbinary(max);
        SET @blob = CAST(SUBSTRING(@container, @pos, @offset) AS varbinary(max));
        SET @pos = @pos + @offset;
        SET @result = @result + REPLICATE(' ', @indent) + '<blob>' + CONVERT(varchar(max), @blob, 2) + '</blob>' + CHAR(13);
      END
      ELSE
      IF SUBSTRING(@container, @pos, 1) = 0x31 --INT64
      BEGIN
        SET @pos = @pos + 1;
        DECLARE @bigint AS bigint;
        SET @bigint = CAST(CAST(REVERSE(SUBSTRING(@container, @pos, 8)) AS binary(8)) AS bigint);
        SET @pos = @pos + 8;
        SET @result = @result + REPLICATE(' ', @indent) + '<int64>' + CAST(@bigint AS varchar(max)) + '</int64>' + CHAR(13)
      END
      ELSE
      IF SUBSTRING(@container, @pos, 1) = 0xFC --ENUMLABEL
      BEGIN
        SET @pos = @pos + 1;
        DECLARE @value int;
        DECLARE @name varchar(40);
        SET @value = SUBSTRING(@container, @pos, 1);
        SET @pos = @pos + 1;
        SET @offset = 0;
        SET @name = '';
        WHILE SUBSTRING(@container, @pos + @offset, 2) <> 0x0000
        BEGIN
          SET @name = CAST(@name AS varchar(40)) +
          CHAR(CAST(REVERSE(SUBSTRING(@container, @pos + @offset, 2)) AS binary(2)))
          SET @offset = @offset + 2;
        END
        DECLARE @enumlabel AS varchar(max);
        SET @enumlabel = CAST(@name + ':' + CAST(@value AS varchar(3)) AS varchar(44));
        SET @pos = @pos + @offset + 2;
        SET @result = @result + REPLICATE(' ', @indent) + '<enumlabel>' + @enumlabel + '</enumlabel>' + CHAR(13)
      END
      ELSE
      BEGIN
        DECLARE @errormsg varchar(max);
        SET @errormsg = 'Unexpected type ' + CONVERT(varchar(1000), SUBSTRING(@container, @pos, 1), 2);
        -- THROW 50000, @errormsg, 1;
		SET @result = NULL
      END
    END
  END
  RETURN @result
END

GO
