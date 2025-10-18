// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m1(label) =>
      "Вы уверены, что хотите удалить выбранные ${label}?";

  static String m2(label) => "Вы уверены, что хотите удалить текущий ${label}?";

  static String m3(label) => "${label} не может быть пустым";

  static String m4(label) => "Текущий ${label} уже существует";

  static String m7(label) => "Сейчас ${label} нет";

  static String m8(label) => "${label} должно быть числом";

  static String m9(statusCode) =>
      "Не удалось получить сообщения: ${statusCode}";

  static String m10(error) => "Не удалось выбрать изображения: ${error}";

  static String m11(method) => "Неподдерживаемый HTTP метод: ${method}";

  static String m12(error) => "Загрузка не удалась: ${error}";

  static String m16(label) => "${label} должен быть числом от 1024 до 49151";

  static String m18(count) => "Выбрано ${count} элементов";

  static String m20(date) =>
      "План истёк ${date}, пожалуйста продлите для продолжения использования";

  static String m21(days) =>
      "План истёк через ${days} дней, пожалуйста продлите вовремя";

  static String m22(days) => "Подписка истёк через ${days} дней";

  static String m27(version) => "Текущая версия: ${version}";

  static String m28(version) => "Принудительное обновление: ${version}";

  static String m29(version) => "Найдена новая версия: ${version}";

  static String m30(statusCode) => "Сервер вернул код ошибки ${statusCode}";

  static String m31(label) => "${label} должен быть URL";

  static String m34(time) => "Время работы: ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("О нас"),
    "accessControl": MessageLookupByLibrary.simpleMessage("Контроль доступа"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешить только выбранным приложениям доступ к VPN",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "Настройка доступа приложений к прокси",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Выбранные приложения будут исключены из VPN",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
    "action": MessageLookupByLibrary.simpleMessage("Действие"),
    "action_mode": MessageLookupByLibrary.simpleMessage("Переключить режим"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("Системный прокси"),
    "action_start": MessageLookupByLibrary.simpleMessage("Старт/Стоп"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_view": MessageLookupByLibrary.simpleMessage("Показать/Скрыть"),
    "add": MessageLookupByLibrary.simpleMessage("Добавить"),
    "addRule": MessageLookupByLibrary.simpleMessage("Добавить правило"),
    "addedOriginRules": MessageLookupByLibrary.simpleMessage(
      "Добавить к оригинальным правилам",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Адрес"),
    "addressHelp": MessageLookupByLibrary.simpleMessage("Адрес сервера WebDAV"),
    "addressTip": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите действительный адрес WebDAV",
    ),
    "adminAutoLaunch": MessageLookupByLibrary.simpleMessage(
      "Автозапуск с правами администратора",
    ),
    "adminAutoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запуск с правами администратора при загрузке системы",
    ),
    "ago": MessageLookupByLibrary.simpleMessage(" назад"),
    "agree": MessageLookupByLibrary.simpleMessage("Согласен"),
    "allApps": MessageLookupByLibrary.simpleMessage("Все приложения"),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Разрешить приложениям обходить VPN",
    ),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "Некоторые приложения могут обходить VPN при включении",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("Разрешить LAN"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешить доступ к прокси через локальную сеть",
    ),
    "app": MessageLookupByLibrary.simpleMessage("Приложение"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "Контроль доступа приложений",
    ),
    "appDesc": MessageLookupByLibrary.simpleMessage(
      "Обработка настроек, связанных с приложением",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Приложение"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage(
      "Изменение настроек, связанных с приложением",
    ),
    "auto": MessageLookupByLibrary.simpleMessage("Авто"),
    "autoCheckUpdate": MessageLookupByLibrary.simpleMessage(
      "Автопроверка обновлений",
    ),
    "autoCheckUpdateDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматически проверять обновления при запуске приложения",
    ),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Автоматическое закрытие соединений",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматически закрывать соединения после смены узла",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Автозапуск"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Следовать автозапуску системы",
    ),
    "autoRun": MessageLookupByLibrary.simpleMessage("Автозапуск"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматический запуск при открытии приложения",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Автоматическая настройка системного DNS",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("Автообновление"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал автообновления (минуты)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Резервное копирование"),
    "backupAndRecovery": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование и восстановление",
    ),
    "backupAndRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Синхронизация данных через WebDAV или файл",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование успешно",
    ),
    "basicConfig": MessageLookupByLibrary.simpleMessage("Базовая конфигурация"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Глобальное изменение базовых настроек",
    ),
    "bind": MessageLookupByLibrary.simpleMessage("Привязать"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage(
      "Режим черного списка",
    ),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Обход домена"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Действует только при включенном системном прокси",
    ),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "Кэш поврежден. Хотите очистить его?",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "cancelFilterSystemApp": MessageLookupByLibrary.simpleMessage(
      "Отменить фильтрацию системных приложений",
    ),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage(
      "Отменить выбор всего",
    ),
    "checkError": MessageLookupByLibrary.simpleMessage("Ошибка проверки"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Проверить обновления"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "Текущее приложение уже является последней версией",
    ),
    "checking": MessageLookupByLibrary.simpleMessage("Проверка..."),
    "clearData": MessageLookupByLibrary.simpleMessage("Очистить данные"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage(
      "Экспорт в буфер обмена",
    ),
    "clipboardImport": MessageLookupByLibrary.simpleMessage(
      "Импорт из буфера обмена",
    ),
    "color": MessageLookupByLibrary.simpleMessage("Цвет"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Цветовые схемы"),
    "columns": MessageLookupByLibrary.simpleMessage("Столбцы"),
    "compatible": MessageLookupByLibrary.simpleMessage("Режим совместимости"),
    "compatibleDesc": MessageLookupByLibrary.simpleMessage(
      "Включение приведет к потере части функциональности приложения, но обеспечит полную поддержку Clash.",
    ),
    "configurationError": MessageLookupByLibrary.simpleMessage(
      "Ошибка конфигурации приложения, обратитесь в службу поддержки",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "connections": MessageLookupByLibrary.simpleMessage("Соединения"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Просмотр текущих данных о соединениях",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Связь："),
    "contactMe": MessageLookupByLibrary.simpleMessage("Свяжитесь со мной"),
    "contactSupport": MessageLookupByLibrary.simpleMessage(
      "Связаться с поддержкой",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Содержание"),
    "contentScheme": MessageLookupByLibrary.simpleMessage("Контентная тема"),
    "copy": MessageLookupByLibrary.simpleMessage("Копировать"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage(
      "Копирование переменных окружения",
    ),
    "copyLink": MessageLookupByLibrary.simpleMessage("Копировать ссылку"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("Копирование успешно"),
    "core": MessageLookupByLibrary.simpleMessage("Ядро"),
    "coreInfo": MessageLookupByLibrary.simpleMessage("Информация о ядре"),
    "country": MessageLookupByLibrary.simpleMessage("Страна"),
    "crashTest": MessageLookupByLibrary.simpleMessage("Тест на сбои"),
    "create": MessageLookupByLibrary.simpleMessage("Создать"),
    "cut": MessageLookupByLibrary.simpleMessage("Вырезать"),
    "dark": MessageLookupByLibrary.simpleMessage("Темный"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Панель управления"),
    "days": MessageLookupByLibrary.simpleMessage("Дней"),
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "Сервер имен по умолчанию",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Для разрешения DNS-сервера",
    ),
    "defaultSort": MessageLookupByLibrary.simpleMessage(
      "Сортировка по умолчанию",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("По умолчанию"),
    "delay": MessageLookupByLibrary.simpleMessage("Задержка"),
    "delaySort": MessageLookupByLibrary.simpleMessage("Сортировка по задержке"),
    "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "deleteMultipTip": m1,
    "deleteTip": m2,
    "desc": MessageLookupByLibrary.simpleMessage(
      "Многоплатформенный прокси-клиент на основе ClashMeta, простой и удобный в использовании, с открытым исходным кодом и без рекламы.",
    ),
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Опирается на сторонний API, только для справки",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("Режим разработчика"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Режим разработчика активирован.",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("Прямой"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Важное уведомление"),
    "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
      "Это программное обеспечение находится в стадии открытой беты. Если вы получите уведомление об обновлении, пожалуйста, обновите быстро. Старые версии могут привести к нестабильности сервиса или невозможности использования.",
    ),
    "discoverNewVersion": MessageLookupByLibrary.simpleMessage(
      "Обнаружена новая версия",
    ),
    "discovery": MessageLookupByLibrary.simpleMessage(
      "Обнаружена новая версия",
    ),
    "dnsDesc": MessageLookupByLibrary.simpleMessage(
      "Обновление настроек, связанных с DNS",
    ),
    "dnsMode": MessageLookupByLibrary.simpleMessage("Режим DNS"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage(
      "Вы хотите пропустить",
    ),
    "domain": MessageLookupByLibrary.simpleMessage("Домен"),
    "domainStatusAvailable": MessageLookupByLibrary.simpleMessage(
      "Сервис доступен",
    ),
    "domainStatusChecking": MessageLookupByLibrary.simpleMessage("Проверка..."),
    "domainStatusUnavailable": MessageLookupByLibrary.simpleMessage(
      "Сервис недоступен",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Скачивание"),
    "edit": MessageLookupByLibrary.simpleMessage("Редактировать"),
    "emptyTip": m3,
    "en": MessageLookupByLibrary.simpleMessage("Английский"),
    "enableOverride": MessageLookupByLibrary.simpleMessage(
      "Включить переопределение",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" записей"),
    "exclude": MessageLookupByLibrary.simpleMessage(
      "Скрыть из последних задач",
    ),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "Когда приложение находится в фоновом режиме, оно скрыто из последних задач",
    ),
    "existsTip": m4,
    "exit": MessageLookupByLibrary.simpleMessage("Выход"),
    "expand": MessageLookupByLibrary.simpleMessage("Стандартный"),
    "expirationTime": MessageLookupByLibrary.simpleMessage("Время истечения"),
    "exportFile": MessageLookupByLibrary.simpleMessage("Экспорт файла"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Экспорт логов"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("Экспорт успешен"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("Экспрессивные"),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "Внешний контроллер",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "При включении ядро Clash можно контролировать на порту 9090",
    ),
    "externalLink": MessageLookupByLibrary.simpleMessage("Внешняя ссылка"),
    "externalResources": MessageLookupByLibrary.simpleMessage(
      "Внешние ресурсы",
    ),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Фильтр Fakeip"),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Диапазон Fakeip"),
    "fallback": MessageLookupByLibrary.simpleMessage("Резервный"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Обычно используется оффшорный DNS",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage(
      "Фильтр резервного DNS",
    ),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("Точная передача"),
    "file": MessageLookupByLibrary.simpleMessage("Файл"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("Прямая загрузка профиля"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "Файл был изменен. Хотите сохранить изменения?",
    ),
    "filterSystemApp": MessageLookupByLibrary.simpleMessage(
      "Фильтровать системные приложения",
    ),
    "findProcessMode": MessageLookupByLibrary.simpleMessage(
      "Режим поиска процесса",
    ),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "При включении возможны небольшие потери производительности",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Семейство шрифтов"),
    "fourColumns": MessageLookupByLibrary.simpleMessage("Четыре столбца"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("Фруктовый микс"),
    "general": MessageLookupByLibrary.simpleMessage("Общие"),
    "generalDesc": MessageLookupByLibrary.simpleMessage(
      "Изменение общих настроек",
    ),
    "geoData": MessageLookupByLibrary.simpleMessage("Геоданные"),
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Режим низкого потребления памяти для геоданных",
    ),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "Включение будет использовать загрузчик геоданных с низким потреблением памяти",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("Код Geoip"),
    "getOriginRules": MessageLookupByLibrary.simpleMessage(
      "Получить оригинальные правила",
    ),
    "global": MessageLookupByLibrary.simpleMessage("Глобальный"),
    "go": MessageLookupByLibrary.simpleMessage("Перейти"),
    "goDownload": MessageLookupByLibrary.simpleMessage("Перейти к загрузке"),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Хотите сохранить изменения в кэше?",
    ),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Добавить Hosts"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage(
      "Конфликт горячих клавиш",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage(
      "Управление горячими клавишами",
    ),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Использование клавиатуры для управления приложением",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("Часов"),
    "icon": MessageLookupByLibrary.simpleMessage("Иконка"),
    "iconConfiguration": MessageLookupByLibrary.simpleMessage(
      "Конфигурация иконки",
    ),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Стиль иконки"),
    "import": MessageLookupByLibrary.simpleMessage("Импорт"),
    "importFile": MessageLookupByLibrary.simpleMessage("Импорт из файла"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("Импорт из URL"),
    "importUrl": MessageLookupByLibrary.simpleMessage("Импорт по URL"),
    "infiniteTime": MessageLookupByLibrary.simpleMessage(
      "Долгосрочное действие",
    ),
    "init": MessageLookupByLibrary.simpleMessage("Инициализация"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите правильную горячую клавишу",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Интеллектуальный выбор",
    ),
    "internet": MessageLookupByLibrary.simpleMessage("Интернет"),
    "interval": MessageLookupByLibrary.simpleMessage("Интервал"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("Внутренний IP"),
    "ipcidr": MessageLookupByLibrary.simpleMessage("IPCIDR"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "При включении будет возможно получать IPv6 трафик",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешить входящий IPv6",
    ),
    "ja": MessageLookupByLibrary.simpleMessage("Японский"),
    "just": MessageLookupByLibrary.simpleMessage("Только что"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Интервал поддержания TCP-соединения",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Ключ"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "layout": MessageLookupByLibrary.simpleMessage("Макет"),
    "light": MessageLookupByLibrary.simpleMessage("Светлый"),
    "list": MessageLookupByLibrary.simpleMessage("Список"),
    "listen": MessageLookupByLibrary.simpleMessage("Слушать"),
    "local": MessageLookupByLibrary.simpleMessage("Локальный"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование локальных данных на локальный диск",
    ),
    "localRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Восстановление данных из файла",
    ),
    "logLevel": MessageLookupByLibrary.simpleMessage("Уровень логов"),
    "logcat": MessageLookupByLibrary.simpleMessage("Logcat"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage(
      "Отключение скроет запись логов",
    ),
    "logs": MessageLookupByLibrary.simpleMessage("Логи"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("Записи захвата логов"),
    "logsTest": MessageLookupByLibrary.simpleMessage("Тест журналов"),
    "loopback": MessageLookupByLibrary.simpleMessage(
      "Инструмент разблокировки Loopback",
    ),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Используется для разблокировки Loopback UWP",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Свободный"),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Информация о памяти"),
    "messageTest": MessageLookupByLibrary.simpleMessage(
      "Тестирование сообщения",
    ),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("Это сообщение."),
    "min": MessageLookupByLibrary.simpleMessage("Мин"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage(
      "Свернуть при выходе",
    ),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Изменить стандартное событие выхода из системы",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("Минут"),
    "mixedPort": MessageLookupByLibrary.simpleMessage("Смешанный порт"),
    "mode": MessageLookupByLibrary.simpleMessage("Режим"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Монохром"),
    "months": MessageLookupByLibrary.simpleMessage("Месяцев"),
    "more": MessageLookupByLibrary.simpleMessage("Еще"),
    "name": MessageLookupByLibrary.simpleMessage("Имя"),
    "nameSort": MessageLookupByLibrary.simpleMessage("Сортировка по имени"),
    "nameserver": MessageLookupByLibrary.simpleMessage("Сервер имен"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Для разрешения домена",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Политика сервера имен",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Указать соответствующую политику сервера имен",
    ),
    "network": MessageLookupByLibrary.simpleMessage("Сеть"),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Изменение настроек, связанных с сетью",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage(
      "Обнаружение сети",
    ),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Скорость сети"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("Нейтральные"),
    "noData": MessageLookupByLibrary.simpleMessage("Нет данных"),
    "noHotKey": MessageLookupByLibrary.simpleMessage("Нет горячей клавиши"),
    "noIcon": MessageLookupByLibrary.simpleMessage("Нет иконки"),
    "noInfo": MessageLookupByLibrary.simpleMessage("Нет информации"),
    "noMoreInfoDesc": MessageLookupByLibrary.simpleMessage(
      "Нет дополнительной информации",
    ),
    "noNetwork": MessageLookupByLibrary.simpleMessage("Нет сети"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("Приложение без сети"),
    "noProxy": MessageLookupByLibrary.simpleMessage("Нет прокси"),
    "noProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, создайте профиль или добавьте действительный профиль",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("Не разрешать IP"),
    "none": MessageLookupByLibrary.simpleMessage("Нет"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "Текущая группа прокси не может быть выбрана.",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Нет профиля, пожалуйста, добавьте профиль",
    ),
    "nullTip": m7,
    "numberTip": m8,
    "oneColumn": MessageLookupByLibrary.simpleMessage("Один столбец"),
    "onlineSupport": MessageLookupByLibrary.simpleMessage("Онлайн поддержка"),
    "onlineSupportAddMore": MessageLookupByLibrary.simpleMessage(
      "Добавить еще",
    ),
    "onlineSupportApiConfigNotFound": MessageLookupByLibrary.simpleMessage(
      "Конфигурация API онлайн поддержки не найдена, проверьте настройки",
    ),
    "onlineSupportCancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "onlineSupportClearHistory": MessageLookupByLibrary.simpleMessage(
      "Очистить историю",
    ),
    "onlineSupportClearHistoryConfirm": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите очистить всю историю чата? Это действие нельзя отменить.",
    ),
    "onlineSupportClickToSelect": MessageLookupByLibrary.simpleMessage(
      "Нажмите для выбора изображений",
    ),
    "onlineSupportConfirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "onlineSupportConnected": MessageLookupByLibrary.simpleMessage(
      "Успешно подключено к системе поддержки",
    ),
    "onlineSupportConnecting": MessageLookupByLibrary.simpleMessage(
      "Подключение...",
    ),
    "onlineSupportConnectionError": MessageLookupByLibrary.simpleMessage(
      "Ошибка подключения",
    ),
    "onlineSupportDisconnected": MessageLookupByLibrary.simpleMessage(
      "Отключено",
    ),
    "onlineSupportGetMessagesFailed": m9,
    "onlineSupportInputHint": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите ваш вопрос...",
    ),
    "onlineSupportNoMessages": MessageLookupByLibrary.simpleMessage(
      "Пока нет сообщений, отправьте сообщение для начала консультации",
    ),
    "onlineSupportSelectImages": MessageLookupByLibrary.simpleMessage(
      "Выбрать изображения",
    ),
    "onlineSupportSelectImagesFailed": m10,
    "onlineSupportSend": MessageLookupByLibrary.simpleMessage("Отправить"),
    "onlineSupportSendImage": MessageLookupByLibrary.simpleMessage(
      "Отправить изображение",
    ),
    "onlineSupportSendMessageFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось отправить сообщение: Невозможно получить токен аутентификации",
    ),
    "onlineSupportSupportedFormats": MessageLookupByLibrary.simpleMessage(
      "Поддерживает JPG, PNG, GIF, WebP, BMP\nМакс 10МБ",
    ),
    "onlineSupportTitle": MessageLookupByLibrary.simpleMessage(
      "Онлайн поддержка",
    ),
    "onlineSupportTokenNotFound": MessageLookupByLibrary.simpleMessage(
      "Токен аутентификации не найден",
    ),
    "onlineSupportUnsupportedHttpMethod": m11,
    "onlineSupportUploadFailed": m12,
    "onlineSupportWebSocketConfigNotFound": MessageLookupByLibrary.simpleMessage(
      "Конфигурация WebSocket онлайн поддержки не найдена, проверьте настройки",
    ),
    "onlyIcon": MessageLookupByLibrary.simpleMessage("Только иконка"),
    "onlyOtherApps": MessageLookupByLibrary.simpleMessage(
      "Только сторонние приложения",
    ),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Только статистика прокси",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "При включении будет учитываться только трафик прокси",
    ),
    "options": MessageLookupByLibrary.simpleMessage("Опции"),
    "other": MessageLookupByLibrary.simpleMessage("Другое"),
    "otherContributors": MessageLookupByLibrary.simpleMessage(
      "Другие участники",
    ),
    "outboundMode": MessageLookupByLibrary.simpleMessage(
      "Режим исходящего трафика",
    ),
    "override": MessageLookupByLibrary.simpleMessage("Переопределить"),
    "overrideDesc": MessageLookupByLibrary.simpleMessage(
      "Переопределить конфигурацию, связанную с прокси",
    ),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Переопределить DNS"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "Включение переопределит настройки DNS в профиле",
    ),
    "overrideInvalidTip": MessageLookupByLibrary.simpleMessage(
      "В скриптовом режиме не действует",
    ),
    "overrideOriginRules": MessageLookupByLibrary.simpleMessage(
      "Переопределить оригинальное правило",
    ),
    "palette": MessageLookupByLibrary.simpleMessage("Палитра"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "paste": MessageLookupByLibrary.simpleMessage("Вставить"),
    "plans": MessageLookupByLibrary.simpleMessage("Планы"),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, привяжите WebDAV",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите название скрипта",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите пароль администратора",
    ),
    "pleaseUploadFile": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, загрузите файл",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, загрузите действительный QR-код",
    ),
    "port": MessageLookupByLibrary.simpleMessage("Порт"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Введите другой порт",
    ),
    "portTip": m16,
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Приоритетное использование HTTP/3 для DOH",
    ),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, нажмите клавишу.",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("Предпросмотр"),
    "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Пожалуйста, введите действительный формат интервала времени",
        ),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Пожалуйста, введите интервал времени для автообновления",
        ),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "Профиль был изменен. Хотите отключить автообновление?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите имя профиля",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "ошибка разбора профиля",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите действительный URL профиля",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите URL профиля",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Профили"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Сортировка профилей"),
    "project": MessageLookupByLibrary.simpleMessage("Проект"),
    "providers": MessageLookupByLibrary.simpleMessage("Провайдеры"),
    "proxies": MessageLookupByLibrary.simpleMessage("Прокси"),
    "proxiesSetting": MessageLookupByLibrary.simpleMessage("Настройка прокси"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("Группа прокси"),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage(
      "Прокси-сервер имен",
    ),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Домен для разрешения прокси-узлов",
    ),
    "proxyPort": MessageLookupByLibrary.simpleMessage("Порт прокси"),
    "proxyPortDesc": MessageLookupByLibrary.simpleMessage(
      "Установить порт прослушивания Clash",
    ),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Провайдеры прокси"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Чисто черный режим"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR-код"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Сканируйте QR-код для получения профиля",
    ),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Радужные"),
    "recovery": MessageLookupByLibrary.simpleMessage("Восстановление"),
    "recoveryAll": MessageLookupByLibrary.simpleMessage(
      "Восстановить все данные",
    ),
    "recoveryProfiles": MessageLookupByLibrary.simpleMessage(
      "Только восстановление профилей",
    ),
    "recoveryStrategy": MessageLookupByLibrary.simpleMessage(
      "Стратегия восстановления",
    ),
    "recoveryStrategy_compatible": MessageLookupByLibrary.simpleMessage(
      "Совместимый",
    ),
    "recoveryStrategy_override": MessageLookupByLibrary.simpleMessage(
      "Переопределение",
    ),
    "recoverySuccess": MessageLookupByLibrary.simpleMessage(
      "Восстановление успешно",
    ),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redir-порт"),
    "redo": MessageLookupByLibrary.simpleMessage("Повторить"),
    "regExp": MessageLookupByLibrary.simpleMessage("Регулярное выражение"),
    "remote": MessageLookupByLibrary.simpleMessage("Удаленный"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование локальных данных на WebDAV",
    ),
    "remoteRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Восстановление данных с WebDAV",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Удалить"),
    "rename": MessageLookupByLibrary.simpleMessage("Переименовать"),
    "requests": MessageLookupByLibrary.simpleMessage("Запросы"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "Просмотр последних записей запросов",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Сброс"),
    "resetTip": MessageLookupByLibrary.simpleMessage(
      "Убедитесь, что хотите сбросить",
    ),
    "resources": MessageLookupByLibrary.simpleMessage("Ресурсы"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "Информация, связанная с внешними ресурсами",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage("Соблюдение правил"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS-соединение следует правилам, необходимо настроить proxy-server-nameserver",
    ),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Адрес маршрутизации"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Настройка адреса прослушивания маршрутизации",
    ),
    "routeMode": MessageLookupByLibrary.simpleMessage("Режим маршрутизации"),
    "routeMode_bypassPrivate": MessageLookupByLibrary.simpleMessage(
      "Обход частных адресов маршрутизации",
    ),
    "routeMode_config": MessageLookupByLibrary.simpleMessage(
      "Использовать конфигурацию",
    ),
    "ru": MessageLookupByLibrary.simpleMessage("Русский"),
    "rule": MessageLookupByLibrary.simpleMessage("Правило"),
    "ruleName": MessageLookupByLibrary.simpleMessage("Название правила"),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("Провайдеры правил"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Цель правила"),
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Сохранить изменения?"),
    "saveTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите сохранить?",
    ),
    "script": MessageLookupByLibrary.simpleMessage("Скрипт"),
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "seconds": MessageLookupByLibrary.simpleMessage("Секунд"),
    "selectAll": MessageLookupByLibrary.simpleMessage("Выбрать все"),
    "selected": MessageLookupByLibrary.simpleMessage("Выбрано"),
    "selectedCountTitle": m18,
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "show": MessageLookupByLibrary.simpleMessage("Показать"),
    "shrink": MessageLookupByLibrary.simpleMessage("Сжать"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("Тихий запуск"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запуск в фоновом режиме",
    ),
    "size": MessageLookupByLibrary.simpleMessage("Размер"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Socks-порт"),
    "sort": MessageLookupByLibrary.simpleMessage("Сортировка"),
    "source": MessageLookupByLibrary.simpleMessage("Источник"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("Исходный IP"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Режим стека"),
    "standard": MessageLookupByLibrary.simpleMessage("Стандартный"),
    "start": MessageLookupByLibrary.simpleMessage("Старт"),
    "startVpn": MessageLookupByLibrary.simpleMessage("Запуск VPN..."),
    "status": MessageLookupByLibrary.simpleMessage("Статус"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "Системный DNS будет использоваться при выключении",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Стоп"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Остановка VPN..."),
    "style": MessageLookupByLibrary.simpleMessage("Стиль"),
    "subRule": MessageLookupByLibrary.simpleMessage("Подправило"),
    "submit": MessageLookupByLibrary.simpleMessage("Отправить"),
    "subscriptionExpired": MessageLookupByLibrary.simpleMessage(
      "Подписка истекла",
    ),
    "subscriptionExpiredDetail": m20,
    "subscriptionExpiresToday": MessageLookupByLibrary.simpleMessage(
      "Подписка истекает сегодня",
    ),
    "subscriptionExpiresTodayDetail": MessageLookupByLibrary.simpleMessage(
      "План истёк сегодня, пожалуйста немедленно продлите чтобы избежать прерывания сервиса",
    ),
    "subscriptionExpiringInDays": MessageLookupByLibrary.simpleMessage(
      "Подписка скоро истекает",
    ),
    "subscriptionExpiringInDaysDetail": m21,
    "subscriptionNoSubscription": MessageLookupByLibrary.simpleMessage(
      "Нет подписки",
    ),
    "subscriptionNoSubscriptionDetail": MessageLookupByLibrary.simpleMessage(
      "Не найдено доступных планов подписок, пожалуйста купите план для использования",
    ),
    "subscriptionNotLoggedIn": MessageLookupByLibrary.simpleMessage(
      "Не авторизован",
    ),
    "subscriptionNotLoggedInDetail": MessageLookupByLibrary.simpleMessage(
      "Сначала войдите в систему",
    ),
    "subscriptionTrafficExhausted": MessageLookupByLibrary.simpleMessage(
      "Трафик исчерпан",
    ),
    "subscriptionTrafficExhaustedDetail": MessageLookupByLibrary.simpleMessage(
      "Трафик плана использован полностью, пожалуйста купите больше трафика или обновите план",
    ),
    "subscriptionValid": MessageLookupByLibrary.simpleMessage(
      "Подписка действительна",
    ),
    "subscriptionValidDetail": m22,
    "sync": MessageLookupByLibrary.simpleMessage("Синхронизация"),
    "system": MessageLookupByLibrary.simpleMessage("Система"),
    "systemApp": MessageLookupByLibrary.simpleMessage("Системное приложение"),
    "systemFont": MessageLookupByLibrary.simpleMessage("Системный шрифт"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("Системный прокси"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Прикрепить HTTP-прокси к VpnService",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("Вкладка"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("Анимация вкладок"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage(
      "Действительно только в мобильном виде",
    ),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP параллелизм"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "Включение позволит использовать параллелизм TCP",
    ),
    "testUrl": MessageLookupByLibrary.simpleMessage("Тест URL"),
    "textScale": MessageLookupByLibrary.simpleMessage("Масштабирование текста"),
    "theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Цвет темы"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Установить темный режим, настроить цвет",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Режим темы"),
    "threeColumns": MessageLookupByLibrary.simpleMessage("Три столбца"),
    "tight": MessageLookupByLibrary.simpleMessage("Плотный"),
    "time": MessageLookupByLibrary.simpleMessage("Время"),
    "tip": MessageLookupByLibrary.simpleMessage("подсказка"),
    "toggle": MessageLookupByLibrary.simpleMessage("Переключить"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("Тональный акцент"),
    "tools": MessageLookupByLibrary.simpleMessage("Инструменты"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Tproxy-порт"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage(
      "Использование трафика",
    ),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "действительно только в режиме администратора",
    ),
    "twoColumns": MessageLookupByLibrary.simpleMessage("Два столбца"),
    "unableToUpdateCurrentProfileDesc": MessageLookupByLibrary.simpleMessage(
      "невозможно обновить текущий профиль",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("Отменить"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage(
      "Унифицированная задержка",
    ),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "Убрать дополнительные задержки, такие как рукопожатие",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("Неизвестно"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Без имени"),
    "update": MessageLookupByLibrary.simpleMessage("Обновить"),
    "updateCheckAllServersUnavailable": MessageLookupByLibrary.simpleMessage(
      "Все настроенные серверы обновлений недоступны",
    ),
    "updateCheckCurrentVersion": m27,
    "updateCheckForceUpdate": m28,
    "updateCheckMustUpdate": MessageLookupByLibrary.simpleMessage(
      "Необходимо обновить",
    ),
    "updateCheckNewVersionFound": m29,
    "updateCheckNoServerUrlsConfigured": MessageLookupByLibrary.simpleMessage(
      "URL серверов обновлений не настроены, проверьте конфигурацию",
    ),
    "updateCheckReleaseNotes": MessageLookupByLibrary.simpleMessage(
      "Примечания к выпуску:",
    ),
    "updateCheckServerError": m30,
    "updateCheckServerTemporarilyUnavailable":
        MessageLookupByLibrary.simpleMessage(
          "Сервер временно недоступен, попробуйте позже",
        ),
    "updateCheckServerUrlNotConfigured": MessageLookupByLibrary.simpleMessage(
      "URL сервера обновлений не настроен, проверьте конфигурацию",
    ),
    "updateCheckUpdateLater": MessageLookupByLibrary.simpleMessage(
      "Обновить позже",
    ),
    "updateCheckUpdateNow": MessageLookupByLibrary.simpleMessage(
      "Обновить сейчас",
    ),
    "upload": MessageLookupByLibrary.simpleMessage("Загрузка"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Получить профиль через URL",
    ),
    "urlTip": m31,
    "useHosts": MessageLookupByLibrary.simpleMessage("Использовать hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage(
      "Использовать системные hosts",
    ),
    "value": MessageLookupByLibrary.simpleMessage("Значение"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("Яркие"),
    "view": MessageLookupByLibrary.simpleMessage("Просмотр"),
    "vpnDesc": MessageLookupByLibrary.simpleMessage(
      "Изменение настроек, связанных с VPN",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматически направляет весь системный трафик через VpnService",
    ),
    "vpnSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Прикрепить HTTP-прокси к VpnService",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Изменения вступят в силу после перезапуска VPN",
    ),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "Конфигурация WebDAV",
    ),
    "whitelistMode": MessageLookupByLibrary.simpleMessage(
      "Режим белого списка",
    ),
    "xboard24HourCustomerService": MessageLookupByLibrary.simpleMessage(
      "24-часовая поддержка клиентов",
    ),
    "xboardAccountBalance": MessageLookupByLibrary.simpleMessage(
      "Баланс счёта",
    ),
    "xboardAddLinkToConfig": MessageLookupByLibrary.simpleMessage(
      "Добавьте эту ссылку подписки в вашу конфигурацию",
    ),
    "xboardAddingToConfigList": MessageLookupByLibrary.simpleMessage(
      "Добавление в список конфигураций",
    ),
    "xboardAfterPurchasingPlan": MessageLookupByLibrary.simpleMessage(
      "После покупки плана вы получите:",
    ),
    "xboardApiUrlNotConfigured": MessageLookupByLibrary.simpleMessage(
      "URL API не настроен",
    ),
    "xboardAutoCheckEvery5Seconds": MessageLookupByLibrary.simpleMessage(
      "Система проверяет каждые 5 секунд, автоматически перенаправит после оплаты",
    ),
    "xboardAutoDetectPaymentStatus": MessageLookupByLibrary.simpleMessage(
      "Автоопределение статуса оплаты",
    ),
    "xboardAutoOpeningPaymentPage": MessageLookupByLibrary.simpleMessage(
      "Автоматически открывается страница оплаты, вернитесь в приложение после оплаты",
    ),
    "xboardAutoTesting": MessageLookupByLibrary.simpleMessage(
      "Автоматическое тестирование",
    ),
    "xboardBack": MessageLookupByLibrary.simpleMessage("Назад"),
    "xboardBrowserNotOpenedTip": MessageLookupByLibrary.simpleMessage(
      "Если браузер не открылся автоматически, нажмите \\\"Открыть заново\\\" или скопируйте ссылку вручную",
    ),
    "xboardBuyMoreTrafficOrUpgrade": MessageLookupByLibrary.simpleMessage(
      "Купите больше трафика или обновите план",
    ),
    "xboardBuyNow": MessageLookupByLibrary.simpleMessage("Купить сейчас"),
    "xboardBuyoutPlan": MessageLookupByLibrary.simpleMessage("План выкупа"),
    "xboardCancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "xboardCancelPayment": MessageLookupByLibrary.simpleMessage(
      "Отменить платёж",
    ),
    "xboardCheckPaymentFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось проверить статус оплаты",
    ),
    "xboardCheckStatus": MessageLookupByLibrary.simpleMessage(
      "Проверить статус",
    ),
    "xboardChecking": MessageLookupByLibrary.simpleMessage("Проверка"),
    "xboardCleaningOldConfig": MessageLookupByLibrary.simpleMessage(
      "Очистка старой конфигурации",
    ),
    "xboardClearError": MessageLookupByLibrary.simpleMessage("Очистить ошибку"),
    "xboardClickToCopy": MessageLookupByLibrary.simpleMessage(
      "Нажмите для копирования",
    ),
    "xboardClickToSetupNodes": MessageLookupByLibrary.simpleMessage(
      "Нажмите для настройки узлов",
    ),
    "xboardCompletePaymentInBrowser": MessageLookupByLibrary.simpleMessage(
      "2. Завершите оплату в браузере",
    ),
    "xboardConfigDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Загрузка конфигурации не удалась, проверьте ссылку подписки",
    ),
    "xboardConfigFormatError": MessageLookupByLibrary.simpleMessage(
      "Ошибка формата конфигурации, обратитесь к поставщику услуг",
    ),
    "xboardConfigSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Сохранение конфигурации не удалось, проверьте место на диске",
    ),
    "xboardConfigurationError": MessageLookupByLibrary.simpleMessage(
      "Ошибка конфигурации",
    ),
    "xboardConfirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "xboardConfirmAction": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "xboardConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Подтверждение пароля",
    ),
    "xboardConfirmPurchase": MessageLookupByLibrary.simpleMessage(
      "Подтвердить покупку",
    ),
    "xboardCongratulationsSubscriptionActivated":
        MessageLookupByLibrary.simpleMessage(
          "Поздравляем! Ваша подписка была успешно приобретена и активирована",
        ),
    "xboardConnectGlobalQualityNodes": MessageLookupByLibrary.simpleMessage(
      "Подключитесь к глобальным качественным узлам",
    ),
    "xboardConnectionTimeout": MessageLookupByLibrary.simpleMessage(
      "Таймаут соединения, проверьте сетевое подключение",
    ),
    "xboardCopyFailed": MessageLookupByLibrary.simpleMessage(
      "Копирование не удалось",
    ),
    "xboardCopyLink": MessageLookupByLibrary.simpleMessage(
      "Скопировать ссылку",
    ),
    "xboardCopyPaymentLink": MessageLookupByLibrary.simpleMessage(
      "Скопировать ссылку",
    ),
    "xboardCopySubscriptionLinkAbove": MessageLookupByLibrary.simpleMessage(
      "Скопируйте ссылку на подписку выше",
    ),
    "xboardCouponExpired": MessageLookupByLibrary.simpleMessage(
      "Срок действия купона истёк",
    ),
    "xboardCouponNotYetActive": MessageLookupByLibrary.simpleMessage(
      "Купон ещё не активен",
    ),
    "xboardCouponOptional": MessageLookupByLibrary.simpleMessage(
      "Купон (опционально)",
    ),
    "xboardCreatingOrder": MessageLookupByLibrary.simpleMessage(
      "Создание заказа",
    ),
    "xboardCreatingOrderPleaseWait": MessageLookupByLibrary.simpleMessage(
      "Мы создаём новый заказ для вас, пожалуйста, подождите",
    ),
    "xboardCurrentNode": MessageLookupByLibrary.simpleMessage("Текущий узел"),
    "xboardCurrentVersion": MessageLookupByLibrary.simpleMessage(
      "Текущая версия",
    ),
    "xboardDays": MessageLookupByLibrary.simpleMessage("дней"),
    "xboardDeductibleDuringPayment": MessageLookupByLibrary.simpleMessage(
      "Вычитается при оплате",
    ),
    "xboardDiscounted": MessageLookupByLibrary.simpleMessage("Со скидкой"),
    "xboardDownloadingConfig": MessageLookupByLibrary.simpleMessage(
      "Загрузка файла конфигурации",
    ),
    "xboardEmail": MessageLookupByLibrary.simpleMessage("Электронная почта"),
    "xboardEnableTun": MessageLookupByLibrary.simpleMessage("Включить TUN"),
    "xboardEnjoyFastNetworkExperience": MessageLookupByLibrary.simpleMessage(
      "Наслаждайтесь быстрым сетевым опытом",
    ),
    "xboardEnterCouponCode": MessageLookupByLibrary.simpleMessage(
      "Введите код купона",
    ),
    "xboardExcellent": MessageLookupByLibrary.simpleMessage("Отлично"),
    "xboardExpiryTime": MessageLookupByLibrary.simpleMessage("Время истечения"),
    "xboardFailedToCheckPaymentStatus": MessageLookupByLibrary.simpleMessage(
      "Не удалось проверить статус оплаты",
    ),
    "xboardFailedToGetSubscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить информацию о подписке",
    ),
    "xboardFailedToOpenPaymentLink": MessageLookupByLibrary.simpleMessage(
      "Не удалось открыть ссылку оплаты",
    ),
    "xboardFailedToOpenPaymentPage": MessageLookupByLibrary.simpleMessage(
      "Не удалось открыть страницу оплаты",
    ),
    "xboardFair": MessageLookupByLibrary.simpleMessage("Удовлетворительно"),
    "xboardForceUpdate": MessageLookupByLibrary.simpleMessage(
      "Принудительное обновление",
    ),
    "xboardForgotPassword": MessageLookupByLibrary.simpleMessage(
      "Забыли пароль",
    ),
    "xboardGettingIP": MessageLookupByLibrary.simpleMessage("Получение..."),
    "xboardGlobalNodes": MessageLookupByLibrary.simpleMessage(
      "Глобальные узлы",
    ),
    "xboardGood": MessageLookupByLibrary.simpleMessage("Хорошо"),
    "xboardGroup": MessageLookupByLibrary.simpleMessage("Группа"),
    "xboardHalfYearlyPayment": MessageLookupByLibrary.simpleMessage(
      "Полугодично",
    ),
    "xboardHandleLater": MessageLookupByLibrary.simpleMessage(
      "Обработать позже",
    ),
    "xboardHighSpeedNetwork": MessageLookupByLibrary.simpleMessage(
      "Высокоскоростная сеть",
    ),
    "xboardImportFailed": MessageLookupByLibrary.simpleMessage(
      "Импорт не удался",
    ),
    "xboardImportSuccess": MessageLookupByLibrary.simpleMessage(
      "Импорт успешен",
    ),
    "xboardInsufficientBalance": MessageLookupByLibrary.simpleMessage(
      "Недостаточный баланс",
    ),
    "xboardInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Неверное имя пользователя или пароль",
    ),
    "xboardInvalidOrExpiredCoupon": MessageLookupByLibrary.simpleMessage(
      "Недействительный или просроченный код купона",
    ),
    "xboardInvalidResponseFormat": MessageLookupByLibrary.simpleMessage(
      "Неверный формат ответа от сервера",
    ),
    "xboardInviteCode": MessageLookupByLibrary.simpleMessage("Код приглашения"),
    "xboardKeepSubscriptionLinkSafe": MessageLookupByLibrary.simpleMessage(
      "Храните ссылку на подписку в безопасности и не делитесь ею с другими",
    ),
    "xboardLater": MessageLookupByLibrary.simpleMessage("Позже"),
    "xboardLoadingFailed": MessageLookupByLibrary.simpleMessage(
      "Загрузка не удалась",
    ),
    "xboardLoadingPaymentPage": MessageLookupByLibrary.simpleMessage(
      "Загрузка страницы оплаты",
    ),
    "xboardLocalIP": MessageLookupByLibrary.simpleMessage("Локальный IP"),
    "xboardLoggedIn": MessageLookupByLibrary.simpleMessage("Авторизован"),
    "xboardLogin": MessageLookupByLibrary.simpleMessage("Вход"),
    "xboardLoginExpired": MessageLookupByLibrary.simpleMessage(
      "Срок входа истёк, войдите снова",
    ),
    "xboardLoginFailed": MessageLookupByLibrary.simpleMessage("Ошибка входа"),
    "xboardLoginSuccess": MessageLookupByLibrary.simpleMessage("Успешный вход"),
    "xboardLoginToViewSubscription": MessageLookupByLibrary.simpleMessage(
      "Войдите в систему для просмотра использования подписки",
    ),
    "xboardLogout": MessageLookupByLibrary.simpleMessage("Выход"),
    "xboardLogoutConfirmContent": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите выйти? Вам потребуется повторно ввести данные для входа.",
    ),
    "xboardLogoutConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Подтверждение выхода",
    ),
    "xboardLogoutFailed": MessageLookupByLibrary.simpleMessage("Ошибка выхода"),
    "xboardLogoutSuccess": MessageLookupByLibrary.simpleMessage(
      "Успешный выход",
    ),
    "xboardMissingRequiredField": MessageLookupByLibrary.simpleMessage(
      "Отсутствует обязательное поле",
    ),
    "xboardMonthlyPayment": MessageLookupByLibrary.simpleMessage("Ежемесячно"),
    "xboardMonthlyRenewal": MessageLookupByLibrary.simpleMessage(
      "Ежемесячное продление",
    ),
    "xboardMustUpdate": MessageLookupByLibrary.simpleMessage(
      "Необходимо обновить",
    ),
    "xboardNetworkConnectionFailed": MessageLookupByLibrary.simpleMessage(
      "Сетевое соединение не удалось, проверьте настройки сети",
    ),
    "xboardNewVersionFound": MessageLookupByLibrary.simpleMessage(
      "Найдена новая версия",
    ),
    "xboardNext": MessageLookupByLibrary.simpleMessage("Следующий"),
    "xboardNoAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "Нет доступных узлов",
    ),
    "xboardNoAvailablePlan": MessageLookupByLibrary.simpleMessage(
      "Нет доступных планов",
    ),
    "xboardNoAvailableSubscription": MessageLookupByLibrary.simpleMessage(
      "Нет доступных подписок",
    ),
    "xboardNoInternetConnection": MessageLookupByLibrary.simpleMessage(
      "Нет интернет-соединения, проверьте настройки сети",
    ),
    "xboardNoSubscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "Нет информации о подписке",
    ),
    "xboardNoSubscriptionPlans": MessageLookupByLibrary.simpleMessage(
      "Нет планов подписки",
    ),
    "xboardNodeName": MessageLookupByLibrary.simpleMessage("Имя узла"),
    "xboardNone": MessageLookupByLibrary.simpleMessage("Нет"),
    "xboardNotLoggedIn": MessageLookupByLibrary.simpleMessage("Не авторизован"),
    "xboardOneTimePayment": MessageLookupByLibrary.simpleMessage("Однократно"),
    "xboardOpenPaymentFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось открыть страницу оплаты",
    ),
    "xboardOpenPaymentLinkFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось открыть ссылку на оплату",
    ),
    "xboardOperationFailed": MessageLookupByLibrary.simpleMessage(
      "Операция не удалась",
    ),
    "xboardOperationTips": MessageLookupByLibrary.simpleMessage(
      "Советы по операциям",
    ),
    "xboardOrderCreationFailed": MessageLookupByLibrary.simpleMessage(
      "Создание заказа не удалось",
    ),
    "xboardOrderNotFound": MessageLookupByLibrary.simpleMessage(
      "Заказ не найден",
    ),
    "xboardOrderNumber": MessageLookupByLibrary.simpleMessage("Номер заказа"),
    "xboardOrderStatusPending": MessageLookupByLibrary.simpleMessage(
      "Статус заказа: Ожидает оплаты",
    ),
    "xboardPassword": MessageLookupByLibrary.simpleMessage("Пароль"),
    "xboardPaymentCancelled": MessageLookupByLibrary.simpleMessage(
      "Платёж отменён",
    ),
    "xboardPaymentComplete": MessageLookupByLibrary.simpleMessage(
      "Оплата завершена",
    ),
    "xboardPaymentCompleted": MessageLookupByLibrary.simpleMessage(
      "Оплата завершена!",
    ),
    "xboardPaymentFailed": MessageLookupByLibrary.simpleMessage(
      "Платёж не удался",
    ),
    "xboardPaymentGateway": MessageLookupByLibrary.simpleMessage(
      "Платёжный шлюз",
    ),
    "xboardPaymentInfo": MessageLookupByLibrary.simpleMessage(
      "Информация об оплате",
    ),
    "xboardPaymentInstructions1": MessageLookupByLibrary.simpleMessage(
      "1. Страница оплаты открыта автоматически",
    ),
    "xboardPaymentInstructions2": MessageLookupByLibrary.simpleMessage(
      "2. Пожалуйста, завершите оплату в браузере",
    ),
    "xboardPaymentInstructions3": MessageLookupByLibrary.simpleMessage(
      "3. Вернитесь в приложение после оплаты, система автоматически определит это",
    ),
    "xboardPaymentLink": MessageLookupByLibrary.simpleMessage(
      "Ссылка на оплату",
    ),
    "xboardPaymentLinkCopied": MessageLookupByLibrary.simpleMessage(
      "Ссылка на оплату скопирована в буфер обмена",
    ),
    "xboardPaymentMethodVerified": MessageLookupByLibrary.simpleMessage(
      "Способ оплаты подтверждён",
    ),
    "xboardPaymentMethodVerifiedPreparing": MessageLookupByLibrary.simpleMessage(
      "Способ оплаты подтверждён, готовимся к перенаправлению на страницу оплаты",
    ),
    "xboardPaymentPageAutoOpened": MessageLookupByLibrary.simpleMessage(
      "1. Страница оплаты была открыта автоматически",
    ),
    "xboardPaymentPageOpenedCompleteAndReturn":
        MessageLookupByLibrary.simpleMessage(
          "Страница оплаты открыта, завершите оплату и вернитесь в приложение",
        ),
    "xboardPaymentPageOpenedInBrowser": MessageLookupByLibrary.simpleMessage(
      "Страница оплаты открыта в браузере, вернитесь в приложение после оплаты",
    ),
    "xboardPaymentSuccess": MessageLookupByLibrary.simpleMessage(
      "Платёж успешен",
    ),
    "xboardPaymentSuccessful": MessageLookupByLibrary.simpleMessage(
      "🎉 Платёж успешен!",
    ),
    "xboardPlanInfo": MessageLookupByLibrary.simpleMessage(
      "Информация о плане",
    ),
    "xboardPlanNotFound": MessageLookupByLibrary.simpleMessage(
      "План не найден",
    ),
    "xboardPlans": MessageLookupByLibrary.simpleMessage("Планы"),
    "xboardPleaseSelectPaymentPeriod": MessageLookupByLibrary.simpleMessage(
      "Выберите период оплаты",
    ),
    "xboardPoor": MessageLookupByLibrary.simpleMessage("Плохо"),
    "xboardPreparingImport": MessageLookupByLibrary.simpleMessage(
      "Подготовка импорта",
    ),
    "xboardPreparingPaymentPage": MessageLookupByLibrary.simpleMessage(
      "Подготовка страницы оплаты, скоро перенаправим",
    ),
    "xboardPrevious": MessageLookupByLibrary.simpleMessage("Предыдущий"),
    "xboardProcessing": MessageLookupByLibrary.simpleMessage("Обработка..."),
    "xboardProfessionalSupport": MessageLookupByLibrary.simpleMessage(
      "Профессиональная поддержка",
    ),
    "xboardProfile": MessageLookupByLibrary.simpleMessage("Профиль"),
    "xboardProtectNetworkPrivacy": MessageLookupByLibrary.simpleMessage(
      "Защитите вашу сетевую конфиденциальность",
    ),
    "xboardProxy": MessageLookupByLibrary.simpleMessage("Прокси"),
    "xboardProxyMode": MessageLookupByLibrary.simpleMessage("Режим прокси"),
    "xboardProxyModeDirectDescription": MessageLookupByLibrary.simpleMessage(
      "Все соединения прямые, без использования прокси",
    ),
    "xboardProxyModeGlobalDescription": MessageLookupByLibrary.simpleMessage(
      "Весь трафик проходит через прокси-сервер",
    ),
    "xboardProxyModeRuleDescription": MessageLookupByLibrary.simpleMessage(
      "Автоматически выбирать прямое соединение или прокси на основе правил",
    ),
    "xboardPurchasePlan": MessageLookupByLibrary.simpleMessage("Купить план"),
    "xboardPurchaseSubscription": MessageLookupByLibrary.simpleMessage(
      "Купить подписку",
    ),
    "xboardPurchaseSubscriptionToUse": MessageLookupByLibrary.simpleMessage(
      "Купите подписку для использования",
    ),
    "xboardPurchaseTraffic": MessageLookupByLibrary.simpleMessage(
      "Купить трафик",
    ),
    "xboardQuarterlyPayment": MessageLookupByLibrary.simpleMessage(
      "Ежеквартально",
    ),
    "xboardRefresh": MessageLookupByLibrary.simpleMessage("Обновить"),
    "xboardRefreshStatus": MessageLookupByLibrary.simpleMessage(
      "Обновить статус",
    ),
    "xboardRegister": MessageLookupByLibrary.simpleMessage("Регистрация"),
    "xboardRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка регистрации",
    ),
    "xboardRegisterSuccess": MessageLookupByLibrary.simpleMessage(
      "Регистрация успешна! Перенаправление на страницу входа...",
    ),
    "xboardReload": MessageLookupByLibrary.simpleMessage("Перезагрузить"),
    "xboardRelogin": MessageLookupByLibrary.simpleMessage("Войти снова"),
    "xboardRememberPassword": MessageLookupByLibrary.simpleMessage(
      "Запомнить пароль",
    ),
    "xboardRenewPlan": MessageLookupByLibrary.simpleMessage("Продлить план"),
    "xboardRenewToContinue": MessageLookupByLibrary.simpleMessage(
      "Продлите подписку для продолжения использования",
    ),
    "xboardReopen": MessageLookupByLibrary.simpleMessage("Открыть заново"),
    "xboardReopenPayment": MessageLookupByLibrary.simpleMessage(
      "Повторно открыть оплату",
    ),
    "xboardReopenPaymentPageTip": MessageLookupByLibrary.simpleMessage(
      "Для повторного открытия нажмите кнопку \\\"Открыть заново\\\" ниже",
    ),
    "xboardRetry": MessageLookupByLibrary.simpleMessage("Повторить"),
    "xboardRetryGet": MessageLookupByLibrary.simpleMessage("Повторить"),
    "xboardReturn": MessageLookupByLibrary.simpleMessage("Вернуться"),
    "xboardReturnAfterPaymentAutoDetect": MessageLookupByLibrary.simpleMessage(
      "3. Вернитесь в приложение после оплаты, система автоматически определит",
    ),
    "xboardRunningTime": m34,
    "xboardSecureEncryption": MessageLookupByLibrary.simpleMessage(
      "Безопасное шифрование",
    ),
    "xboardSelectPaymentPeriod": MessageLookupByLibrary.simpleMessage(
      "Выберите период оплаты",
    ),
    "xboardSelectPeriod": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, выберите период покупки",
    ),
    "xboardSendVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Отправить код подтверждения",
    ),
    "xboardServerError": MessageLookupByLibrary.simpleMessage("Ошибка сервера"),
    "xboardSetup": MessageLookupByLibrary.simpleMessage("Настройка"),
    "xboardSixMonthCycle": MessageLookupByLibrary.simpleMessage(
      "6-месячный цикл",
    ),
    "xboardSpeedLimit": MessageLookupByLibrary.simpleMessage(
      "Ограничение скорости",
    ),
    "xboardStartProxy": MessageLookupByLibrary.simpleMessage(
      "Запустить прокси",
    ),
    "xboardStop": MessageLookupByLibrary.simpleMessage("Остановить"),
    "xboardStopProxy": MessageLookupByLibrary.simpleMessage(
      "Остановить прокси",
    ),
    "xboardSubscription": MessageLookupByLibrary.simpleMessage("Подписка"),
    "xboardSubscriptionCopied": MessageLookupByLibrary.simpleMessage(
      "Ссылка на подписку скопирована в буфер обмена",
    ),
    "xboardSubscriptionExpired": MessageLookupByLibrary.simpleMessage(
      "Срок подписки истёк",
    ),
    "xboardSubscriptionHasExpired": MessageLookupByLibrary.simpleMessage(
      "Подписка истекла",
    ),
    "xboardSubscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "Информация о подписке",
    ),
    "xboardSubscriptionLink": MessageLookupByLibrary.simpleMessage(
      "Ссылка на подписку",
    ),
    "xboardSubscriptionLinkCopied": MessageLookupByLibrary.simpleMessage(
      "Ссылка на подписку скопирована в буфер обмена",
    ),
    "xboardSubscriptionPurchase": MessageLookupByLibrary.simpleMessage(
      "Покупка подписки",
    ),
    "xboardSubscriptionStatus": MessageLookupByLibrary.simpleMessage(
      "Статус подписки",
    ),
    "xboardSwitch": MessageLookupByLibrary.simpleMessage("Переключить"),
    "xboardTesting": MessageLookupByLibrary.simpleMessage("Тестирование"),
    "xboardThirtySixMonthCycle": MessageLookupByLibrary.simpleMessage(
      "36-месячный цикл",
    ),
    "xboardThreeMonthCycle": MessageLookupByLibrary.simpleMessage(
      "3-месячный цикл",
    ),
    "xboardThreeYearPayment": MessageLookupByLibrary.simpleMessage(
      "Трёхлетний",
    ),
    "xboardTimeout": MessageLookupByLibrary.simpleMessage("Таймаут"),
    "xboardTokenExpiredContent": MessageLookupByLibrary.simpleMessage(
      "Срок вашей сессии истёк. Пожалуйста, войдите снова для продолжения.",
    ),
    "xboardTokenExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Срок входа истёк",
    ),
    "xboardTraffic": MessageLookupByLibrary.simpleMessage("Трафик"),
    "xboardTrafficExhausted": MessageLookupByLibrary.simpleMessage(
      "Трафик исчерпан",
    ),
    "xboardTrafficUsedUp": MessageLookupByLibrary.simpleMessage(
      "Трафик исчерпан",
    ),
    "xboardTunEnabled": MessageLookupByLibrary.simpleMessage("TUN включён"),
    "xboardTwelveMonthCycle": MessageLookupByLibrary.simpleMessage(
      "12-месячный цикл",
    ),
    "xboardTwentyFourMonthCycle": MessageLookupByLibrary.simpleMessage(
      "24-месячный цикл",
    ),
    "xboardTwoYearPayment": MessageLookupByLibrary.simpleMessage("Двухлетний"),
    "xboardUnauthorizedAccess": MessageLookupByLibrary.simpleMessage(
      "Неавторизованный доступ, сначала войдите в систему",
    ),
    "xboardUnknownErrorRetry": MessageLookupByLibrary.simpleMessage(
      "Неизвестная ошибка, повторите попытку",
    ),
    "xboardUnknownUser": MessageLookupByLibrary.simpleMessage(
      "Неизвестный пользователь",
    ),
    "xboardUnselected": MessageLookupByLibrary.simpleMessage("Не выбрано"),
    "xboardUnsupportedCouponType": MessageLookupByLibrary.simpleMessage(
      "Неподдерживаемый тип купона",
    ),
    "xboardUpdateContent": MessageLookupByLibrary.simpleMessage(
      "Содержание обновления:",
    ),
    "xboardUpdateLater": MessageLookupByLibrary.simpleMessage("Обновить позже"),
    "xboardUpdateNow": MessageLookupByLibrary.simpleMessage("Обновить сейчас"),
    "xboardUpdateSubscriptionRegularly": MessageLookupByLibrary.simpleMessage(
      "Регулярно обновляйте подписку для получения последних узлов",
    ),
    "xboardUsageInstructions": MessageLookupByLibrary.simpleMessage(
      "Инструкции по использованию",
    ),
    "xboardUsed": MessageLookupByLibrary.simpleMessage("Использовано"),
    "xboardUsedTraffic": MessageLookupByLibrary.simpleMessage("Использовано"),
    "xboardValidatingConfigFormat": MessageLookupByLibrary.simpleMessage(
      "Проверка формата конфигурации",
    ),
    "xboardValidationFailed": MessageLookupByLibrary.simpleMessage(
      "Проверка не удалась",
    ),
    "xboardValidityPeriod": MessageLookupByLibrary.simpleMessage(
      "Период действия",
    ),
    "xboardVerify": MessageLookupByLibrary.simpleMessage("Проверить"),
    "xboardVeryPoor": MessageLookupByLibrary.simpleMessage("Очень плохо"),
    "xboardWaitingForPayment": MessageLookupByLibrary.simpleMessage(
      "Ожидание оплаты",
    ),
    "xboardWaitingPaymentCompletion": MessageLookupByLibrary.simpleMessage(
      "Ожидание завершения оплаты",
    ),
    "xboardYearlyPayment": MessageLookupByLibrary.simpleMessage("Ежегодно"),
    "years": MessageLookupByLibrary.simpleMessage("Лет"),
    "zh_CN": MessageLookupByLibrary.simpleMessage("Упрощенный китайский"),
  };
}
