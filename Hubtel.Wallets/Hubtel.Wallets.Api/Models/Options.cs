using System;

namespace Hubtel.Wallets.Api.Models
{
    public class Options
    {
        public int PopID { get; set; }
        public int PopNumber { get; set; }
        public int PopSeq { get; set; }
        public string PopChar { get; set; }
        public int PopCode { get; set; }
        public string PopDesc { get; set; }
        public string PopComment { get; set; }
        public string PopEntryPerson { get; set; }
        public DateTime PopSysDate { get; set; }
    }
}
