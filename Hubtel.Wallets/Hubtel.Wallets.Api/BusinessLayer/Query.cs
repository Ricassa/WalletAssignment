using Hubtel.Wallets.Api.Models;
using Hubtel.Wallets.Api.Controllers;
using Microsoft.Extensions.Configuration;
using System.Data.SqlClient;
using System.Data;
using System;
using System.Collections.Generic;

namespace Hubtel.Wallets.Api.BusinessLayer
{
    public class Query
    {
        private readonly IConfiguration Configuration;

        public Query(IConfiguration configuration)
        {
            this.Configuration = configuration;
        }

        internal int CreateWallet(Wallet wallet)
        {

            var myTestConnectionString = Configuration.GetConnectionString("TestHubCon");
            using (SqlConnection connection = new SqlConnection(myTestConnectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("spWallet_IUD", connection))
                {
                    // Set the command type to stored procedure
                    cmd.CommandType = CommandType.StoredProcedure;

                    //cmd.Parameters.Add("@LogID", SqlDbType.Int).Value = wallet.LogId;
                    cmd.Parameters.Add("@Name", SqlDbType.VarChar, 20).Value = wallet.Name;
                    cmd.Parameters.Add("@Type", SqlDbType.VarChar, 20).Value = wallet.Type;
                    cmd.Parameters.Add("@AccountNumber", SqlDbType.VarChar, 20).Value = wallet.AccountNumber;
                    cmd.Parameters.Add("@AccountScheme", SqlDbType.VarChar, 50).Value = wallet.AccountScheme;

                    cmd.Parameters.Add("@Owner", SqlDbType.VarChar, 100).Value = wallet.Owner;
                    cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = wallet.UserID;
                    cmd.Parameters.Add("@Action", SqlDbType.VarChar, 1).Value = wallet.Action;

                    cmd.Parameters.Add("@ResultID", SqlDbType.Int).Direction = ParameterDirection.Output;

                    cmd.ExecuteNonQuery();
                    var resultId = cmd.Parameters["@ResultID"].Value;
                    //var appID = cmd.Parameters["@AppIdOUT"].Value;
                    var results = 0;

                    results = (int)(resultId != DBNull.Value ? Convert.ToInt64(resultId) : 0);

                    return results;
                }
            }
        }

        internal int DeleteWallet(Wallet wallet)
        {

            var myTestConnectionString = Configuration.GetConnectionString("TestHubCon");
            using (SqlConnection connection = new SqlConnection(myTestConnectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("spDeleteWallet", connection))
                {
                    // Set the command type to stored procedure
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = wallet.ID;
                    cmd.Parameters.Add("@Action", SqlDbType.VarChar, 1).Value = wallet.Action;

                    cmd.Parameters.Add("@ResultID", SqlDbType.Int).Direction = ParameterDirection.Output;

                    cmd.ExecuteNonQuery();
                    var resultId = cmd.Parameters["@ResultID"].Value;
                    //var appID = cmd.Parameters["@AppIdOUT"].Value;
                    var results = 0;

                    results = (int)(resultId != DBNull.Value ? Convert.ToInt64(resultId) : 0);

                    return results;
                }
            }
        }

        internal List<Wallet> GetAllWallets()
        {
            var myTestConnectionString = Configuration.GetConnectionString("TestHubCon");
            using (SqlConnection connection = new SqlConnection(myTestConnectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("spGetWallets", connection))
                {
                    var WalletList = new List<Wallet>();
                    // Set the command type to stored procedure
                    cmd.CommandType = CommandType.StoredProcedure;

                    var dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        var wallet = new Wallet();
                        wallet.ID = !dr.IsDBNull(dr.GetOrdinal("ID")) ? dr.GetInt32(dr.GetOrdinal("ID")) : 0;
                        wallet.UserID = !dr.IsDBNull(dr.GetOrdinal("UserID")) ? dr.GetInt32(dr.GetOrdinal("UserID")) : 0;
                        wallet.Name = !dr.IsDBNull(dr.GetOrdinal("Name")) ? dr.GetString(dr.GetOrdinal("Name")).ToUpper() : "";
                        wallet.AccountNumber = !dr.IsDBNull(dr.GetOrdinal("AccountNumber")) ? dr.GetString(dr.GetOrdinal("AccountNumber")).ToUpper() : "";
                        wallet.AccountScheme = !dr.IsDBNull(dr.GetOrdinal("AccountScheme")) ? dr.GetString(dr.GetOrdinal("AccountScheme")).ToUpper() : "";
                        wallet.Owner = !dr.IsDBNull(dr.GetOrdinal("Owner")) ? dr.GetString(dr.GetOrdinal("Owner")).ToUpper() : "";
                        wallet.Type = !dr.IsDBNull(dr.GetOrdinal("Type")) ? dr.GetString(dr.GetOrdinal("Type")).ToUpper() : "";
                        wallet.CreatedAt = !dr.IsDBNull(dr.GetOrdinal("CreatedAt")) ? dr.GetDateTime(dr.GetOrdinal("CreatedAt")) : (DateTime?)null;

                        WalletList.Add(wallet);
                    }

                    return WalletList;
                }
            }
        }
        internal Wallet GetWalletById(int id)
        {
            var wallet = new Wallet();
            var myTestConnectionString = Configuration.GetConnectionString("TestHubCon");
            using (SqlConnection connection = new SqlConnection(myTestConnectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("spGetWalletById", connection))
                {
                    // Set the command type to stored procedure
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ID", SqlDbType.BigInt).Value = id;

                    var dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        wallet.ID = !dr.IsDBNull(dr.GetOrdinal("ID")) ? dr.GetInt32(dr.GetOrdinal("ID")) : 0;
                        wallet.UserID = !dr.IsDBNull(dr.GetOrdinal("UserID")) ? dr.GetInt32(dr.GetOrdinal("UserID")) : 0;
                        wallet.Name = !dr.IsDBNull(dr.GetOrdinal("Name")) ? dr.GetString(dr.GetOrdinal("Name")).ToUpper() : "";
                        wallet.AccountNumber = !dr.IsDBNull(dr.GetOrdinal("AccountNumber")) ? dr.GetString(dr.GetOrdinal("AccountNumber")).ToUpper() : "";
                        wallet.AccountScheme = !dr.IsDBNull(dr.GetOrdinal("AccountScheme")) ? dr.GetString(dr.GetOrdinal("AccountScheme")).ToUpper() : "";
                        wallet.Owner = !dr.IsDBNull(dr.GetOrdinal("Owner")) ? dr.GetString(dr.GetOrdinal("Owner")).ToUpper() : "";
                        wallet.Type = !dr.IsDBNull(dr.GetOrdinal("Type")) ? dr.GetString(dr.GetOrdinal("Type")).ToUpper() : "";
                        wallet.CreatedAt = !dr.IsDBNull(dr.GetOrdinal("CreatedAt")) ? dr.GetDateTime(dr.GetOrdinal("CreatedAt")) : (DateTime?)null;

                    }


                }
            }
            return wallet;

        }
    }
}

