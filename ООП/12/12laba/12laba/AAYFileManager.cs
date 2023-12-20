using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.IO.Compression;

namespace _12laba
{
    static class AAYFileManager
    {
        public static void AllAboutDrive(string disk)
        {
            string path;
            if (disk.ToLower() == "c")
            {
                path = @"C:\";
            }
            else
            {
                throw new Exception("Неверное имя диска");
            }
            DirectoryInfo dir = new DirectoryInfo(path);
            Console.WriteLine("список папок:");
            foreach(DirectoryInfo fold in dir.GetDirectories())
            {
                Console.WriteLine(fold.Name);
            }
            Console.WriteLine("Список файлов:");
            foreach(FileInfo fold in dir.GetFiles())
            {
                Console.WriteLine(fold.Name);
            }
        }
        public static void FileDirCreate(string dirName, string fileName, string fileCreate)
        {
            string dirPath = @"C:\Users\Avdey\OneDrive\Рабочий стол\ООП\12\12laba" + dirName;
            DirectoryInfo dirInfo = new DirectoryInfo(dirPath);
            if (!dirInfo.Exists)
            {
                dirInfo.Create();
            }
            string filePath = dirPath + "\\" + fileName + ".txt";
            FileInfo fileInf = new FileInfo(filePath);
            if (!fileInf.Exists)
            {
                fileInf.Create();
            }
            try
            {
                using StreamWriter sw = new StreamWriter(filePath, false, System.Text.Encoding.Default);
                sw.WriteLine("ИНФА");
                sw.Close();
            }
            catch(Exception e)
            {
                Console.WriteLine(e.Message);
            }
            string filePathCreate = dirPath + "\\" + fileCreate + ".txt";
            File.Copy(filePath, filePathCreate, true);
            File.Delete(filePath);
        }
        public static void AAYFiles(string path, string ext)
        {
            string dirPath = @"C:\Users\Avdey\OneDrive\Рабочий стол\ООП\12laba";
            DirectoryInfo dirInfo = new DirectoryInfo(dirPath);
            if (!dirInfo.Exists)
            {
                dirInfo.Create();
            }
            DirectoryInfo userDir = new DirectoryInfo(path);
            foreach(FileInfo file in userDir.GetFiles())
            {
                if (file.Extension == ("." + ext))
                {
                    file.CopyTo(dirPath + "\\" + file.Name, true);
                }
            }
            dirInfo.MoveTo(@"C:\Users\Avdey\OneDrive\Рабочий стол\ООП\12\Inspect");
        }
        public static void Zip()
        {
            DirectoryInfo source = new DirectoryInfo(@"C:\Users\Avdey\OneDrive\Рабочий стол\ООП\12\Inspect");
            ZipFile.CreateFromDirectory(source.FullName, source.FullName + ".zip");
            Console.WriteLine("АРХИВ СОЗДАН");
        }
        public static void UnZip(string foldName)
        {
            DirectoryInfo source = new DirectoryInfo(@"C:\Users\Avdey\OneDrive\Рабочий стол\ООП\12\Inspect");
            ZipFile.ExtractToDirectory(source.FullName + ".zip", foldName);
            Console.WriteLine("РАЗАРХИВИРОВАНО");
        }
    }
}
