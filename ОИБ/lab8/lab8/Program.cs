using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

public class Program
{
    public static void Main()
    {
        // Ваша фамилия
        string surname = "Авдей";

        // Создание RSA с 2048 битами
        using (var rsa = new RSACryptoServiceProvider(2048))
        {
            // Получение ключей
            var publicKey = rsa.ExportParameters(false);
            var privateKey = rsa.ExportParameters(true);

            // Сохранение ключей в файлы
            File.WriteAllText("publicKey.txt", Convert.ToBase64String(publicKey.Modulus));
            File.WriteAllText("privateKey.txt", Convert.ToBase64String(privateKey.Modulus));

            // Шифрование
            var bytesToEncrypt = Encoding.UTF8.GetBytes(surname);
            var encryptedBytes = rsa.Encrypt(bytesToEncrypt, false);
            var encryptedData = Convert.ToBase64String(encryptedBytes);

            // Сохранение зашифрованных данных в файл
            File.WriteAllText("encryptedData.txt", encryptedData);

            // Дешифрование
            var bytesToDecrypt = Convert.FromBase64String(encryptedData);
            var decryptedBytes = rsa.Decrypt(bytesToDecrypt, false);
            var decryptedData = Encoding.UTF8.GetString(decryptedBytes);

            // Проверка, что дешифрованные данные совпадают с исходными
            Console.WriteLine("Decryption successful: " + (surname == decryptedData));
            Console.WriteLine("Encrypted Data: " + encryptedData);
        }

        // Хеширование SHA512
        using (var sha512 = SHA512.Create())
        {
            var bytes = Encoding.UTF8.GetBytes(surname);
            var hashBytes = sha512.ComputeHash(bytes);
            var hash = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();

            // Сохранение хеша в файл
            File.WriteAllText("hash.txt", hash);

            Console.WriteLine("Hash: " + hash);
        }

        Console.ReadKey();
    }
}
