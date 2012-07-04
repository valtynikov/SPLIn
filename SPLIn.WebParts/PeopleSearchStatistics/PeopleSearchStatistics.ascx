<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PeopleSearchStatistics.ascx.cs" Inherits="SPLIn.WebParts.PeopleSearchStatistics" %>

<script type="text/javascript">
    function showPeopleSearchStatistics(result) {
        var statisticsHTML = '  <div class="srch-stats">';
        var resultFrom = result.people._start ? result.people._start : 0;
        var resultTo = result.people._count ? resultFrom + result.people._count : result.people._total;
        statisticsHTML += '         <b>' + (resultFrom + 1) + '-' + resultTo + '</b> of ' + result.people._total + ' results';
        statisticsHTML += '     </div>';

        $("#SPLInPeopleStatistics").html(statisticsHTML);
    }
</script>

<div id="SPLInPeopleStatistics" class="srch-WPBody"></div>