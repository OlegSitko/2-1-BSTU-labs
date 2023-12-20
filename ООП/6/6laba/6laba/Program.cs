using System;

namespace _6laba
{
    class Program
    {
        static void Main(string[] args)
        {
            // Создание объектов различных мебельных предметов
            Hanger MyHanger = new Hanger("Вешалка", 124, "Пластик");
            Sofa MySofa = new Sofa("Драгоценный диван", 578, "Двухместный", "Красный", "Кожа", 4);
            Bed MyBed = new Bed("Уютная кровать", 541, "Двухместная", "Светлая яблоня", "Дерево", 2);
            Cupboard MyCupboard = new Cupboard("Вместительная тумбочка", 174, "Метровая", "Тёмный дуб", "дерево", 2);
            Chair MyChair = new Chair("Удобный стул", 99, 2, true, "Дерево", "Светлая яблоня", "одноместный");

            // Вывод информации о каждом предмете мебели
            Console.WriteLine($"{MyHanger}\n{MySofa}\n{MyBed}\n{MyCupboard}\n{MyChair}");

            // Создание обычных объектов Furniture и проверка, что они также могут быть использованы как объекты классов-наследников
            Furniture tovar = new Furniture("Предмет", 145, "Чёрный", "Двухместный", "Кожа");
            Furniture tovar2 = new Furniture("Предмет", 145, "Чёрный", "Двухместный", "Кожа");

            // Приведение объекта MySofa к Furniture и проверка на null
            Furniture? furniture = MySofa as Furniture;
            if (MySofa == null)
            {
                Console.WriteLine("FAIL");
            }
            else
            {
                Console.WriteLine(MySofa.NumPpl);
            }

            // Приведение объекта tovar к Sofa и проверка на null
            if (tovar is Sofa sofa)
            {
                Console.WriteLine("FAIL");
            }
            else
            {
                Console.WriteLine(MySofa.NumPpl);
            }

            // Вызов методов с одинаковым именем из класса и интерфейса
            theSameNameMethods cust = new theSameNameMethods();
            cust.boxName();                     // Метод из класса
            ((InterfaceMethods)cust).boxName(); // Метод из интерфейса

            // Создание массива объектов типа Tovar и их вывод через Printer
            Tovar[] ArrObj = new Tovar[2];
            var fur = new Furniture("Фурнитура", 145, "белый", "одноместный", "Кожа");
            var hanger = new Hanger("Вешалка", 14, "Дерево");
            ArrObj[0] = fur;
            ArrObj[1] = hanger;
            var printer = new Printer();
            Printer.IAmPrinting(ArrObj[0]);
            Printer.IAmPrinting(ArrObj[1]);

            // 5laba
            Console.WriteLine();
            Console.WriteLine();
            Console.WriteLine();

            //struct
            // Создание объекта Customer и вызов метода PrintInfoStr
            Bed.Customer cst = new Bed.Customer("Олежа", 1, "20.11.2022");
            cst.PrintInfoStr();

            // Создание объекта skladTovarov и выполнение различных операций с ним
            Console.WriteLine();
            Sklad skladTovarov = new Sklad("test", MyBed, MySofa, MyCupboard, MyBed);
            skladTovarov.AddTovar(MyChair);
            Console.WriteLine();
            Controller.SearchMaterial(skladTovarov, "Кожа");
            skladTovarov.GetInfo();
            Console.WriteLine();
            Controller.SortByMoney(skladTovarov);
            skladTovarov.GetInfo();
            Console.WriteLine("\nИтого стоимость:");
            int sum = Controller.SumPrice(skladTovarov);
            Console.WriteLine(sum);

            // 6laba
            Furniture TestTovar = new Furniture("Предмет", 145, "прозрачный", "Двухместный", "Кожа");
            Chair TestChair = new Chair("Удобный стул", 52, -1, null, "Дерево", "Светлая яблоня", "одноместный");

            // Проверка на возможность изменения свойства Color на "прозрачный"
            try
            {
                TestTovar.Color = "прозрачный";
            }
            catch (Exeptions.TovarArgExc er)
            {
                Console.WriteLine("Неверный цвет " + er);
                Console.WriteLine(er.Message);
            }
            Console.WriteLine();

            // Проверка на возможность изменения свойства Arms на 0
            try
            {
                TestChair.Arms = 0;
            }
            catch (Exeptions.TovarLessThenZero er)
            {
                Console.WriteLine("Неверное значение " + er);
                Console.WriteLine(er.Message);
            }
            Console.WriteLine();

            // Проверка на возможность изменения свойства Bottom на null
            try
            {
                TestChair.Bottom = null;
            }
            catch (NullReferenceException er)
            {
                Console.WriteLine("Значение=null " + er);
                Console.WriteLine(er.Message);
            }
            Console.WriteLine();

            // Проверка на возможность деления на 0
            try
            {
                TestChair.Price = 0;
                int a = TestChair.Arms / TestChair.Price;
            }
            catch (DivideByZeroException er)
            {
                Console.WriteLine("деление на 0 " + er);
                Console.WriteLine(er);
            }
            Console.WriteLine();

            // Проверка на возможность выхода за границы массива
            try
            {
                int[] a = new int[2];
                a[3] = 5;
            }
            catch (IndexOutOfRangeException er)
            {
                Console.WriteLine("выход за диапазон " + er);
                Console.WriteLine(er);
            }
            Console.WriteLine();

            // Универсальный обработчик catch с использованием checked
            try
            {
                checked
                {
                    int a = Int32.MaxValue;
                    a++;
                }
            }
            catch (OverflowException ex)
            {
                Console.WriteLine("какая-то ошибка");
                Console.WriteLine(ex);
            }
            Console.WriteLine();

            // try-catch-finally
            try
            {
                TestChair.Price = 0;
                int a = TestChair.Arms * TestChair.Price;
            }
            catch (DivideByZeroException er)
            {
                Console.WriteLine("деление на 0 " + er);
                Console.WriteLine(er);
            }
            finally
            {
                Console.WriteLine("БЛОК FINALLY");
            }
            Console.WriteLine();

            // Продемонстрируйте возможность многоразовой обработки одного исключения и проброс его выше по стеку вызовов
            try
            {
                try
                {
                    int[] a = new int[2];
                    a[3] = 5;
                }
                catch (Exception er)
                {
                    Console.WriteLine("ВНУТРЕННИЙ БЛОК");
                    Console.WriteLine(er);
                    throw;
                }
                checked
                {
                    int a = Int32.MaxValue;
                    a++;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("ВНЕШНИЙ БЛОК");
                Console.WriteLine(ex);
            }
            Console.WriteLine();

            // assert
            Furniture.MyMethod("пластик");
        }
    }
}
