using System;

public partial class MyClass
{
    private int id;
    private string name;

    public MyClass(int id, string name)
    {
        this.id = id;
        this.name = name;
    }

    // Переопределение метода Equals для сравнения объектов
    public override bool Equals(object obj)
    {
        if (obj is MyClass other)
        {
            return this.id == other.id && this.name == other.name;
        }
        return false;
    }

    // Переопределение метода GetHashCode для вычисления хэш-кода
    public override int GetHashCode()
    {
        return id.GetHashCode() ^ name.GetHashCode();
    }

    // Переопределение метода ToString для вывода информации об объекте
    public override string ToString()
    {
        return $"MyClass - ID: {id}, Name: {name}";
    }
}
