<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PeopleSearchBox.ascx.cs" Inherits="SPLIn.WebParts.PeopleSearchBox" %>

<script type="text/javascript" src="//platform.linkedin.com/in.js">
    api_key: <%= LinkedInApiKey %>
    authorize: <%= RememberMe.ToString().ToLower() %>
</script>

<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.4/themes/base/jquery-ui.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.4/jquery-ui.min.js" type="text/javascript"></script>

<script type="text/javascript">
    //https://developer.linkedin.com/documents/people-search-api
    var availableTags = [
			"first-name:",
			"last-name:",
			"company-name:",
            "current-company:",
            "title:",
            "current-title:",
            "school-name:",
            "current-school:",
            "country-code:",
            "postal-code:"
		];

    function loadPeopleSearchData(facetCode, bucketCode) {
        var searchQuery = $("#SPLInSearchBox").val();
        if (searchQuery == "") {
            return;
        }

        if (!IN.API) {
            alert("Please set the LinkedIn API Key web part property");
            return;
        }

        var url = "/people-search:(people:(<%= DataFields %>)";

        if (typeof getPeopleSearchRefinerFields == 'function') {
            url += "," + getPeopleSearchRefinerFields();
        }

        for (var i in availableTags) {
            var tag = availableTags[i];
            searchQuery = searchQuery.replace(tag, "&" + tag.replace(":", "="));
        }

        url += ")?keywords=" + searchQuery;

        if (typeof getPeopleSearchRefiners == 'function') {
            url += "&" + getPeopleSearchRefiners();
        }

        if (facetCode && bucketCode) {
            url += "&facet=" + facetCode + "," + bucketCode;
        }

        if (typeof getPeopleSearchResultCount == 'function') {
            url += "&" + getPeopleSearchResultCount();
        }

        IN.API.Raw(url).result(function (result) {
            if (typeof showPeopleSearchResults == 'function') {
                showPeopleSearchResults(result);
            }
            if (typeof showPeopleSearchRefiners == 'function') {
                showPeopleSearchRefiners(result);
            }
            if (typeof showPeopleSearchStatistics == 'function') {
                showPeopleSearchStatistics(result);
            } 
        })
        .error(function (error) {
            if (error.status === 401) {
                // try it again
                var oldToken = IN.ENV.auth.oauth_token;
                IN.User.refresh();
                // since the refresh method is asynchronous but doesn't provide a callback, we have to poll
                function tryAgain() {
                    setTimeout(function () {
                        if (oldToken !== IN.ENV.auth.oauth_token) {
                            loadPeopleSearchData();
                        }
                        else {
                            setTimeout(tryAgain, 100);
                        }
                    }, 100);
                }
                tryAgain();
            }
        });
    }

    $(document).ready(function () {

        function split(val) {
            return val.split(/ \s*/);
        }
        function extractLast(term) {
            return split(term).pop();
        }

        $('#SPLInSearchBox')
            .bind('keypress', function (e) {
                if (e.keyCode == 13) {
                    e.preventDefault();
                    loadPeopleSearchData();
                }
            })
		    .bind("keydown", function (event) {
		        if (event.keyCode === $.ui.keyCode.TAB && $(this).data("autocomplete").menu.active) {
    		        event.preventDefault();
    		    }
    	    })
		    .autocomplete({
			    minLength: 0,
			    source: function (request, response) {
			        // delegate back to autocomplete, but extract the last term
			        response($.ui.autocomplete.filter(
					    availableTags, extractLast(request.term)));
			    },
			    focus: function () {
			        // prevent value inserted on focus
			        return false;
			    },
			    select: function (event, ui) {
			        var terms = split(this.value);
			        // remove the current input
			        terms.pop();
			        // add the selected item
			        terms.push(ui.item.value);
			        this.value = terms.join(" ");
			        return false;
			    }
		    });
    });
</script>

<div>
    <table class="ms-sbtable ms-sbtable-ex" cellpadding="0" cellspacing="0" border="0">
        <tr class="ms-sbrow">
            <td class="ms-sbcell">
                <input type="text" name="SPLInSearchBox" id="SPLInSearchBox" class="ms-sbplain" style="margin:0px; width:368px;" />
            </td>
            <td class="ms-sbgo ms-sbcell">
                <a href="javascript:loadPeopleSearchData()"><img style="border-width:0px;" class="srch-gosearchimg" onmouseover="this.src='\u002f_layouts\u002fimages\u002fgosearchhover30.png'" onmouseout="this.src='\u002f_layouts\u002fimages\u002fgosearch30.png'" src="/_layouts/images/gosearch30.png" /></a>
            </td>
        </tr>
    </table>
</div>