using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using System.Text.Json.Serialization;  

namespace CloudySkies.Function
{
    public static class HttpTriggerGetSqlData
    {
        public class SalesTransaction
        {
            public int Id { get; set; }
            public DateTime sale_date { get; set; }
            public string customer_id {get; set;}
            public string product_id { get; set; }
            public int quantity { get; set; }
            public decimal price { get; set; }
        }

        [FunctionName("HttpTriggerGetSqlData")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = "transactions")] HttpRequest req,
            ILogger log,
            [Sql("select * from sales_transaction",
            CommandType = System.Data.CommandType.Text,
            ConnectionStringSetting = "SqlConnectionString")]
            IEnumerable<SalesTransaction> salesTransactions)
        {
            log.LogInformation("Query received for sales transactions...");
            
            return new OkObjectResult(salesTransactions);
        }
    }
}
