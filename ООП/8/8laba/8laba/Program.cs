using System;

namespace _8laba
{
    // Делегат, который будет использоваться для событий
    public delegate int Lamb(int a, int b);

    class Program
    {
        static void Main(string[] args)
        {
            // Обработчики событий для вывода цветных сообщений в консоль
            static void DisplayGreenMessage(string message)
            {
                // Устанавливаем зеленый цвет символов
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine(message);
                Console.ResetColor();
            }

            static void DisplayRedMessage(String message)
            {
                // Устанавливаем красный цвет символов
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine(message);
                Console.ResetColor();
            }

            // Создание экземпляров класса User
            User u1 = new User(35, "u1");
            User u2 = new User(120, "u2");
            User u3 = new User(87, "u3");
            User u4 = new User(11, "u4");
            User u5 = new User(97, "u5");

            // Вывод информации о пользователях
            Console.WriteLine(u1.ToString());
            // Подписка на событие и вызов метода, связанного с этим событием
            u1.Say += DisplayGreenMessage;
            u1.Smesh(15);
            // Отписка от события
            u1.Say -= DisplayGreenMessage;
            Console.WriteLine(u1.ToString());
            Console.WriteLine(u2.ToString());

            // Подписка на событие для пользователя u2 и вызов метода, связанного с этим событием
            u2.Say += DisplayGreenMessage;
            u2.Smesh(8);
            // Отписка от события
            u2.Say -= DisplayGreenMessage;
            Console.WriteLine(u2.ToString());
            Console.WriteLine(u3.ToString());

            // Подписка на событие для пользователя u3 и вызов метода, связанного с этим событием
            u3.Say += DisplayGreenMessage;
            u3.Squizee(15);
            // Отписка от события
            u3.Say -= DisplayGreenMessage;
            Console.WriteLine(u3.ToString());

            Console.WriteLine(u4.ToString());
            // Подписка на событие для пользователя u4 и вызов метода, связанного с этим событием
            u4.Say += DisplayRedMessage;
            u4.Smesh(18);
            // Отписка от события
            u4.Say -= DisplayRedMessage;
            Console.WriteLine(u4.ToString());

            Console.WriteLine(u5.ToString());
            // Подписка и отписка от нескольких событий для пользователя u5
            u5.Say += DisplayGreenMessage;
            u5.Smesh(15);
            u5.Say -= DisplayGreenMessage;
            u5.Say += DisplayRedMessage;
            u5.Squizee(10);
            u5.Say -= DisplayRedMessage;
            Console.WriteLine(u5.ToString());

            // Использование лямбда-выражения для сложения позиций пользователей u1 и u2
            Console.WriteLine("сумма позиций 1 и 2");
            Lamb sum = (a, b) => a + b;
            Console.WriteLine(sum(u1.Position, u2.Position));

            // Некоторые операции с использованием делегатов Action и Func
            string test = "asd KJFSdgh,fj JSDFBfzsd dfshza";
            Action<string> Oper1 = Str.Low;
            Action<string, char> Oper2 = Str.Add;
            Func<string, string> Oper3 = Str.Up;
            Oper1(test);
            Oper2(test, '0');
            Console.WriteLine(Oper3(test));
        }
    }
}
