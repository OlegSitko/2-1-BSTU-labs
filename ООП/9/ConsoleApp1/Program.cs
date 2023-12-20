using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;

// Класс "Автомобиль"
public class Car
{
    // Свойства автомобиля
    public string Model { get; set; }
    public string Manufacturer { get; set; }
    public int Year { get; set; }

    // Конструктор класса
    public Car(string model, string manufacturer, int year)
    {
        Model = model;
        Manufacturer = manufacturer;
        Year = year;
    }

    // Метод для вывода информации о автомобиле
    public void DisplayInfo()
    {
        Console.WriteLine($"{Year} {Manufacturer} {Model}");
    }
}

// Класс, реализующий интерфейс IList<T> и использующий коллекцию Dictionary<TKey, TValue>
public class CarCollection : IList<Car>
{
    private Dictionary<string, Car> carsDictionary;

    public CarCollection()
    {
        carsDictionary = new Dictionary<string, Car>();
    }

    // Реализация методов интерфейса IList<T>
    public int IndexOf(Car item)
    {
        // В данном случае индекс будет равен названию модели автомобиля
        return carsDictionary.ContainsKey(item.Model) ? 0 : -1;
    }

    public void Insert(int index, Car item)
    {
        carsDictionary[item.Model] = item;
    }

    public void RemoveAt(int index)
    {
        // Удаление элемента по индексу
        if (carsDictionary.Count > 0)
        {
            var key = carsDictionary.Keys.First();
            carsDictionary.Remove(key);
        }
    }

    public Car this[int index]
    {
        get
        {
            if (carsDictionary.Count > 0)
            {
                var key = carsDictionary.Keys.First();
                return carsDictionary[key];
            }

            return null;
        }
        set
        {
            carsDictionary[value.Model] = value;
        }
    }

    public void Add(Car item)
    {
        carsDictionary[item.Model] = item;
    }

    public void Clear()
    {
        carsDictionary.Clear();
    }

    public bool Contains(Car item)
    {
        // Проверка наличия элемента в коллекции
        return carsDictionary.ContainsKey(item.Model);
    }

    public void CopyTo(Car[] array, int arrayIndex)
    {
        carsDictionary.Values.CopyTo(array, arrayIndex);
    }

    public int Count
    {
        get { return carsDictionary.Count; }
    }

    public bool IsReadOnly
    {
        get { return false; }
    }

    public bool Remove(Car item)
    {
        return carsDictionary.Remove(item.Model);
    }

    public IEnumerator<Car> GetEnumerator()
    {
        // Возвращение перечислителя коллекции
        return carsDictionary.Values.GetEnumerator();
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        // Возвращение перечислителя коллекции
        return carsDictionary.Values.GetEnumerator();
    }
}

class Program
{
    static void Main()
    {
        var carCollection = new CarCollection();

        // Добавляем несколько автомобилей
        carCollection.Add(new Car("Civic", "Honda", 2022));
        carCollection.Add(new Car("Accord", "Honda", 2023));
        carCollection.Add(new Car("Camry", "Toyota", 2022));

        // Выводим информацию о каждом автомобиле
        Console.WriteLine("Автомобили в коллекции:");
        foreach (var car in carCollection)
        {
            car.DisplayInfo();
        }

        // Поиск автомобиля по модели
        string searchModel = "Accord";
        var foundCar = carCollection.FirstOrDefault(c => c.Model == searchModel);
        if (foundCar != null)
        {
            Console.WriteLine($"\nНайден автомобиль по модели {searchModel}:");
            foundCar.DisplayInfo();
        }
        else
        {
            Console.WriteLine($"\nАвтомобиль по модели {searchModel} не найден.");
        }

        // Удаление первого автомобиля из коллекции
        carCollection.RemoveAt(0);

        // Выводим информацию о каждом автомобиле после удаления
        Console.WriteLine("\nАвтомобили в коллекции после удаления:");
        foreach (var car in carCollection)
        {
            car.DisplayInfo();
        }
        // a. Создание и заполнение коллекции
        List<int> firstCollection = Enumerable.Range(1, 10).ToList();
        Console.WriteLine("a. Первая коллекция:");
        DisplayCollection(firstCollection);

        // b. Удаление n последовательных элементов
        int n = 3;
        firstCollection.RemoveRange(0, n);
        Console.WriteLine($"\nb. Удаление {n} последовательных элементов:");
        DisplayCollection(firstCollection);

        // c. Добавление других элементов
        firstCollection.Insert(2, 99);
        firstCollection.Add(42);
        Console.WriteLine("\nc. Добавление других элементов:");
        DisplayCollection(firstCollection);

        // d. Создание второй коллекции и заполнение данными из первой
        Dictionary<int, int> secondCollection = new Dictionary<int, int>();
        int key = 1;
        foreach (var item in firstCollection)
        {
            secondCollection[key++] = item;
        }
        Console.WriteLine("\nd. Вторая коллекция (Dictionary):");
        DisplayDictionary(secondCollection);

        // e. Вывод второй коллекции
        Console.WriteLine("\ne. Вторая коллекция после заполнения:");
        DisplayDictionary(secondCollection);

        // f. Найти заданное значение во второй коллекции
        int searchValue = 42;
        var foundItem = secondCollection.FirstOrDefault(kv => kv.Value == searchValue);
        Console.WriteLine($"\nf. Найти значение {searchValue} во второй коллекции:");
        if (foundItem.Key != 0)
        {
            Console.WriteLine($"Значение {searchValue} найдено с ключом {foundItem.Key}.");
        }
        else
        {
            Console.WriteLine($"Значение {searchValue} не найдено во второй коллекции.");
        }

        // 3. Создание объекта наблюдаемой коллекции
        ObservableCollection<string> observableCollection = new ObservableCollection<string>();

        // Регистрация метода на событие CollectionChanged
        observableCollection.CollectionChanged += OnCollectionChanged;

        // Демонстрация добавления и удаления элементов
        Console.WriteLine("\nДемонстрация наблюдаемой коллекции:");
        observableCollection.Add("Item 1");
        observableCollection.Add("Item 2");
        observableCollection.Add("Item 3");
        observableCollection.Remove("Item 2");
    }

    // Метод для вывода элементов коллекции на консоль (для List<T>)
    static void DisplayCollection<T>(List<T> collection)
    {
        foreach (var item in collection)
        {
            Console.Write($"{item} ");
        }
        Console.WriteLine();
    }

    // Метод для вывода элементов коллекции на консоль (для Dictionary<TKey, TValue>)
    static void DisplayDictionary<TKey, TValue>(Dictionary<TKey, TValue> collection)
    {
        foreach (var item in collection)
        {
            Console.WriteLine($"Key: {item.Key}, Value: {item.Value}");
        }
    }

    // Обработчик события CollectionChanged
    static void OnCollectionChanged(object sender, System.Collections.Specialized.NotifyCollectionChangedEventArgs e)
    {
        Console.WriteLine("Событие CollectionChanged:");
        if (e.NewItems != null)
        {
            Console.WriteLine("Добавлены элементы:");
            foreach (var newItem in e.NewItems)
            {
                Console.WriteLine(newItem);
            }
        }

        if (e.OldItems != null)
        {
            Console.WriteLine("Удалены элементы:");
            foreach (var oldItem in e.OldItems)
            {
                Console.WriteLine(oldItem);
            }
        }
    }
}
