using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;

namespace CloudySkies.Function
{
    public static class HttpTriggerGetSqlData
    {
        [FunctionName("HttpTriggerGetSqlData")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = "employees")] HttpRequest req,
            ILogger log,
            [Sql("select * from Employees",
            CommandType = System.Data.CommandType.Text,
            ConnectionStringSetting = "SqlConnectionString")]
            IEnumerable<Employee> employee)
        {
            return new OkObjectResult(employee);
        }
    }
}
