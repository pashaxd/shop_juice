# Juice Shop - Мобильное приложение для магазина 

## Описание
Мобильное приложение для магазина, разработанное с использованием Flutter. Приложение предоставляет пользователям возможность просматривать каталог и добавлять товары в корзину.

## Архитектура
Приложение построено с использованием чистой архитектуры (Clean Architecture) и следует принципам SOLID. Основные слои:

### 1. Presentation Layer
- **Widgets**: UI компоненты приложения
- **Screens**: Основные экраны приложения
- **Bloc**: Бизнес-логика

### 2. Data Layer
- **Service**: Реализация репозиториев
- **Models**: Модели данных

## Технологии
- **Flutter**: Фреймворк для разработки кроссплатформенных приложений
- **Dart**: Язык программирования
- **GetIt**: Dependency Injection
- **Sqflite**: Локальное хранение данных
- **Dio**: HTTP клиент для работы с API
- **Flutter Bloc**: Управление состоянием
- **Connectivity Plus**: Проверка состояния сети
- **Carousel slider**: Слайдер фотографий в доп инфе о продукте

## Требования
- Flutter SDK: 3.19.0 или выше
- Dart SDK: 3.3.0 или выше
- Android Studio / VS Code
- Git

## Установка и запуск

1. Клонируйте репозиторий:
```bash
git clone https://github.com/pashaxd
cd shop_juice
```

2. Установите зависимости:
```bash
flutter pub get
```

3. Запустите приложение:
```bash
flutter run
```

## Структура проекта
```
lib/
├── core/
│   ├── di
├── features/
│   ├── cart_feature/
│   ├── catalog_feature/
├── utils
│   ├── config
│   ├── constants
│   ├── snackbar
└── main.dart
```

