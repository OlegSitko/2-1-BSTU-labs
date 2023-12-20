using System;

namespace _8laba
{
    class Str
    {
        // Метод, преобразующий строку в нижний регистр и выводящий результат в консоль
        public static void Low(string str)
        {
            Console.WriteLine(str.ToLower());
        }

        // Метод, добавляющий символ к строке и выводящий результат в консоль
        public static void Add(string str, char let)
        {
            Console.WriteLine(str += let);
        }

        // Метод, преобразующий строку в верхний регистр и возвращающий результат
        public static string Up(string str)
        {
            return str.ToUpper();
        }

        // Метод, заменяющий символ 'a' на 'q' в строке и выводящий результат в консоль
        public static void Change(string str)
        {
            Console.WriteLine(str.Replace("a", "q"));
        }

        // Метод, удаляющий пробелы из строки и выводящий результат в консоль
        public static void Del(string str)
        {
            Console.WriteLine(str.Replace(" ", ""));
        }
    }
}
