﻿
#Использовать logos

Перем Лог;

Перем ПакетыХаба;

Процедура Обновить() Экспорт

	УстановкаПакета = Новый Установкапакета();
	Сервер =  Константы.СерверУдаленногоХранилища;
	Соединение = УстановкаПакета.ИнициализироватьСоединение(Сервер);
	Ресурс = Константы.ПутьВХранилище + "list.txt";
	Запрос = Новый HTTPЗапрос(Ресурс);
	Ответ  = Соединение.Получить(Запрос);

	Если НЕ Ответ.КодСостояния = 200 Тогда
		ТекстИсключения = СтрШаблон("Ошибка подключения к хабу <%1>", Ответ.КодСостояния);
		Ответ.Закрыть();
		ВызватьИсключение ТекстИсключения;
	КонецЕсли;
	
	ТекстОтвета = Ответ.ПолучитьТелоКакСтроку();
	Ответ.Закрыть();
		
	ПакетыХаба = Новый Соответствие;
	ТекстовыйДокумент  = Новый ТекстовыйДокумент;
	ТекстовыйДокумент.УстановитьТекст(ТекстОтвета);
	КоличествоПакетовВХабе = ТекстовыйДокумент.КоличествоСтрок();
	Для НомерСтроки = 1 По КоличествоПакетовВХабе Цикл
		ПакетыХаба.Вставить(СокрЛП(ТекстовыйДокумент.ПолучитьСтроку(НомерСтроки)), Истина);
	КонецЦикла;		

КонецПроцедуры

Функция ЭтоПакетХаба(Знач ИмяПакета) Экспорт

	Возврат ПакетыХаба[ИмяПакета] = Истина;

КонецФункции

Функция ПолучитьПакетыХаба() Экспорт

	Возврат ПакетыХаба;

КонецФункции	

Процедура Инициализация()

	Лог = Логирование.ПолучитьЛог("oscript.app.opm");
	//Лог.УстановитьУровень(УровниЛога.Отладка);
	
	Обновить();
	
КонецПроцедуры

Инициализация();
