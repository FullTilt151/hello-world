USE [CM_WP1]
GO
/****** Object:  StoredProcedure [dbo].[spGetDPsForUpgrade]    Script Date: 2/2/2019 1:20:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 
-- Name         : spGetDPsForUpgrade 
-- Version      : 5.0.8412.1006 
-- Definition   : SqlObjs 
-- Scope        : CAS_OR_PRIMARY_OR_SECONDARY 
-- Object       : P 
-- Dependencies : <Detect> 
-- Description  : Gets a list of DPIDs and priorities for DPs that need to be upgraded 
-- 
ALTER PROCEDURE [dbo].[spGetDPsForUpgrade] 
  @TargetVersion NVARCHAR(32) 
AS 
BEGIN 
  SET NOCOUNT ON; 
 
  DECLARE @TargetVersionInt BIGINT = dbo.fn_StringToVersion(@TargetVersion); 
 
  WITH dps AS 
  ( 
    SELECT 
      dp.Priority, 
      dp.DPID, 
      CASE 
        WHEN 
          ISNULL(dp.State, 0) <> 1 OR 
          NOT EXISTS 
          ( 
            SELECT TOP 1 * 
            FROM SC_SysResUse_Property scp 
            INNER JOIN SC_SysResUse sc ON sc.ID = scp.SysResUseID 
            WHERE sc.NALPath = dp.NALPath AND Name = N'Version' AND dbo.fn_StringToVersion(ISNULL(Value1, N'0.0.0.0')) >= @TargetVersionInt 
          ) 
        THEN 1 
        ELSE 0 
      END AS ConfigureDP,     -- 1 if State is 0, or if Version is unstamped in SCF, or if Version is below target version; 0 otherwise 
      CASE 
        WHEN ISNULL(dp.IsPullDP, 0) <> ISNULL(dp.IsPullDPInstalled, 0) 
        THEN 1 
        ELSE 0 
      END AS ConfigurePullDP, -- 1 if IsPullDP <> IsPullDPInstalled (i.e. doesn't match the "should" state); 0 otherwise 
    ISNULL(dp.IsPullDP, 0) AS IsPullDP 
    FROM DistributionPoints dp 
    WHERE 
      dp.SMSSiteCode = dbo.fnGetSiteCode() AND 
      dp.DPFlags <> 1 AND 
      dp.Action <> 3 
  ) 
  SELECT 
    Priority, 
    DPID, 
    ConfigureDP, 
    CASE WHEN ConfigureDP = 1 THEN IsPullDP ELSE ConfigurePullDP END AS ConfigurePullDP -- If we're configuring the DP, we'll need to do the pull DP as well 
  FROM dps 
  WHERE 
    ConfigureDP <> 0 OR 
    ConfigurePullDP <> 0 
  ORDER BY Priority ASC, IsPullDP ASC; 
END 
