using System;
using System.Data;
using System.Data.SqlClient;

namespace ExecuteApp
{
    class Program
    {
        static void Main(string[] args)
        {
            string _connectionString;

            _connectionString = "<連線字串>";


            DateTime _orderDate;
            string _payment;
            string _shippment;
            DataTable _orderDetails;
            int _orderNo;

            _orderDate = DateTime.Now;
            _payment = "分期信用卡付款";
            _shippment = "黑貓宅急便";
            _orderDetails = new DataTable();

            _orderDetails.Columns.Add("ProductNo", typeof(Int16));
            _orderDetails.Columns.Add("Index", typeof(Byte));
            _orderDetails.Columns.Add("Quantity", typeof(Int16));
            _orderDetails.Columns.Add("UnitPrice", typeof(Decimal));

            DataRow _row;

            _row = _orderDetails.NewRow();
            _row["ProductNo"] = 4;
            _row["Index"] = 0;
            _row["Quantity"] = 5;
            _row["UnitPrice"] = 100;
            _orderDetails.Rows.Add(_row);
            
            _row = _orderDetails.NewRow();
            _row["ProductNo"] = 5;
            _row["Index"] = 1;
            _row["Quantity"] = 2;
            _row["UnitPrice"] = 40;
            _orderDetails.Rows.Add(_row);
            

            using (SqlConnection _conn
                = new SqlConnection(_connectionString))
            {
                SqlCommand _cmd = new SqlCommand();

                _cmd.Connection = _conn;
                _cmd.CommandType = CommandType.StoredProcedure;
                _cmd.CommandText = "Order.AddOrder";

                _cmd.Parameters.Add("@OrderDate", SqlDbType.SmallDateTime);
                _cmd.Parameters.Add("@Payment", SqlDbType.NVarChar, 50);
                _cmd.Parameters.Add("@Shippment", SqlDbType.NVarChar, 50);
                _cmd.Parameters.Add("@OrderDetails", SqlDbType.Structured);
                _cmd.Parameters.Add("@OrderNo", SqlDbType.Int);

                //指定自訂資料表類型名稱
                _cmd.Parameters["@OrderDetails"].TypeName = "Order.OrderDetails";
                _cmd.Parameters["@OrderNo"].Direction = ParameterDirection.Output;

                _cmd.Parameters["@OrderDate"].Value = _orderDate;
                _cmd.Parameters["@Payment"].Value = _payment;
                _cmd.Parameters["@Shippment"].Value = _shippment;
                _cmd.Parameters["@OrderDetails"].Value = _orderDetails;
                _cmd.Parameters["@OrderNo"].Value = DBNull.Value;

                _conn.Open();
                _cmd.ExecuteNonQuery();
                _conn.Close();

                _orderNo = Convert.ToInt32(_cmd.Parameters["@OrderNo"].Value);

                if (_orderNo > 0)
                { 
                    Console.WriteLine("Add Order Success [ OrderNo : {0} ]", _orderNo);
                }
            }

            Console.WriteLine("press any key to exit");
            Console.ReadKey();
        }
    }
}
