## Как запускать

1. Установить Dart SDK 2.1
2. Перейти в корень репозитория
3. Запустить

```
cd orel_codes_langbattle_dart_2
pub run start_server.dart [число воркеров = 2 (лучше ставить под количество ядер CPU)]
```

4. Запросы принимаются по адресу `http://localhost:8080/`

Пример запроса:

```
{
 "id": "Rand ID",
 "first_name": "Rand Name",
 "last_name": "Rand Last Name"
}
```

Пример ответа:

```
{
    "id": "Rand ID",
    "first_name": "Rand Name 8e29f97d26fb9c33ac642fadcf435615",
    "last_name": "Rand Last Name 6303ce184a41418f20f330af67d760f8",
    "say": "Dart is beautiful !",
    "current_time": "2018-11-18 14:05:24 +0300"
}
```

## Контест для Orel Codes

Задача:

Написать программу котороая принимает по HTTP Post запрос в JSON и
по полученному JSON'у гененрирует в ответ JSON

Пример Input'а

```javascript
{
 id: 'Rand ID',
 first_name: 'Rand Name',
 last_name: 'Rand Last Name'
}
```

Output:

```javascript
{
 id: 'Input ID'
 first_name: 'first_name + hash_md5(first_name)',
 last_name: 'last Name + hash_md5(last_name)',
 current_time: 'UTC time',
 say: 'Your language is best'
}
```

В ответе должен быть заголовок

Content-Type: application/json

Формат сurrent_time: %F %T %z (2018-11-01 17:35:15 +0300)

## Стек

Dart 2.1
