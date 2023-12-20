using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Text;

namespace _11laba
{ 
    // 1
    static class Reflector
    {
        static void Write(string text)
        {
            string path = "output.txt";
            File.AppendAllText(path, text);
        }
        //a
        public static void GetAssemblyName<T>(T obj)
        {
            Assembly a = typeof(T).Assembly;
            Write("Имя сборки, в которой определен класс: " + a.FullName + "\n\n");
            Console.WriteLine("Имя сборки, в которой определен класс: " + a.FullName + "\n");
        }
        //b
        public static void IsPublicConstructors<T>(T obj)
        {
            ConstructorInfo[] constructorInfo = typeof(T).GetConstructors();
            for (int i = 0; i < constructorInfo.Length; i++)
                if ((constructorInfo[i].IsPublic))
                {
                    Console.WriteLine("Класс Worker имеет публичный конструктор " + (i + 1) + "\n");
                    Write("Класс Worker имеет публичный конструктор " + (i + 1) + "\n");
                }
                else
                {
                    Console.WriteLine("Класс Worker не имеет публичного конструктора \n");
                    Write("Класс Worker не имеет публичного конструктора\n");
                }
        }
        //c
        public static void GetAllMethods<T>(T obj)
        {
            MethodInfo[] methodInfo = typeof(T).GetMethods();
            Console.Write($"Извлекает все общедоступные публичные методы класса: \n");
            Write($"\nИзвлекает все общедоступные публичные методы класса: \n");
            foreach (MethodInfo method in methodInfo)
            {
                string modificator = "";
                if (method.IsStatic)
                    modificator += "static ";
                if (method.IsVirtual)
                    modificator += "virtual";
                Console.Write($"{modificator} {method.ReturnType.Name} {method.Name} \n");
                Write($"{modificator} {method.ReturnType.Name} {method.Name} \n");
            }
        }
        //d
        public static void GetFieldsProp<T>(T obj)
        {
            FieldInfo[] fieldInfo = typeof(T).GetFields();
            PropertyInfo[] propertyInfo = typeof(T).GetProperties();
            Console.WriteLine("\nИнформация о полях:");
            Write("\nИнформация о полях:\n");
            foreach (FieldInfo field in fieldInfo)
            {
                Console.WriteLine($"{field.FieldType} {field.Name}");
                Write($"{field.FieldType} {field.Name}\n");
            }

            Console.WriteLine("\nСвойства класса:");
            Write("\nСвойства класса:\n");
            foreach (PropertyInfo prop in propertyInfo)
            {
                Console.WriteLine($"{prop.PropertyType} {prop.Name}\n");
                Write($"{prop.PropertyType} {prop.Name}\n");
            }
        }
        //e
        public static void GetAllInterfaces<T>(T obj)
        {
            Type[] interfacesInfo = typeof(T).GetInterfaces();
            Console.WriteLine("Все реализованные классом интерфейсы:");
            Write("\nВсе реализованные классом интерфейсы:\n");
            foreach (Type i in interfacesInfo)
            {
                Console.WriteLine(i.Name);
                Write(i.Name);
            }
        }
        //f
        public static void GetSpecialMethod<T>(T obj, string type)
        {
            MethodInfo[] methodInfo = typeof(T).GetMethods();
            Console.WriteLine("Выводит по имени класса имена методов, которые содержат заданный пользователем тип параметра:");
            Write("\n\nВыводит по имени класса имена методов, которые содержат заданный пользователем тип параметра:\n");
            foreach (MethodInfo method in methodInfo)
            {
                ParameterInfo[] parameters = method.GetParameters();
                string modificator = "";
                if (method.IsStatic)
                    modificator += "static ";
                if (method.IsVirtual)
                    modificator += "virtual";
                for (int i = 0; i < parameters.Length; i++)
                {
                    if (parameters[i].ParameterType.Name == type)
                    {
                        Console.Write($"{modificator} {method.ReturnType.Name} {method.Name} \n");
                        Write($"{modificator} {method.ReturnType.Name} {method.Name}\n");
                        break;
                    }
                }
            }
        }
        //g
        public static void Invoke<S>(string methodName, string className, S parametrs)
        {
            Assembly asm = Assembly.LoadFrom("11laba.dll");
            Type t = asm.GetType("_11Laba." + className, true, true);

            object obj = Activator.CreateInstance(t);
            MethodInfo method = t.GetMethod(methodName);

            object result = method.Invoke(obj, new object[] { });
            Console.WriteLine(result);
        }

        // 2
        public static object Create(string className)
        {
            Assembly asm = Assembly.LoadFrom("11laba.dll");
            Type t = asm.GetType("_11laba." + className, true, true);

            return Activator.CreateInstance(t);
        }
    }
}
