# Web Cryptography Backend

## Endpoint

### `/encrypt`

Menerima POST request dengan parameter berikut:
 - `cipher`. Pilihan cipher yang digunakan. Value antara `"PLAYFAIR", "HILL", "VIGENERE", "VIGENERE_EXTEND", "AUTOKEY_VIGENERE", "AFFINE"`
 - `data`. Data yang dienkrip.
 - `key`. Key yang digunakan untuk mengenkripsi.

Response berbentuk JSON sebagai berikut

```
# Ketika sukses
{
    "data": [Berisi data yang telah dienkripsi],
    "message": [Status message]
}

# Ketika gagal
{
    "message": "Alasan gagal"
}
```

## `/decrypt`

Menerima POST request dengan parameter berikut:
 - `cipher`. Pilihan cipher yang digunakan. Value antara `"PLAYFAIR", "HILL", "VIGENERE", "VIGENERE_EXTEND", "AUTOKEY_VIGENERE", "AFFINE"`
 - `data`. Data yang didekrip.
 - `key`. Key yang digunakan saat mengenkripsi.

## Contoh Request

### Enkripsi menggunakan `curl`

```console
alifyasa@alifyasa:~$ curl -X POST 127.0.0.1:3000/encrypt -d '{ "cipher": "hill", "data": "muhammadalifputrayasa", "key":"GYBNQKURP" }
' -s -H "Content-Type: application/json" | jq
{
  "data": "EZFGGONWEKJKCPGKKNACY",
  "message": "Success"
}
```

### Deksripsi menggunakan `curl`

```console
alifyasa@alifyasa:~$ curl -X POST 127.0.0.1:3000/decrypt -d '{ "cipher": "hill", "data": "EZFGGONWEKJKCPGKKNACY", "key":"GYBNQKURP" }
' -s -H "Content-Type: application/json" | jq
{
  "data": "MUHAMMADALIFPUTRAYASA",
  "message": "Success"
}
```