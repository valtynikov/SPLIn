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
    public partial class PeopleSearchRefiner : System.Web.UI.WebControls.WebParts.WebPart
    {
        protected string _refinerFields;

        [WebBrowsable(true), WebDisplayName("Refiner Fields"), Personalizable(PersonalizationScope.Shared), Category("Configuration")]
        public string RefinerFields
        {
            get
            {
                return _refinerFields;
            }
            set
            {
                _refinerFields = value;
            }
        }

        protected string _refiners;

        [WebBrowsable(true), WebDisplayName("Refiners"), Personalizable(PersonalizationScope.Shared), Category("Configuration")]
        public string Refiners
        {
            get
            {
                return _refiners;
            }
            set
            {
                _refiners = value;
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
