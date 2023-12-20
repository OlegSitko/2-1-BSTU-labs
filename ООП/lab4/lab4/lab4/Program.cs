using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace lab4
{
    internal class Program
    {
        // Интерфейс для клонирования объектов
        public interface ICloneable
        {
            bool DoClone();
        }

        // Абстрактный класс, предоставляющий базовую функциональность
        public abstract class BaseClass
        {
            // Пример одноименного метода в интерфейсе и абстрактном классе
            public abstract bool DoClone();

            // Переопределение метода ToString()
            public override string ToString()
            {
                return $"Тип объекта: {GetType().Name}";
            }
        }

        // Запечатанный (sealed) класс
        public sealed class CConficker : BaseClass, ICloneable
        {
            // Реализация метода DoClone()
            public override bool DoClone()
            {
                // Логика клонирования для CConficker
                return true;
            }

            // Переопределение метода ToString() с уникальными значениями
            public override string ToString()
            {
                return $"{base.ToString()}, Дополнительная информация: CConficker";
            }
        }

        // Пример текстового процессора
        public class TextProcessor : BaseClass
        {
            // Реализация метода DoClone()
            public override bool DoClone()
            {
                // Логика клонирования для TextProcessor
                return true;
            }

            // Переопределение метода ToString() с уникальными значениями
            public override string ToString()
            {
                return $"{base.ToString()}, Дополнительная информация: TextProcessor";
            }
        }

        // Пример игрушки
        public class Toy : BaseClass, ICloneable
        {
            // Реализация метода DoClone()
            public override bool DoClone()
            {
                // Логика клонирования для Toy
                return true;
            }

            // Переопределение метода ToString() с уникальными значениями
            public override string ToString()
            {
                return $"{base.ToString()}, Дополнительная информация: Toy";
            }
        }

        // Класс для демонстрации полиморфизма
        public class Printer
        {
            // Полиморфный метод IAmPrinting
            public void IAmPrinting(BaseClass someObj)
            {
                // Определение типа объекта и вызов метода ToString()
                Console.WriteLine(someObj.ToString());
            }
        }

        static void Main(string[] args)
        {
            // Создание объектов различных классов
            TextProcessor textProcessor = new TextProcessor();
            CConficker cConficker = new CConficker();
            Toy toy = new Toy();

            // Массив ссылок на базовый класс
            BaseClass[] objects = { textProcessor, cConficker, toy };

            // Создание объекта Printer
            Printer printer = new Printer();

            // Вызов метода IAmPrinting для каждого объекта в массиве
            foreach (var obj in objects)
            {
                printer.IAmPrinting(obj);
            }
        }
    }
}
