using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


/// <summary>
///Northwind 的摘要说明
/// </summary>
public class Northwind
{
	public Northwind()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}

    string conn = "server=(local);uid=sa;pwd=123456;database=northwind";
    
    public static DataTable GetProducts(int pageindex)
    {
        DataTable dt = SqlHelper.GetDataByPager2005("productid,productname,UnitPrice,Discontinued", "products", "", "productid desc", pageindex, 10);
        return dt;
    }

    public static DataTable GetOrders(int pageindex)
    {
        DataTable dt = SqlHelper.GetDataByPager2005("orderid,customerid,shipname,shipcity", "orders", "", "orderid desc", pageindex, 20);
        return dt;
    }


    public static DataTable GetOrders(int pageindex,string orderfiled)
    {
        DataTable dt = SqlHelper.GetDataByPager2005("orderid,customerid,shipname,shipcity", "orders", "", orderfiled, pageindex, 20);
        return dt;
    }

    public static DataTable GetCustomers(int pageindex, string orderfiled)
    {
        DataTable dt = SqlHelper.GetDataByPager2005("[CustomerID],[CompanyName],[ContactName],[City],[Phone]", "Customers", "", orderfiled, pageindex, 20);
        return dt;
    }




    public static string GetPageCount(string tablename)
    {
        int recordCount = SqlHelper.GetRecordCount(tablename);

        return recordCount.ToString();
    }
}
