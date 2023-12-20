using System;
using System.Collections.Generic;
using System.Linq;

namespace _7laba
{
    class Program
    {
        static void Main(string[] args)
        {
            // Ввод данных для первого массива
            Console.Write("размер 1 массива:");
            int n1 = int.Parse(Console.ReadLine());
            int[] a = new int[n1];
            Console.WriteLine("Введите значения");
            for (int i = 0; i < n1; i++)
            {
                a[i] = int.Parse(Console.ReadLine());
            }
            Mas<int> aa = new Mas<int>(a);

            // Ввод данных для второго массива
            Console.Write("размер 2 массива:");
            int n2 = int.Parse(Console.ReadLine());
            int[] b = new int[n2];
            Console.WriteLine("Введите значения");
            for (int i = 0; i < n2; i++)
            {
                b[i] = int.Parse(Console.ReadLine());
            }
            Mas<int> bb = new Mas<int>(b);

            // Умножение массивов
            int testLn;
            if (a.Length > b.Length)
            {
                testLn = a.Length;
            }
            else
            {
                testLn = b.Length;
            }
            int[] test = new int[testLn];
            test = aa * bb;
            Console.WriteLine("Итог");
            for (int i = 0; i < testLn; i++)
            {
                Console.WriteLine(test[i]);
            }

            // Проверка наличия отрицательных элементов в первом массиве
            bool zn;
            zn = -aa;
            Console.WriteLine($"Наличие отрицательных элементов: {zn}");

            // Вывод размера массива
            int lnAr;
            lnAr = +aa;
            Console.WriteLine($"Размер: {lnAr}");

            // Проверка на равенство двух массивов
            bool rz;
            rz = aa == bb;
            Console.WriteLine($"Проверка на равенство двух массивов: {rz}");

            // Добавление строки
            string str;
            Console.WriteLine($"Введите значение строки:");
            str = Console.ReadLine();
            Console.WriteLine(str.Add());

            // Создание объекта класса
            Production MyProd = new Production(1, "БГТУ");

            Mas<int>.Developer MyDev = new Mas<int>.Developer();

            // 7laba
            try
            {
                int[] arr1 = new int[3] { 1, 5, 3 };
                int[] arr2 = new int[3] { 5, 8, 1 };
                Mas<int> TestMas = new Mas<int>(arr1);
                TestMas.ShowUp(TestMas.ar);
                TestMas.ar = TestMas.Add(TestMas.ar, 15); // Добавление 15 в массив
                TestMas.ShowUp(TestMas.ar);
                TestMas.ar = TestMas.Delete(TestMas.ar, 5); // Удаление 5 из массива
                TestMas.ShowUp(TestMas.ar);
            }
            finally
            {
                Console.WriteLine("END");
            }

            Tovar<int> TestTovar = new Tovar<int>("qqq", 124);
            Mas<int> TestMas3 = new Mas<int>(b);
            TestTovar.Test<int>(TestTovar);

            // Запись и чтение в файл
            string Path = @"C:\Users\Avdey\OneDrive\Рабочий стол\ООП\7\testik.txt";
            for (int i = 0; i < TestMas3.ar.Length; i++)
            {
                File1.Save(Path, Convert.ToString(TestMas3.ar[i]));
            }
            File1.Read(Path);

            // Пауза в выполнении для наглядности
            System.Threading.Thread.Sleep(2000);
        }
    }
}
