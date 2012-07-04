using System;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;

namespace SPLIn.WebParts
{
    [ToolboxItem(false)]
    public partial class PeopleSearchBox : System.Web.UI.WebControls.WebParts.WebPart
    {
        protected string _linkedInApiKey;

        [WebBrowsable(true), WebDisplayName("LinkedIn API Key"), Personalizable(PersonalizationScope.Shared), Category("Configuration")]
        public string LinkedInApiKey
        {
            get
            {
                return _linkedInApiKey;
            }
            set
            {
                _linkedInApiKey = value;
            }
        }

        protected bool _rememberMe;

        [WebBrowsable(true), WebDisplayName("Remember Me"), Personalizable(PersonalizationScope.Shared), Category("Configuration")]
        public bool RememberMe
        {
            get
            {
                return _rememberMe;
            }
            set
            {
                _rememberMe = value;
            }
        }

        protected string _dataFields;

        [WebBrowsable(true), WebDisplayName("Data Fields"), Personalizable(PersonalizationScope.Shared), Category("Configuration")]
        public string DataFields
        {
            get
            {
                return _dataFields;
            }
            set
            {
                _dataFields = value;
            }
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            InitializeControl();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
    }
}
