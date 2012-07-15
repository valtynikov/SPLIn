<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PeopleSearchResults.ascx.cs" Inherits="SPLIn.WebParts.PeopleSearchResults" %>

<script type="text/javascript">
    function getPeopleSearchResultCount() {
        return "count=<%= ResultCount %>";
    }

    function showPeopleSearchResults(result) {
        if (result.people._total == 0) {
            return;
        }

        var dataIds = [];
        for (var index in result.people.values) {
            profile = result.people.values[index]
            dataIds.push(profile.id);
        }
        var profHTML =
            '<script type="IN/MemberData" data-ids="' + dataIds.join(",") + '" data-fields="<%= DataFields %>">' +
            '<?js var i=0; ?>' +
            '<?js for (var member in $("*")) { ?>' +
            '    <div class="psrch-<?js if(i == 0) { ?>First<?js } ?>FullResult">' +
    	    '        <div id="UserPhoto">' +
    	    '            <a href="<?js= $(member).siteStandardProfileRequest.url ?>" title="<?js= $(member).formattedName ?>">' +
    		'                <img src="<?js if($(member).pictureUrl) { ?><?js= $(member).pictureUrl ?><?js } else { ?>/_layouts/images/o14_person_placeholder_96.png<?js } ?>" alt="<?js= $(member).formattedName ?>" border="0" width="86" height="86">' +
    	    '            </a>' +
            '        </div>' +
            '    </div>' +
            '    <span id="JBean">' +
            '    </span>' +
            '    <div id="ContactInfo">' +
    	    '        <ul id="MiniContactCard">' +
    		'            <li id="NameField">' +
    		'	            <a href="<?js= $(member).siteStandardProfileRequest.url ?>"><?js= $(member).formattedName ?></a>' +
    		'            </li>' +
            '            <li>' +
            '                <?js if($(member).distance == 1) { ?>1st degree contact<?js } ?>' +
            '                <?js if($(member).distance == 2) { ?>2nd degree contact<?js } ?>' +
            '                <?js if($(member).distance == 3) { ?>3rd degree contact<?js } ?>' +
            '                <?js if($(member).distance == -1) { ?>Out of network<?js } ?>' +
            '                <?js if($(member).distance == 100) { ?>Group in common<?js } ?>' +
            '            </li>' +
    		'            <li><?js= $(member).headline ?></li>' +
    		'            <li><?js= $(member).location.name ?></li>' +
    		'            <li><?js= $(member).industry ?></li>' +
            '            <?js if($(member).phoneNumbers && $(member).phoneNumbers.values) { ?>' +
            '                <?js for (var i = 0; i < $(member).phoneNumbers.values.length; i++) { ?>' +
            '                    <?js var phone = $(member).phoneNumbers.values[i]; ?>' +
            '                    <li><?js= phone.phoneType ?>: <?js= phone.phoneNumber ?></li>' +
            '                <?js } ?>' +
            '            <?js } ?>' +
    		'            <li><?js= $(member).numConnections ?><?js if($(member).numConnectionsCapped) { ?>+<?js } ?> connections</li>' +
    	    '        </ul>' +
    	    '        <ul id="Actions">' +
    		'            <li>' +
    		'	            <a href="#">Send message</a>' +
    		'            </li>' +
            '            <?js if($(member).distance != 0 && $(member).distance != 1) { ?>' +
    		'            <li>' +
    		'	            <a href="#">Invite to connect</a>' +
    		'            </li>' +
            '            <?js } ?>' +
    	    '        </ul>' +
            '    </div>' +
            '    <div id="MoreInfo">' +
            '        <ul>' +
            '            <?js if($(member).summary) { ?>' +
            '                <li>' +
            '                    <span id="FieldTitle">Summary</span>' +
            '                    <?js= $(member).summary.replace(/\n/g, "<br />") ?>' +
            '                </li>' +
            '            <?js } ?>' +
            '            <?js if($(member).specialties) { ?>' +
            '                <li>' +
            '                    <span id="FieldTitle">Specialties</span>' +
            '                    <?js= $(member).specialties.replace(/\n/g, "<br />") ?>' +
            '                </li>' +
            '            <?js } ?>' +
            '        </ul>' +
            '    </div>' +
            '    <div id="Clear">' +
    	    '        <img src="/_layouts/images/blank.gif" alt=""/>' +
            '    </div>' +
            '    <?js i++; ?>' +
            '<?js } ?>' +
            '<\/script>';

        $("#SPLInSearchResults").html(profHTML);
        IN.parse();
        $("#SPLInSearchResults span:first-child").removeAttr("style");
    }
</script>

<script type="IN/Login" data-onAuth="loadPeopleSearchData"></script>
<div class="psrch-Main">
    <div id="SPLInSearchResults" class="psrch-results">
        <span class="ms-descriptiontext">No results are available.</span>
    </div>
</div>