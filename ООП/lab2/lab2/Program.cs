using lab2;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab2
{
    class Vector
    {
        public int[] elem;
        public int size;
        public bool error;

        // Конструктор без параметров
        public Vector()
        {
            size = 0;
            error = false;
            elem = new int[0];

        }

        // Конструктор с параметрами
        public Vector(int[] elements, int vectorSize, bool hasError)
        {
            elem = elements;
            size = vectorSize;
            error = hasError;
        }

        // Конструктор с параметрами по умолчанию
        //public Vector(int[] elements = null, int vectorSize = 0, bool hasError = false)
        //{
        //    elem = elements ?? new int[0]; // Используем пустой массив, если elements равен null
        //    size = vectorSize;
        //    error = hasError;
        //}
        static Vector()
        {
            int size = 0;
            bool error = false;
            int[] elem = new int[0];
        }
        //определите закрытый конструктор; предложите варианты его вызова;
        private void vectorWithSize(int size)
        {
            elem = new int[size];
            this.size = size;
            error = false;
            Console.WriteLine($"Vector с размером: {size}");

        }
        public void createVector()
        {
            // Создание объекта Vector с размером 5
            vectorWithSize(10);
            // Создание объекта Vector с размером 10
            vectorWithSize(5);
        }

    }
    public class MyClass
    {
        private int privateField1;
        private string privateField2;
        //свойства(get, set)
        public int Property1
        {
            get { return privateField1; }
            set { privateField1 = value; }
        }

        public string Property2
        {
            get { return privateField2; }
            set { privateField2 = value; }
        }

        // Свойство Property3 с ограничением доступа по set
        private int privateField3;
        public int Property3
        {
            get { return privateField3; }
            private set { privateField3 = value; }
        }

        public MyClass(int value1, string value2)
        {
            privateField1 = value1;
            privateField2 = value2;
        }

        public void ModifyFields(ref int valueToModify)
        {
            valueToModify = 100; // Изменение значения переменной, переданной по ссылке (ref)
        }

        public void GetValues(out int value1, out string value2)
        {
            value1 = privateField1;
            value2 = privateField2;
        }
    }
}




internal class Program
    {
        public const int ZERO = 0;
        static void Main(string[] args)
        {
        Vector MyVector = new Vector();
        MyVector.createVector();
        MyVector.size = 100;
        MyVector.error = false;
        MyVector.elem = new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
        Console.WriteLine("" + MyVector.elem[8]);
        Console.WriteLine(MyVector.elem[MyVector.elem.Length - 1]);
        //Console.WriteLine(MyVector.elem[^1]);
        //Console.ReadLine(ZERO); //Ошибка CS1501

        MyClass obj1 = new MyClass(1, "John");
        MyClass obj2 = new MyClass(2, "Jane");

        Console.WriteLine("сравнение объектов: " + obj1.Equals(obj2)); // Сравнение объектов
        Console.WriteLine("Получение хэш-кода: " + obj1.GetHashCode()); // Получение хэш-кода
        Console.WriteLine("информации об объекте: " + obj1.ToString()); //информации об объекте
        // Создание и вывод анонимного типа
        var anonymousObject = new { ID = 1, Name = "Anonymous" };
        Console.WriteLine($"Анонимный объект: ID = {anonymousObject.ID}, Name = {anonymousObject.Name}");

    }
}

