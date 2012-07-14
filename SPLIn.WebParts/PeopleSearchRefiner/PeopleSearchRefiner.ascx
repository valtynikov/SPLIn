<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PeopleSearchRefiner.ascx.cs" Inherits="SPLIn.WebParts.PeopleSearchRefiner" %>

<script type="text/javascript">
    function showPeopleSearchRefiners(result) {
        var facetsHTML = "";
        for (var facetIndex in result.facets.values) {
            var facet = result.facets.values[facetIndex];
            facetsHTML += '     <div class="ms-searchref-categoryname">' + facet.name + '</div>';
            facetsHTML += '     <ul class="ms-searchref-filters">';
            var hasRefiner = false;
            var bucketsHTML = "";
            for (var bucketIndex in facet.buckets.values) {
                var bucket = facet.buckets.values[bucketIndex];
                hasRefiner = hasRefiner || bucket.selected;
                bucketsHTML += '    <li class="ms-searchref-filter ms-searchref-' + (bucket.selected ? 'selected' : 'unselected') + '">';
                bucketsHTML += '        <a class="ms-searchref-filterlink" title="Refine By: ' + bucket.name + '" href=javascript:loadPeopleSearchData("' + facet.code + '","' + bucket.code + '")>' + bucket.name + '</a>';
                bucketsHTML += '        <span class="ms-searchref-count">(' + bucket.count + ')</span>';
                bucketsHTML += '    </li>';
            }
            facetsHTML += '         <li class="ms-searchref-filter ms-searchref-' + (!hasRefiner ? 'selected' : 'unselected') + '">';
            facetsHTML += '             <a class="ms-searchref-filterlink" title="Refine By:" href=javascript:loadPeopleSearchData()> Any ' + facet.name + '</a>';
            facetsHTML += '         </li>';
            facetsHTML += bucketsHTML;
            facetsHTML += '     </ul>';
            facetsHTML += '     <div class="ms-searchref-catseparator"> </div>';
        }

        $("#SPLInPeopleRefiners").html(facetsHTML);
    }

    function getPeopleSearchRefinerFields() {
        return "facets:(<%= RefinerFields %>)";
    }

    function getPeopleSearchRefiners() {
        return "facets=<%= Refiners %>";
    }
</script>

<div id="SPLInPeopleRefiners" class="srch-WPBody ms-searchref-main">
    <div class="ms-searchref-categoryname"></div>
    <ul class="ms-searchref-filters">
        <li class="ms-searchref-filtermsg">
            <span class="ms-searchref-filterlink ms-searchref-msg">No refinements available</span>
        </li>
    </ul>
</div>