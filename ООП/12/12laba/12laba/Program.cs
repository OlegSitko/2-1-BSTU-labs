using System;
using System.IO;

namespace _12laba
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("инфа в файле C:\\Users\\Avdey\\OneDrive\\Рабочий стол\\ООП\\12\\12laba\\12laba\\bin\\Debug\\netcoreapp3.1\\log.txt");
            AAYLog log = new AAYLog();
            AAYForFileInfo fileInfo = new AAYForFileInfo();
            log.WriteFile(fileInfo.FullPath());
            log.WriteFile(fileInfo.Info());
            log.WriteFile(fileInfo.Dates());
            AAYDiskInfo.DiskInfo();
            AAYFileInfo.FileInfo("log.txt");
            AAYDirInfo.DirInfo(@"C:\Users\Avdey\OneDrive\Рабочий стол\ООП");
            AAYFileManager.AllAboutDrive("C");
            //AAYFileManager.FileDirCreate("Inspect", "dirInfo", "createTest");
            //AAYFileManager.AAYFiles(@"C:\Users\Avdey\OneDrive\Рабочий стол\ООП\12", "png");
            AAYFileManager.Zip();
            AAYFileManager.UnZip(@"C:\Users\Avdey\OneDrive\Рабочий стол\ООП\12\Inspect");

        }
    }
}
