using System;

namespace Hubtel.Wallets.Api.Models
{
    public class Wallet
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string AccountNumber { get; set; }
        public string AccountScheme { get; set; }
        public DateTime? CreatedAt { get; set; }
        public string Owner { get; set; }
        public int UserID { get; set; }
        public string Action { get; set; }
    }
}
