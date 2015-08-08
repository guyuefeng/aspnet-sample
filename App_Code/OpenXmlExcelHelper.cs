using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using DocumentFormat.OpenXml.Spreadsheet;
using DocumentFormat.OpenXml.Packaging;
using System.IO;

/// <summary>
/// Summary description for ExcelHelper
/// </summary>
public class OpenXmlExcelHelper
{
    /// <summary>
    /// 每个sheet列数
    /// </summary>
    int columnscount = 50;

    protected int Columnscount
    {
        get { return columnscount; }
        set { columnscount = value; }
    }

    /// <summary>
    /// 每个sheet行数
    /// </summary>
    int rowscount = 10000;

    protected int Rowscount
    {
        get { return rowscount; }
        set { rowscount = value; }
    }

    /// <summary>
    /// 
    /// </summary>
    public OpenXmlExcelHelper()
    {

    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="columns">指定列数</param>
    public OpenXmlExcelHelper(int columns)
    {
        columnscount = columns;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="rows">指定行数</param>
    /// <param name="columns">指定列数</param>
    public OpenXmlExcelHelper(int rows, int columns)
    {
        rowscount = rows;
        columnscount = columns;
    }
    /// <summary>
    /// Excel转为Dataset数据
    /// </summary>
    /// <param name="fileStream"></param>
    /// <returns></returns>
    public DataSet  SheetToDataSet(Stream fileStream)
    {
        DataSet dsMsg = new DataSet();

        using (SpreadsheetDocument myDoc = SpreadsheetDocument.Open(fileStream,false))
        {
            WorkbookPart workbookPart = myDoc.WorkbookPart;
            IEnumerable<Sheet> theSheets = workbookPart.Workbook.Descendants<Sheet>();
 

            foreach (Sheet theSheet in theSheets)
            {
                if (theSheet != null)
                {
                    //创建Datatable
                    DataTable msgTB = new DataTable(theSheet.Name);
                    string[] cols=new string[columnscount]; 

                    Worksheet ws = ((WorksheetPart)(workbookPart.GetPartById(theSheet.Id))).Worksheet;
                    SheetData sheetData = ws.GetFirstChild<SheetData>();
                    SharedStringTablePart tablePart = workbookPart.SharedStringTablePart;

                    int rowNum = 0;
                    foreach (Row r in sheetData.Elements<Row>())
                    {

                        rowNum++;
                        //超过指定行数则不执行
                        if (rowNum == rowscount)
                            break;

                        if (rowNum == 1)
                        {
                            int colNum1 = 0;
                            foreach (Cell c in r.Elements<Cell>())
                            {
                                cols[colNum1] = GetValue(c, tablePart);
                                msgTB.Columns.Add(cols[colNum1], typeof(string));

                                if (colNum1 == columnscount - 1)
                                    break;
                                else
                                    colNum1++;
                            }
                        }
                        else
                        {
                            int colNum = 0;
                            DataRow newRow = msgTB.NewRow();

                            foreach (Cell c in r.Elements<Cell>())
                            {
                                newRow[colNum] = GetValue(c, tablePart);

                                if (colNum == columnscount - 1)
                                    break;
                                else
                                    colNum++;
                            }

                            msgTB.Rows.Add(newRow);
                        }
                    }
                    dsMsg.Tables.Add(msgTB);
                }
            }
        }

        return dsMsg;
    }

    private String GetValue(Cell cell, SharedStringTablePart stringTablePart)
    {
        if (cell.ChildElements.Count == 0)
        {
            return null;
        }

        //get cell value
        String value = cell.CellValue.InnerText;

        //Look up real value from shared string table
        if ((cell.DataType != null) && (cell.DataType == CellValues.SharedString))
        {
            value = stringTablePart.SharedStringTable.ChildElements[Int32.Parse(value)].InnerText;
        }
        return value;
    }
	
}
