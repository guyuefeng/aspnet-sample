using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using DocumentFormat.OpenXml.Packaging;
using System.Data;
using DocumentFormat.OpenXml.Spreadsheet;
using System.Text;

namespace ExcelToSql
{
    public class ExcelHelper1
    {

        int columncount = 0;

        protected int Columncount
        {
            get { return columncount; }
            set { columncount = value; }
        }

        public void Upload(Stream fileStream)
        {
            // convert excel sheet into DataTable
            DataTable table = SheetToTable(fileStream);

            // send table to DataHelper to upload data into the DB.
            //new DataHelper().UploadToDb(table);
        }

        private DataTable SheetToTable(Stream fileStream)
        {
            DataTable table = new DataTable();

            using (SpreadsheetDocument excelDoc = SpreadsheetDocument.Open(fileStream, false))
            {
                SheetData sheetData = excelDoc.WorkbookPart.WorksheetParts.ElementAt(0).Worksheet.ChildElements.OfType<SheetData>().ElementAt(0);
                List<string> siList = new List<string>();
                excelDoc.WorkbookPart.SharedStringTablePart.SharedStringTable.ChildElements.OfType<SharedStringItem>().ToList().ForEach(si =>
                {
                    siList.Add(si.Text.Text);
                });

                // create columns
                Row row = sheetData.ChildElements.OfType<Row>().ElementAt(0);
                foreach (Cell c in row.ChildElements.OfType<Cell>())
                {
                    if (c.DataType.Value == CellValues.SharedString)
                    {
                        // get the value from shared strings file
                        table.Columns.Add(siList.ElementAt(Convert.ToInt32(c.InnerText)), typeof(String));
                    }
                    else table.Columns.Add(c.InnerText, typeof(String));
                }

                // populate rows
                foreach (Row r in sheetData.ChildElements.OfType<Row>())
                {
                    // skip the first row
                    if (!(sheetData.ChildElements.OfType<Row>().ToList().IndexOf(r) == 0))
                    {
                        List<string> cellValues = new List<string>();

                        foreach (Cell c in r.ChildElements.OfType<Cell>())
                        {
                            if (c.DataType.Value == CellValues.SharedString)
                            {
                                // get the value from shared strings file
                                cellValues.Add(siList.ElementAt(Convert.ToInt32(c.InnerText)));
                            }
                            else cellValues.Add(c.InlineString.Text.Text);
                        }

                        DataRow drow = table.NewRow();
                        int index = 0;
                        cellValues.ForEach(cv =>
                        {
                            drow[index++] = cv;
                        });

                        table.Rows.Add(drow);
                    }
                }
            }

            return table;
        }
    }
}