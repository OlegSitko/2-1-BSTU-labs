using System;

class Program
{
    static void Main()
    {
        OneDimensionalArray array1 = new OneDimensionalArray(new int[] { 1, 2, 3, 4, 5 });
        OneDimensionalArray array2 = new OneDimensionalArray(new int[] { 2, 3, 4, 5, 6 });

        OneDimensionalArray array3 = array1 * array2;
        Console.WriteLine("Результат умножения:");
        for (int i = 0; i < array3[0]; i++)
        {
            Console.Write(array3[i] + " ");
        }
        Console.WriteLine();

        Console.WriteLine("Массив 1 не содержит отрицательных элементов:  " + (OneDimensionalArray.HasNegativeElements(array1) ? "No" : "Yes"));
        Console.WriteLine("Массив 2 не содержит отрицательных элементов: " + (OneDimensionalArray.HasNegativeElements(array2) ? "No" : "Yes"));

        Console.WriteLine("Размер массива 1: " + array1.Length);
        Console.WriteLine("Размер массива 2: " + array2.Length);


        Console.WriteLine("Массив 1 равен массиву 2: " + (array1 == array2));
        Console.WriteLine("Массив 1 меньше массива 2: " + (array1 < array2));
        Console.WriteLine("Размер массива 1:" + array1.Length); // Предполагается, что у вас есть свойство Length в классе OneDimensionalArray
        Console.WriteLine("Размер массива 2: " + array2.Length);

        // Testing nested classes
        OneDimensionalArray.Production production = new OneDimensionalArray.Production { Id = 1, OrganizationName = "ABC Corp" };
        OneDimensionalArray.Developer developer = new OneDimensionalArray.Developer { FullName = "John Doe", Id = 101, Department = "Engineering" };

        // Testing statistic methods
        Console.WriteLine("Сумма массива 1: " + StatisticOperation.Sum(array1));
        Console.WriteLine("Разница между max и min в массиве 2: " + StatisticOperation.Difference(array2));
        Console.WriteLine("Количество элементов в массиве 1: " + StatisticOperation.CountElements(array1));

        // Testing extensions
        string testString = "Hello, world!";
        Console.WriteLine("Содержит ли строка 'o'? " + testString.ContainsCharacter('o'));

        OneDimensionalArray array4 = new OneDimensionalArray(new int[] { -1, 2, -3, 4, -5 });
        Console.WriteLine("Массив перед удалением негативов:");
        for (int i = 0; i < array4[0]; i++)
        {
            Console.Write(array4[i] + " ");
        }
        Console.WriteLine();

        array4 = array4.RemoveNegatives();
        Console.WriteLine("Массив после удаления негативов:");
        for (int i = 0; i < array4[0]; i++)
        {
            Console.Write(array4[i] + " ");
        }
        Console.WriteLine();
    }
}
