## Usage

1. install Dart SDK 2.1
2. move to repository root
3. run

```
cd orel_codes_langbattle_dart_2
pub run start_server.dart [worker count = 2 (It's better to set it according to the number of CPU cores)]
```

4. Server listen request here: `http://localhost:8080/`

Request example:

```
{
 "id": "Rand ID",
 "first_name": "Rand Name",
 "last_name": "Rand Last Name"
}
```

Response example:

```
{
    "id": "Rand ID",
    "first_name": "Rand Name 8e29f97d26fb9c33ac642fadcf435615",
    "last_name": "Rand Last Name 6303ce184a41418f20f330af67d760f8",
    "say": "Dart is beautiful !",
    "current_time": "2018-11-18 14:05:24 +0300"
}
```

## For Orel Codes contest

Target:

Write a program that receives a JSON HTTP POST request and, based on the received JSON, generates a JSON response

Input example

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

Response should contain header:

Content-Type: application/json

Format: сurrent_time: %F %T %z (2018-11-01 17:35:15 +0300)

## Stack

Dart 2.1
