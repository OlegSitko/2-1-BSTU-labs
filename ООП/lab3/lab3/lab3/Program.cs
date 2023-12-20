using System;
using System.Linq;

public class OneDimensionalArray
{
    internal int[] array;

    public OneDimensionalArray(int size)
    {
        array = new int[size];
    }
    public int Length
    {
        get { return array.Length; }
    }

    public OneDimensionalArray(int[] initialValues)
    {
        array = initialValues;
    }

    public int this[int index]
    {
        get { return array[index]; }
        set { array[index] = value; }
    }
    // Перегруженная операция умножения
    public static OneDimensionalArray operator *(OneDimensionalArray arr1, OneDimensionalArray arr2)
    {
        if (arr1.array.Length != arr2.array.Length)
            throw new InvalidOperationException("Для умножения массивы должны быть одинаковой длины!");

        var result = new OneDimensionalArray(arr1.array.Length);
        for (int i = 0; i < arr1.array.Length; i++)
        {
            result[i] = arr1[i] * arr2[i];
        }
        return result;
    }

    public static bool HasNegativeElements(OneDimensionalArray arr)
    {
        return arr.array.Any(element => element < 0);
    }

    public static int operator !(OneDimensionalArray arr)
    {
        return arr.array.Length;
    }
    // Перегруженная операция проверки на равенство
    public static bool operator ==(OneDimensionalArray arr1, OneDimensionalArray arr2)
    {
        return arr1.array.SequenceEqual(arr2.array);
    }
    // Перегруженная операция проверки на неравенство
    public static bool operator !=(OneDimensionalArray arr1, OneDimensionalArray arr2)
    {
        return !arr1.array.SequenceEqual(arr2.array);
    }
    // Перегруженная операция сравнения (меньше)

    public static bool operator <(OneDimensionalArray arr1, OneDimensionalArray arr2)
    {
        return arr1.array.Length < arr2.array.Length;
    }
    // Перегруженная операция сравнения (больше)

    public static bool operator >(OneDimensionalArray arr1, OneDimensionalArray arr2)
    {
        return arr1.array.Length > arr2.array.Length;
    }

    public class Production
    {
        public int Id { get; set; }
        public string OrganizationName { get; set; }
    }

    public class Developer
    {
        public string FullName { get; set; }
        public int Id { get; set; }
        public string Department { get; set; }
    }
}

public static class StatisticOperation
{
    public static int Sum(OneDimensionalArray array)
    {
        int sum = 0;
        for (int i = 0; i < array.array.Length; i++)
        {
            sum =+ array[i];
        }
        return sum;
    }


    public static int Difference(OneDimensionalArray array)
    {
        return array.array.Max() - array.array.Min();
    }

    public static int CountElements(OneDimensionalArray array)
    {
        return array.array.Length;
    }

}

public static class Extensions
{
    public static bool ContainsCharacter(this string str, char character)
    {
        return str.Contains(character);
    }

    public static OneDimensionalArray RemoveNegatives(this OneDimensionalArray array)
    {
        var positiveArray = array.array.Where(x => x >= 0).ToArray();
        return new OneDimensionalArray(positiveArray);
    }

}
