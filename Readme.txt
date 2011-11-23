Библиотека функций svLib for Solaris

Префикс svlib_ используется для того чтобы избежать путаницы в использовании функций.

svlib_ScanBadSeries(storage:integer):string;
	storage - Номер склада
функция возвращает строку в которой содержится информация о времени и результатах выполнения работает в версиях solaris, выпущенных после 15.09.2011


svlib_SendMail(Recipient:string; Subject:string; Body:string):string;
Функция отправляет сообщение через mailprocessor, возвращает строку с сообщение об отправке
	Recipient - кому
	Subject - Тема
	Body - Тело сообщения

svlib_pSendMail(Recipient:string; Subject:string; Body:string):string;
Процедура отправляет сообщение через mailprocessor
	Recipient - кому
	Subject - Тема
	Body - Тело сообщения

function svlib_SendMailATT(Recipient:string; Subject:string; Body:string; Attachment:string):string;
Функция отправляет сообщение через mailprocessor со вложением
	Recipient - кому
	Subject - Тема
	Body - Тело сообщения
	Attachment - Вложение

procedure svlib_pSendMailATT(Recipient:string; Subject:string; Body:string; Attachment:string);
Процедура отправляет сообщение через mailprocessor со вложением
	Recipient - кому
	Subject - Тема
	Body - Тело сообщения
	Attachment - Вложение


svlib_Logfile(имя файла, текст); - Процедура