﻿//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2024 BIA-Technologies Limited Liability Company
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

///////////////////////////////////////////////////////////////////
// Содержит методы по работе с файлами
///////////////////////////////////////////////////////////////////
#Область ПрограммныйИнтерфейс

// Проверяет существование файла
// 
// Параметры:
//  ПутьКФайлу - Строка
//  Обработчик - ОписаниеОповещения - Обработчик асинхронного получения свойства файла. Если обработчик указан, но проверка выполняется асинхронно.
//             - Неопределено - Проверка выполняется синхронно.
// 
// Возвращаемое значение:
//  Булево - Существует
Функция Существует(ПутьКФайлу, Обработчик = Неопределено) Экспорт
	
	Файл = Новый Файл(ПутьКФайлу);
	
#Если Клиент Тогда
	Если Обработчик = Неопределено Тогда
		Возврат Файл.Существует();
	Иначе
		Файл.НачатьПроверкуСуществования(Обработчик);
	КонецЕсли;
#Иначе
	Возврат Файл.Существует();
#КонецЕсли
	
КонецФункции

// Проверяет, что по указанному пути находится каталог
// 
// Параметры:
//  ПутьКФайлу - Строка
//  Обработчик - ОписаниеОповещения - Обработчик асинхронного получения свойства файла. Если обработчик указан, но проверка выполняется асинхронно.
//             - Неопределено - Проверка выполняется синхронно.
// 
// Возвращаемое значение:
//  Булево - Это каталог
Функция ЭтоКаталог(ПутьКФайлу, Обработчик = Неопределено) Экспорт
	
	Файл = Новый Файл(ПутьКФайлу);
	
#Если Клиент Тогда
	Если Обработчик <> Неопределено Тогда
		ОбработчикПолученияАтрибута = ОбработчикПолученияАтрибута(Файл, "ЭтоКаталог", Обработчик, Ложь);
		Файл.НачатьПроверкуСуществования(ОбработчикПолученияАтрибута);
		
		Возврат Неопределено;
	КонецЕсли;
#КонецЕсли
	
	Возврат Файл.Существует() И Файл.ЭтоКаталог();
	
КонецФункции

// Возвращает путь к вложенному элементу
// 
// Параметры:
//  Путь1 - Строка - базовый путь к каталогу
//  Путь2 - Строка - относительный путь к вложенному элементу
//  Путь3 - Строка - относительный путь к вложенному элементу
//  Путь4 - Строка - относительный путь к вложенному элементу
//  Путь5 - Строка - относительный путь к вложенному элементу
// 
// Возвращаемое значение:
//  Строка - Объединенный путь
Функция ОбъединитьПути(Путь1, Путь2, Путь3 = Неопределено, Путь4 = Неопределено, Путь5 = Неопределено) Экспорт
	
	Разделитель = ПолучитьРазделительПути();
	
	Результат = ДополнитьПуть(Путь1, Путь2, Разделитель);
	
	Если Путь3 <> Неопределено Тогда
		Результат = ДополнитьПуть(Результат, Путь3, Разделитель);
	КонецЕсли;
	
	Если Путь4 <> Неопределено Тогда
		Результат = ДополнитьПуть(Результат, Путь4, Разделитель);
	КонецЕсли;
	
	Если Путь5 <> Неопределено Тогда
		Результат = ДополнитьПуть(Результат, Путь5, Разделитель);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Удаляет файлы
// 
// Параметры:
//  Файлы - Массив из Файл
//        - Массив из Строка
Процедура УдалитьВременныеФайлы(Файлы) Экспорт
	
	Если НЕ ЗначениеЗаполнено(Файлы) Тогда
		Возврат;
	КонецЕсли;
	
	Ошибки = Новый Массив();
	
	Для Каждого УдаляемыйФайл Из Файлы Цикл
		
		Если ТипЗнч(УдаляемыйФайл) = Тип("Строка") Тогда
			УдаляемыйФайл = Новый Файл(УдаляемыйФайл);
		КонецЕсли;
		
		Попытка
			Если УдаляемыйФайл.Существует() Тогда
				
				Если УдаляемыйФайл.ПолучитьТолькоЧтение() Тогда
					УдаляемыйФайл.УстановитьТолькоЧтение(Ложь);
				КонецЕсли;
				
				УдалитьФайлы(УдаляемыйФайл.ПолноеИмя); // BSLLS:UsingSynchronousCalls-off
				
			КонецЕсли;
		Исключение
			
			Ошибки.Добавить(ЮТРегистрацияОшибокСлужебный.ПредставлениеОшибки("Удаление файла " + УдаляемыйФайл, ИнформацияОбОшибке()));
			
		КонецПопытки;
		
	КонецЦикла;
	
	Если ЗначениеЗаполнено(Ошибки) Тогда
		ВызватьИсключение СтрСоединить(Ошибки, Символы.ПС);
	КонецЕсли;
	
КонецПроцедуры

