﻿//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2023 BIA-Technologies Limited Liability Company
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//©///////////////////////////////////////////////////////////////////////////©//

#Если Сервер Тогда

#Область ОписаниеПеременных

// BSLLS:ExportVariables-off
//@skip-check object-module-export-variable
Перем ДатаОтправки Экспорт;
//@skip-check object-module-export-variable
Перем ДатаУстаревания Экспорт;
//@skip-check object-module-export-variable
Перем Идентификатор Экспорт;
//@skip-check object-module-export-variable
Перем ИдентификаторСообщенияЗапроса Экспорт;
//@skip-check object-module-export-variable
Перем КодОтправителя Экспорт;
//@skip-check object-module-export-variable
Перем КодПолучателя Экспорт;
//@skip-check object-module-export-variable
Перем Параметры Экспорт;
//@skip-check object-module-export-variable
Перем РазмерТела Экспорт;
// BSLLS:ExportVariables-on

Перем Тело; // переменная для хранения тела в рамках существования объекта

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Возвращает тело как поток.
// 
// Возвращаемое значение:
//  Поток - Тело
Функция ПолучитьТелоКакПоток() Экспорт
	
	Возврат ПолучитьТелоКакДвоичныеДанные().ОткрытьПотокДляЧтения();
	
КонецФункции

// Устанавливает тело как двоичные данные.
// При получении тела в другом формате происходит конвертация
// 
// Параметры:
//  Данные - ДвоичныеДанные
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТСообщениеСервисаИнтеграции - Мок
Функция УстановитьТелоКакДвоичныеДанные(Данные) Экспорт
	
	Тело = Данные;
	Возврат ЭтотОбъект;
	
КонецФункции

// Устанавливает тело как строку.
// При получении тела в другом формате происходит конвертация
// 
// Параметры:
//  Строка - Строка
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТСообщениеСервисаИнтеграции - Мок
Функция УстановитьТелоКакСтроку(Строка) Экспорт
	
	Тело = Строка;
	Возврат ЭтотОбъект;
	
КонецФункции

// Устанавливает тело как строку JSON.
// Сериализует переданный объект в строку JSON и сохраняет в тело
// При получении тела в другом формате происходит конвертация
// 
// Параметры:
//  Данные - Произвольный
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТСообщениеСервисаИнтеграции - Мок
Функция УстановитьТелоКакСтрокуJSON(Данные) Экспорт
	
	ЗаписьJSON = Новый ЗаписьJSON();
	ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON, Данные);
	
	Тело = ЗаписьJSON.Закрыть();
	
	Возврат ЭтотОбъект;
	
КонецФункции

// Добавляет параметр.
// 
// Параметры:
//  ИмяПараметра - Строка
//  Значение - Строка
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТСообщениеСервисаИнтеграции - Мок
Функция ДобавитьПараметр(ИмяПараметра, Значение) Экспорт
	
	Параметры.Вставить(ИмяПараметра, Значение);
	Возврат ЭтотОбъект;
	
КонецФункции

// Устанавливает дату отправки.
// 
// Параметры:
//  Значение - Дата
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТСообщениеСервисаИнтеграции - Мок
Функция ДатаОтправки(Значение) Экспорт
	
	ДатаОтправки = Значение;
	Возврат ЭтотОбъект;
	
КонецФункции

// Устанавливает дату устаревания.
// 
// Параметры:
//  Значение - Дата
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТСообщениеСервисаИнтеграции - Мок
Функция ДатаУстаревания(Значение) Экспорт
	
	ДатаУстаревания = Значение;
	Возврат ЭтотОбъект;
	
КонецФункции

// Устанавливает идентификатор сообщения.
// 
// Параметры:
//  Значение - УникальныйИдентификатор
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТСообщениеСервисаИнтеграции - Мок
Функция Идентификатор(Значение) Экспорт
	
	Идентификатор = Значение;
	Возврат ЭтотОбъект;
	
КонецФункции

// Устанавливает идентификатор сообщения запроса.
// 
// Параметры:
//  Значение - УникальныйИдентификатор
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТСообщениеСервисаИнтеграции - Мок
Функция ИдентификаторСообщенияЗапроса(Значение) Экспорт
	
	ИдентификаторСообщенияЗапроса = Значение;
	Возврат ЭтотОбъект;
	
КонецФункции

// Устанавливает код отправителя.
// 
// Параметры:
//  Значение - Строка
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТСообщениеСервисаИнтеграции - Мок
Функция КодОтправителя(Значение) Экспорт
	
	КодОтправителя = Значение;
	Возврат ЭтотОбъект;
	
КонецФункции

// Устанавливает код получателя.
// 
// Параметры:
//  Значение - Строка
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТСообщениеСервисаИнтеграции - Мок
Функция КодПолучателя(Значение) Экспорт
	
	КодПолучателя = Значение;
	Возврат ЭтотОбъект;
	
КонецФункции

// Устанавливает размер тела
// 
// Параметры:
//  Значение - Число
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТСообщениеСервисаИнтеграции - Мок
Функция РазмерТела(Значение) Экспорт
	
	РазмерТела = Значение;
	Возврат ЭтотОбъект;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПолучитьТелоКакДвоичныеДанные()
	
	ТипТела = ТипЗнч(Тело);
	
	Если Тело = Неопределено Тогда
		Возврат ПолучитьДвоичныеДанныеИзBase64Строки("");
	ИначеЕсли ТипТела = Тип("ДвоичныеДанные") Тогда
		Возврат Тело;
	ИначеЕсли ТипТела = Тип("Строка") Тогда
		Возврат ПолучитьДвоичныеДанныеИзСтроки(Тело);
	Иначе
		ВызватьИсключение СтрШаблон("Установленный тип тела %1 не поддерживается.", ТипТела);
	КонецЕсли;
	
КонецФункции

Процедура Инициализировать()
	
	ДатаОтправки = Дата(1, 1, 1);
	ДатаУстаревания = Дата(1, 1, 1);
	Идентификатор = Новый УникальныйИдентификатор("00000000-0000-0000-0000-000000000000");
	ИдентификаторСообщенияЗапроса = Новый УникальныйИдентификатор("00000000-0000-0000-0000-000000000000");
	КодОтправителя = "";
	КодПолучателя = "";
	РазмерТела = 0;
	Параметры = Новый Соответствие();
	
КонецПроцедуры

#КонецОбласти

#Область Инициализация

Инициализировать();

#КонецОбласти

#КонецЕсли
