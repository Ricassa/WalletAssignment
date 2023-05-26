using Microsoft.AspNetCore.Mvc;
using Hubtel.Wallets.Api.Models;
using Hubtel.Wallets.Api.BusinessLayer;
using Microsoft.Extensions.Configuration;
using System;

namespace Hubtel.Wallets.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class WalletController : Controller
    {
        private readonly IConfiguration Configuration;

        public WalletController(IConfiguration configuration)
        {
            this.Configuration = configuration;
        }


        [HttpGet]
        public IActionResult Index()
        {
            try
            {

                Query q = new Query(Configuration);
                var result = q.GetAllWallets();
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Route("getwalletbyid/{id}")]
        [HttpGet]
        public IActionResult GetWalletById(int id)
        {
            try
            {

                Query q = new Query(Configuration);
                var result = q.GetWalletById(id);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        //[Route("addwallet")]

        [HttpPost]
        public IActionResult AddWallet(Wallet newWallet)
        {
            try
            {

                Query q = new Query(Configuration);
                var result = q.CreateWallet(newWallet);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete]
        public IActionResult DeleteWallet(Wallet delWallet)
        {
            try
            {

                Query q = new Query(Configuration);
                var result = q.DeleteWallet(delWallet);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
