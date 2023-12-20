using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
namespace ConsoleApp1
{

    internal class Program
    {
        static void Main(string[] args)
        {
            //int choice = 0;
            while (true)
            {
                Console.WriteLine("задания: ");
                Console.WriteLine("1a, 1b, 1c, 1df, 1e");
                Console.WriteLine("2a, 2b, 2c, 2d");
                Console.WriteLine("3a, 3b, 3c, 3d");
                Console.WriteLine("4abcd");
                Console.WriteLine("5");
                Console.WriteLine("6");
                Console.WriteLine("- для выхода");
                Console.Write("Выбор: ");
                string choice = Console.ReadLine();
                switch (choice)
                {
                    case "-":
                        Console.WriteLine("Выход...");
                        Environment.Exit(0);
                        break;
                    case "1a":
                        Task1a();
                        break;
                    case "1b":
                        Task1b();
                        break;
                    case "1c":
                        Task1c();
                        break;
                    case "1df":
                        Task1df();
                        break;
                    case "1e":
                        Task1e();
                        break;

                    case "2a":
                        Task2a();
                        break;
                    case "2b":
                        Task2b();
                        break;
                    case "2c":
                        Task2c();
                        break;
                    case "2d":
                        Task2d();
                        break;

                    case "3a":
                        Task3a();
                        break;
                    case "3b":
                        Task3b();
                        break;
                    case "3c":
                        Task3c();
                        break;
                    case "3d":
                        Task3d();
                        break;

                    case "4abcd":
                        Task4abcd();
                        break;

                    case "5":
                        Task5();
                        WriteTitle("Task 5");
                        break;

                    case "6":
                        Task6();
                        break;

                    default:
                        Console.WriteLine("Неыерный номер задания");
                        break;
                }
            }
            void WriteTitle(string title)
            {
                Console.WriteLine($"\n\n{title,30}\n");
            }
            void Task1a()
            {
                WriteTitle("Task 1a");
                bool BOOL = false;
                Console.WriteLine("введите значение переменной bool: ");
                BOOL = Convert.ToBoolean(Console.ReadLine());
                Console.WriteLine("bool = " + BOOL);

                byte BYTE = 255;
                Console.WriteLine("введите значение переменной byte: ");
                BYTE = Convert.ToByte(Console.ReadLine());
                Console.WriteLine("byte = " + BYTE);

                sbyte SBYTE = -128;
                Console.WriteLine("введите значение переменной sbyte: ");
                SBYTE = Convert.ToSByte(Console.ReadLine());
                Console.WriteLine("sbyte = " + SBYTE);

                char CHAR = 'q';
                Console.WriteLine("введите значение переменной char: ");
                CHAR = Convert.ToChar(Console.ReadLine());
                Console.WriteLine("char = " + CHAR);

                decimal DECIMAL = 0;
                Console.WriteLine("введите значение переменной decimal: ");
                DECIMAL = Convert.ToDecimal(Console.ReadLine());
                Console.WriteLine("decimal = " + DECIMAL);

                double DOUBLE = 0;
                Console.WriteLine("введите значение переменной double: ");
                DOUBLE = Convert.ToDouble(Console.ReadLine());
                Console.WriteLine("double = " + DOUBLE);

                float FLOAT = 0;
                Console.WriteLine("введите значение переменной float: ");
                FLOAT = Convert.ToSingle(Console.ReadLine());
                Console.WriteLine("float = " + FLOAT);

                int INT = -2147483648;
                Console.WriteLine("введите значение переменной int: ");
                INT = Convert.ToInt32(Console.ReadLine());
                Console.WriteLine("int = " + INT);

                uint UINT = 4294967295;
                Console.WriteLine("введите значение переменной uint: ");
                UINT = Convert.ToUInt32(Console.ReadLine());
                Console.WriteLine("uint = " + UINT);

                long LONG = -9223372036854775808;
                Console.WriteLine(" введите значение переменной long: ");
                LONG = Convert.ToInt64(Console.ReadLine());
                Console.WriteLine("long = " + LONG);

                ulong ULONG = 18446744073709551615;
                Console.WriteLine(" введите значение переменной ulong: ");
                ULONG = Convert.ToUInt64(Console.ReadLine());
                Console.WriteLine("ulong = " + ULONG);

                short SHORT = -32768;
                Console.WriteLine(" введите значение переменной short: ");
                SHORT = Convert.ToInt16(Console.ReadLine());
                Console.WriteLine("short = " + SHORT);

                ushort USHORT = 65535;
                Console.WriteLine(" введите значение переменной ushort: ");
                USHORT = Convert.ToUInt16(Console.ReadLine());
                Console.WriteLine("ushort = " + USHORT);

                object OBJECT = "luboiTip";
                Console.WriteLine(" введите значение переменной object: ");
                OBJECT = Convert.ToString(Console.ReadLine());
                Console.WriteLine("object = " + OBJECT);

                string STRING = "qwerty";
                Console.WriteLine(" введите значение переменной string: ");
                STRING = Convert.ToString(Console.ReadLine());
                Console.WriteLine("string = " + STRING);

                dynamic DYNAMIC = 1;
                Console.WriteLine(" введите значение переменной dynamic: ");
                DYNAMIC = Convert.ToDouble(Console.ReadLine());
                Console.WriteLine("dynamic = " + DYNAMIC);
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }
            void Task1b()
            {
                int a = 123;
                long b = a;
                Console.WriteLine($"{b} - Неявное преобразование из int в long ");
                int c = (int)b;
                Console.WriteLine($"{c} - Явное преобразование из long в int");

                short a1 = 012;
                long c1 = a1;
                Console.WriteLine($"{c1} - Неявное преобразование из short в long");
                byte b1 = (byte)a1;
                Console.WriteLine(b1 + " - Явное преобразование из short в byte");

                char a2 = 'q';
                long c2 = a2;
                Console.WriteLine(c2 + " - Неявное преобразование из char в long");
                byte b2 = (byte)a2;
                Console.WriteLine(b2 + " - Явное преобразование из char в int");

                decimal a3 = 1;
                object b3 = a3;
                Console.WriteLine(b3 + " Неявное преобразование из decimal в object");
                float c3 = (float)a3;
                Console.WriteLine(c3 + " Явное преобразование из decimal в float");

                double a4 = 0.2;
                object b4 = a4;
                Console.WriteLine(b4 + " - Неявное преобразование из double в object");
                int c4 = (int)a4;
                Console.WriteLine(c4 + " - Явное преобразование из double в char");

                float a5 = 55;
                object b5 = a5;
                Console.WriteLine(b5 + " - Неявное преобразование из float в object");
                ushort c5 = (ushort)a5;
                Console.WriteLine(c5 + " - Явное преобразование из float в ushort");
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }
            void Task1c()
            {
                // упаковка и распаковка 
                int A = 1;
                Console.WriteLine(A + " - первоначальная переменная");
                object B = A;
                Console.WriteLine(B + " - упаковываем нашу переменную с помощью неявного преобразования");
                int С = (int)B;
                Console.WriteLine(С + " - распаковываем переменную с помощью явного приведения типа");
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }

            void Task1df()
            {
                //с неявно типизированной переменной.
                var implicitlyTypedVariable = "Hello world!";
                Console.WriteLine(implicitlyTypedVariable);

                //Ошибка CS0029  Не удается неявно преобразовать тип "string" в "int".ConsoleApp1
                var VAR1 = 1;
                //VAR1 = "h";
                Console.WriteLine(VAR1);
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }




            void Task1e()
            {
                // Объявляем Nullable переменную типа int
                int? nullableInt = null;

                // Проверяем, есть ли значение
                if (nullableInt.HasValue)
                {
                    Console.WriteLine("Значение nullableInt: " + nullableInt.Value);
                }
                else
                {
                    Console.WriteLine("nullableInt не имеет значения.");
                }

                // Присваиваем значение Nullable переменной
                nullableInt = 42;

                if (nullableInt.HasValue)
                {
                    Console.WriteLine("Значение nullableInt: " + nullableInt.Value);
                }
                else
                {
                    Console.WriteLine("nullableInt не имеет значения.");
                }

                // Используем оператор условного null (null-условный оператор)

                int? anotherNullableInt = null;
                int result = anotherNullableInt ?? 10;
                Console.WriteLine("Значение result: " + result);

                anotherNullableInt = 99;
                result = anotherNullableInt ?? 10;
                Console.WriteLine("Значение result: " + result);
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }



            void Task2a()
            {
                string STRING1 = "Hellow World!";
                string STRING2 = "Hellow World";

                if (STRING1 == STRING2)
                {
                    Console.WriteLine(true);
                }
                else
                    Console.WriteLine(false);
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }

            void Task2b()
            {
                string STRING3 = "I love you!";
                string str = "hellow ";
                string str1 = "world!";
                Console.WriteLine($" сцепление строк: {str + str1}");

                string copiedString = String.Copy(str1);
                Console.WriteLine(" копирование строки: " + copiedString);

                string substr = str1.Substring(0, 4);
                Console.WriteLine(" выделение первых символов : " + substr);

                string[] words = STRING3.Split(' ');
                foreach (string word in words)
                {
                    Console.WriteLine(word);
                }

                string insertStr = str.Insert(1, "    Affff    ");
                Console.WriteLine("вставка подстроки в заданную позицию: " + insertStr);

                string delStr = STRING3.Replace("you", "");
                Console.WriteLine("удаление заданной подстроки:" + delStr);

                string name = "Alice";
                int age = 30;
                string interpolatedStr = $" Привет, меня зовут {name} мне {age} лет ";
                Console.WriteLine(interpolatedStr);
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }
            void Task2c()
            {
                string s1 = "abcd";
                string s2 = "";
                string s3 = null;

                Console.WriteLine("String s1 {0}.", Proverka(s1));
                Console.WriteLine("String s2 {0}.", Proverka(s2));
                Console.WriteLine("String s3 {0}.", Proverka(s3));

                string Proverka(string s)
                {
                    if (String.IsNullOrEmpty(s))
                        return "является нулевым или пустым";
                    else
                        return String.Format("(\"{0}\") не является ни нулевым, ни пустым", s);
                }
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }
            void Task2d()
            {
                StringBuilder str = new StringBuilder("1234", 4);
                Console.WriteLine(" исходник: " + str);
                str.Append(str.ToString(0, 3));
                Console.WriteLine(" добавление " + str);
                str.Replace("1", "aaa");
                Console.WriteLine(" новые символы в начало: " + str);
                str.Replace("4", "aaa");
                Console.WriteLine(" новые символы в конец: " + str);
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }
            void Task3a()
            {
                int[,] matrix = { { 1, 2, 3, }, { 4, 5, 6, }, { 5, 6, 7, } };
                int rows = matrix.GetLength(0);
                int cols = matrix.GetLength(1);
                Console.WriteLine(" матрица: ");
                for (int i = 0; i < rows; i++)
                {
                    for (int j = 0; j < cols; j++)
                    {
                        Console.Write(matrix[i, j] + "\t");
                    }
                    Console.WriteLine();
                }
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }
            void Task3b()
            {
                string[] array = new string[] { "qwerty", " 1234qw", " 12qw12we", };
                var mass = string.Join(",", array);
                var size = array.Length;
                Console.WriteLine(mass + "; размер массива: " + size);
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }
            void Task3c()
            {
                // Инициализация ступенчатого массива
                double[][] myArray = new double[3][];
                myArray[0] = new double[2];
                myArray[1] = new double[3];
                myArray[2] = new double[4];

                // Ввод элементов массива пользователем
                for (int i = 0; i < myArray.Length; i++)
                {
                    for (int j = 0; j < myArray[i].Length; j++)
                    {
                        Console.Write($"Ввод ({i}, {j}): ");
                        myArray[i][j] = Convert.ToDouble(Console.ReadLine());
                    }
                }

                Console.WriteLine();

                // Вывод массива на консоль
                for (int i = 0; i < myArray.Length; i++)
                {
                    for (int j = 0; j < myArray[i].Length; j++)
                    {
                        Console.Write($"{myArray[i][j]} ");
                    }
                    Console.WriteLine();
                }
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }
            void Task3d()
            {
                int[] array2 = { 1, 2, 3, 4, 5, 6 };
                var ewe = "qwetreew";
                Console.WriteLine(ewe + array2);
            }
            void Task4abcd()
            {
                (int, string, char, string, ulong) k1 = (4, "131", 'a', "2121", 11);
                Console.WriteLine($" выведем кортеж целиком: {k1}");
                Console.WriteLine($" выведем элементы 1, 3, 4: {k1.Item1}, {k1.Item3}, {k1.Item4}");
                int i = k1.Item1;
                string b = k1.Item2;
                char c = k1.Item3;
                string d = k1.Item4;
                ulong s = k1.Item5;
                Console.WriteLine($" bcds : {b}, {c}, {d}, {s}");
                var (x, y, z, _, w) = k1;
                Console.WriteLine($" элемент 3: {z}");
                (int a, byte b) left = (5, 10);
                (long a, int b) right = (5, 10);
                Console.WriteLine(left == right);  // output: True
                Console.WriteLine(left != right);  // output: False
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }
            void Task5()
            {
                int[] numbers = { 10, 5, 20, 8, 15 };
                string inputString = "Hello, world!";

                // Локальная функция, которая выполняет необходимые операции
                (int max, int min, int sum, char firstChar) result = CalculateInfo(numbers, inputString);

                Console.WriteLine($"Максимальный элемент: {result.max}");
                Console.WriteLine($"Минимальный элемент: {result.min}");
                Console.WriteLine($"Сумма элементов: {result.sum}");
                Console.WriteLine($"Первая буква строки: {result.firstChar}");
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }

            // Локальная функция для вычисления информации
            (int max, int min, int sum, char firstChar) CalculateInfo(int[] arr, string str)
            {
                if (arr.Length == 0)
                    throw new ArgumentException("Массив не должен быть пустым.");

                int max = arr[0];
                int min = arr[0];
                int sum = 0;
                char firstChar = str.Length > 0 ? str[0] : '\0';

                foreach (var num in arr)
                {
                    if (num > max)
                        max = num;

                    if (num < min)
                        min = num;

                    sum += num;
                }

                return (max, min, sum, firstChar);

            }

            void Task6()
            {

                void Checked()
                {
                    try
                    {
                        checked
                        {
                            int MaxValue = int.MaxValue;
                            Console.WriteLine($" максимальное значение = {MaxValue}");
                            MaxValue++;
                            Console.WriteLine($" увеличенное на 1 = {MaxValue}");
                        }
                    }
                    catch (OverflowException ex)
                    {
                        Console.WriteLine($"Переполнение обнаружено (checked): {ex.Message}");
                    };
                }


                void Unchecked()
                {
                    unchecked
                    {
                        int MaxValue = int.MaxValue;
                        Console.WriteLine($" максимальное значение = {MaxValue}");
                        MaxValue++;
                        Console.WriteLine($" увеличенное на 1, без проверки = {MaxValue}");
                    }
                }

                Checked();
                Unchecked();
                Console.WriteLine(" для вовзрата в меню нажмите Escape!");
                while (Console.ReadKey().Key != ConsoleKey.Escape) ;
                Console.Clear();
            }
        }


    }
}