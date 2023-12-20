using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace _12laba
{
    static class AAYFileInfo
    {
        public static void FileInfo(string path)
        {
            //FileInfo-позволяет манипулировать с файлами
            FileInfo file = new FileInfo(path);
            Console.WriteLine($"Полный путь: {file.FullName}");
            Console.WriteLine($"Имя файла: {file.Name}");
            Console.WriteLine($"Расширение: {file.Extension}");
            Console.WriteLine($"Размер: {file.Length}");
            Console.WriteLine($"Дата создания: {file.CreationTime}");
            Console.WriteLine();
            Console.WriteLine();
        }
    }
    class AAYForFileInfo
    {
        private string action;
        public string FullPath(string path = @"C:\Users\Avdey\OneDrive\Рабочий стол\ООП\12\12laba\12laba\bin\Debug\netcoreapp3.1\log.txt")
        {
            FileInfo f = new FileInfo(path);
            action = "Полный путь: " + f.DirectoryName;
            return action;
        }
        public string Info(string path = @"C:\Users\Avdey\OneDrive\Рабочий стол\ООП\12\12laba\12laba\bin\Debug\netcoreapp3.1\log.txt")
        {
            FileInfo f = new FileInfo(path);
            action = "Размер в байтах: " + f.Length;
            action += "Расширение: " + f.Extension;
            action += "Имя: " + f.FullName;
            return action;
        }
        public string Dates(string path = @"C:\Users\Avdey\OneDrive\Рабочий стол\ООП\12\12laba\12laba\bin\Debug\netcoreapp3.1\log.txt")
        {
            FileInfo f = new FileInfo(path);
            action = "Дата созд: " + f.CreationTime;
            action += "Дата изменения: " + f.LastWriteTime;
            return action;
        }
    }

}