// Выполняет рекурсивное копирование каталога
// 
// Параметры:
//  КаталогИсточник - Строка - Каталог источник
//  КаталогПриемник - Неопределено, Строка - Каталог приемник
Процедура СкопироватьКаталог(КаталогИсточник, КаталогПриемник) Экспорт
	
	Если НЕ Существует(КаталогПриемник) Тогда
		СоздатьКаталог(КаталогПриемник); // BSLLS:UsingSynchronousCalls-off
	КонецЕсли;
	
	Для Каждого Файл Из НайтиФайлы(КаталогИсточник, "*") Цикл // BSLLS:UsingSynchronousCalls-off
		
		Если СтрСравнить(Файл.ПолноеИмя, КаталогИсточник) = 0 Тогда
			Продолжить;
		ИначеЕсли Файл.ЭтоКаталог() Тогда
			СкопироватьКаталог(Файл.ПолноеИмя, ОбъединитьПути(КаталогПриемник, Файл.Имя));
		Иначе
			КопироватьФайл(Файл.ПолноеИмя, ОбъединитьПути(КаталогПриемник, Файл.Имя)); // BSLLS:UsingSynchronousCalls-off
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура СоздатьКаталогРекурсивно(Путь) Экспорт
	
	Файл = Новый Файл(Путь);
	
	Если Файл.Существует() Тогда
		Возврат;
	КонецЕсли;
	
	СоздатьКаталогРекурсивно(Файл.Путь);
	
	СоздатьКаталог(Файл.ПолноеИмя); // BSLLS:UsingSynchronousCalls-off
	
КонецПроцедуры

Процедура СоздатьРодительскийКаталог(Путь) Экспорт
	
	Файл = Новый Файл(Путь);
	
	Если Файл.Существует() Тогда
		Возврат;
	КонецЕсли;
	
	СоздатьКаталогРекурсивно(Файл.Путь);
	
КонецПроцедуры

// Возвращает содержимое текстового файла
// 
// Параметры:
//  ИмяФайла - Строка - Имя файла
// 
// Возвращаемое значение:
//  Строка, Неопределено - Данные текстового файла
Функция ДанныеТекстовогоФайла(ИмяФайла) Экспорт
	
#Если НЕ ВебКлиент Тогда
	Чтение = Новый ЧтениеТекста;
	Чтение.Открыть(ИмяФайла, "UTF-8");
	Текст = Чтение.Прочитать();
	Чтение.Закрыть();
	
	Возврат Текст;
#Иначе
	ВызватьИсключение "Чтение данных текстовых файлов в веб-клиенте не поддерживается";
#КонецЕсли
	
КонецФункции

// Сохраняет данные в текстовый файла
// 
// Параметры:
//  ИмяФайла - Строка - Имя файла
//  Данные - Строка - Данные
Процедура ЗаписатьТекстВФайла(ИмяФайла, Данные) Экспорт
	
#Если НЕ ВебКлиент Тогда
	Запись = Новый ЗаписьТекста(ИмяФайла, "UTF-8");
	Запись.Записать(Данные);
	Запись.Закрыть();
	
#Иначе
	ВызватьИсключение "Запись данных текстовых файлов в веб-клиенте не поддерживается";
#КонецЕсли
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Если Клиент Тогда
Функция ОбработчикПолученияАтрибута(Файл, ИмяАтрибута, Обработчик, ЗначениеПоУмолчанию = Неопределено)
	
	Параметры = Новый Структура("Файл, ИмяАтрибута, Обработчик", Файл, ИмяАтрибута, Обработчик);
	Параметры.Вставить("ЗначениеПоУмолчанию", ЗначениеПоУмолчанию);
	
	Возврат Новый ОписаниеОповещения("ПолучитьАтрибутФайла", ЭтотОбъект, Параметры);
	
КонецФункции

Процедура ПолучитьАтрибутФайла(Результат, Параметры) Экспорт
	
	Если НЕ Результат Тогда
		ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьОбработчик(Параметры.Обработчик, Параметры.ЗначениеПоУмолчанию);
		Возврат;
	КонецЕсли;
	
	Если Параметры.ИмяАтрибута = "ЭтоКаталог" Тогда
		Параметры.Файл.НачатьПроверкуЭтоКаталог(Параметры.Обработчик);
	КонецЕсли;
	
КонецПроцедуры
#КонецЕсли

Функция ДополнитьПуть(Путь1, Путь2, Разделитель)
	
	Результат = Неопределено;
	
	Если ЗначениеЗаполнено(Путь1) И ЗначениеЗаполнено(Путь2) Тогда
		
		Если НЕ СтрЗаканчиваетсяНа(Путь1, Разделитель) И НЕ СтрНачинаетсяС(Разделитель, Путь2) Тогда
			Результат = СтрШаблон("%1%2%3", Путь1, Разделитель, Путь2);
		Иначе
			Результат = Путь1 + Путь2;
		КонецЕсли;
		
	ИначеЕсли ЗначениеЗаполнено(Путь1) Тогда
		Результат = Путь1;
	Иначе
		Результат = Путь2;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
