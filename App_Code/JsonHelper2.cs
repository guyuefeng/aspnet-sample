using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;

/// <summary>
/// Summary description for JsonHelper2
/// </summary>
public class JsonHelper2
{
	public JsonHelper2()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    /// <summary>
    /// 将对象转化为Json字符串
    /// </summary>
    /// <typeparam name="T">源类型</typeparam>
    /// <param name="instance">源类型实例</param>
    /// <returns>Json字符串</returns>
    public static string ObjectToJson<T>(T instance)
    {
        string result = string.Empty;

        //创建指定类型的Json序列化器
        DataContractJsonSerializer jsonSerializer = new DataContractJsonSerializer(typeof(T));

        //将对象的序列化为Json格式的Stream
        MemoryStream stream = new MemoryStream();
        jsonSerializer.WriteObject(stream, instance);

        //读取Stream
        stream.Position = 0;
        StreamReader sr = new StreamReader(stream);
        result = sr.ReadToEnd();

        return result;
    }

    /// <summary>
    /// 将Json字符串转化为对象
    /// </summary>
    /// <typeparam name="T">目标类型</typeparam>
    /// <param name="jsonString">Json字符串</param>
    /// <returns>目标类型的一个实例</returns>
    public static T JsonToObject<T>(string jsonString)
    {
        T result;

        //创建指定类型的Json序列化器
        DataContractJsonSerializer jsonSerializer = new DataContractJsonSerializer(typeof(T));

        //将Json字符串放入Stream中
        byte[] jsonBytes = new UTF8Encoding().GetBytes(jsonString);
        MemoryStream stream = new MemoryStream(jsonBytes);

        //使用Json序列化器将Stream转化为对象
        result = (T)jsonSerializer.ReadObject(stream);

        return result;
    }
}
