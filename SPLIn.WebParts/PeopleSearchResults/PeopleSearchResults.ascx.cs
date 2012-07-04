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
    public partial class PeopleSearchResults : System.Web.UI.WebControls.WebParts.WebPart
    {
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

        protected int _resultCount;

        [WebBrowsable(true), WebDisplayName("Result Count"), Personalizable(PersonalizationScope.Shared), Category("Configuration")]
        public int ResultCount
        {
            get
            {
                return _resultCount;
            }
            set
            {
                _resultCount = value;
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
