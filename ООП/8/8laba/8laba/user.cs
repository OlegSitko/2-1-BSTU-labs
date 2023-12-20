using System;
using System.Collections.Generic;
using System.Text;

namespace _8laba
{
    class User
    {
        // Делегат для события, представляющего информационное сообщение
        public delegate void Info(string mes);

        // Событие, которое вызывается при определенных действиях пользователя
        public event Info Say;

        // Конструктор класса, инициализирующий объект пользователя
        public User(int position, string name)
        {
            Position = position;
            Name = name;
        }

        // Свойство, представляющее позицию пользователя
        public int Position { get; set; }

        // Свойство, представляющее имя пользователя
        public string Name { get; set; }

        // Метод, смещающий позицию пользователя и вызывающий событие
        public void Smesh(int smesh)
        {
            Position += smesh;
            // Вызов события с информационным сообщением
            Say?.Invoke($"Смещение на {smesh}. Позиция: {Position}");
        }

        // Метод, сжимающий позицию пользователя и вызывающий событие
        public void Squizee(int squz)
        {
            if (squz >= Position)
            {
                Say?.Invoke("Превратился в 0");
                Position = 0;
            }
            else
            {
                Position /= squz;
                // Вызов события с информационным сообщением
                Say?.Invoke($"Сжался в {squz} раз, итог: {Position}");
            }
        }

        // Переопределение метода ToString для удобного вывода информации о пользователе
        public override string ToString()
        {
            return $"{Name} {Position}";
        }
    }
}
