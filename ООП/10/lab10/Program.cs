using System;
using System.Collections.Generic;
using System.Linq;

// Определение пользовательских классов
public class CustomClass
{
    public int Id { get; set; }
    public string Name { get; set; }
    public double Value { get; set; }
}

public class Vector
{
    public int[] Components { get; set; }

    // Вычисление модуля вектора
    public double Magnitude => Math.Sqrt(Components.Sum(x => x * x));

    public int Length => Components.Length;

    // Проверка наличия значения в векторе
    public bool Contains(int value) => Components.Contains(value);

    // Проверка наличия отрицательных компонентов в векторе
    public bool ContainsNegative() => Components.Any(x => x < 0);

    // Проверка, что все компоненты вектора положительны
    public bool AllPositive() => Components.All(x => x > 0);
}

class Program
{
    static void Main()
    {
        // Массив строк с названиями месяцев
        string[] months = { "June", "July", "May", "December", "January", "August", "March", "April", "October", "November", "September", "February" };

        int n = 7;
        // Выбор месяцев с длиной строки равной n
        var monthsWithLengthN = months.Where(month => month.Length == n);
        Console.WriteLine("Месяцы с длиной строки равной " + n + ": " + string.Join(", ", monthsWithLengthN));

        // Выбор летних и зимних месяцев
        var summerAndWinterMonths = months.Where(month => month == "June" || month == "July" || month == "December" || month == "January" || month == "February");
        Console.WriteLine("Летние и зимние месяцы: " + string.Join(", ", summerAndWinterMonths));

        // Сортировка месяцев в алфавитном порядке
        var monthsInAlphabeticalOrder = months.OrderBy(month => month);
        Console.WriteLine("Месяцы в алфавитном порядке: " + string.Join(", ", monthsInAlphabeticalOrder));

        // Подсчет месяцев, содержащих букву 'u' и длиной не менее 4 символов
        var monthsWithU = months.Where(month => month.Contains("u") && month.Length >= 4).Count();
        Console.WriteLine("Количество месяцев, содержащих букву 'u' и длиной не менее 4-х: " + monthsWithU);

        // Создание коллекции List<T> с использованием класса из Лабораторной работы №2
        List<CustomClass> customCollection = new List<CustomClass>
        {
            new CustomClass { Id = 1, Name = "Item1", Value = 10.5 },
            new CustomClass { Id = 2, Name = "Item2", Value = 20.3 },
        };

        //  запросы по варианту
        List<Vector> vectors = new List<Vector>
        {
            new Vector { Components = new[] { 1, 2, 3 } },
            new Vector { Components = new[] { -1, 0, 1 } },
            new Vector { Components = new[] { 3, 4, 5 } },
        };

        // Подсчет векторов, содержащих 0
        var vectorsWithZero = vectors.Count(vector => vector.Contains(0));
        Console.WriteLine($"Количество векторов, содержащих 0: {vectorsWithZero}");

        // Выбор векторов с наименьшим модулем
        var minMagnitudeVectors = vectors.OrderBy(vector => vector.Magnitude).TakeWhile(vector => vector.Magnitude == vectors.Min(v => v.Magnitude)).ToList();
        Console.WriteLine($"Список векторов с наименьшим модулем: {string.Join(", ", minMagnitudeVectors.Select(v => $"[{string.Join(", ", v.Components)}]"))}");

        int[] lengths = { 3, 5, 7 };
        // Выбор векторов определенной длины
        var specificLengthVectors = vectors.Where(vector => lengths.Contains(vector.Length)).ToArray();
        Console.WriteLine($"Массив векторов длины 3, 5, 7: {string.Join(", ", specificLengthVectors.Select(v => $"[{string.Join(", ", v.Components)}]"))}");

        // Выбор максимального вектора
        var maxVector = vectors.OrderBy(vector => vector.Magnitude).FirstOrDefault();
        Console.WriteLine($"Максимальный вектор: [{string.Join(", ", maxVector.Components)}]");

        // Выбор первого вектора с отрицательным значением
        var firstNegativeVector = vectors.FirstOrDefault(vector => vector.ContainsNegative());
        Console.WriteLine($"Первый вектор с отрицательным значением: [{string.Join(", ", firstNegativeVector.Components)}]");

        // Упорядочивание векторов по размеру
        var orderedVectors = vectors.OrderBy(vector => vector.Length).ToList();
        Console.WriteLine($"Упорядоченный список векторов по размеру: {string.Join(", ", orderedVectors.Select(v => $"[{string.Join(", ", v.Components)}]"))}");

        // Свой собственный запрос: Среднее значение модуля векторов с положительными значениями
        var averageMagnitude = vectors.Where(vector => vector.AllPositive()).Average(vector => vector.Magnitude);
        Console.WriteLine($"Среднее значение модуля векторов с положительными значениями: {averageMagnitude}");

        // Запрос с оператором Join: Соединение коллекций vectors и customCollection по условию
        var joinedCollection = from vector in vectors
                               join item in customCollection on vector.Length equals item.Id
                               select new { Vector = vector, ItemName = item.Name };

        Console.WriteLine("Результат соединения:");
        foreach (var resultItem in joinedCollection)
        {
            Console.WriteLine($"Vector: [{string.Join(", ", resultItem.Vector.Components)}], ItemName: {resultItem.ItemName}");
        }
    }
}
