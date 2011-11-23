//**************************************
// SVLIB - НАБОР ФУНКЦИЙ ДЛЯ SOLARIS V6
// Vladimir T. Sabitov
// ВЕРСИЯ 2011.10.05
//**************************************
function svlib_ScanBadSeries(storage:integer):string; // Поиск забракованных серий
	var
		info: string;
		t1,t2,t3: TDateTime;
	begin
		t1:=now;
		info:=ScanBadSeries_full(true, storage);
		t2:=now;
		t3:=t2-t1;
		Result:='Время начала сканирования: '+timetostr(t1)+#13+'Время окончания сканирования: '+timetostr(t2)+#13+'Время, затраченное на сканирование: '+timetostr(t3)+#13#13+info;
	end;

procedure svlib_pScanBadSeries(storage:integer);
	var
		info: string;
		t1,t2,t3: TDateTime;
	begin
		t1:=now;
		info:=ScanBadSeries_full(true, storage);
		t2:=now;
		t3:=t2-t1;
		CreateHintI('Время начала сканирования: '+timetostr(t1)+#13+'Время окончания сканирования: '+timetostr(t2)+#13+'Время, затраченное на сканирование: '+timetostr(t3)+#13#13+info,'svlib_pScanBadSeries');
	end;

function svlib_SendMail(Recipient:string; Subject:string; Body:string):string;

	var
		Agents : Variant;	// Используется для отправки писем через MailProcessor
		MailMessage : Variant;	// Используется для отправки писем через MailProcessor

	begin
		Agents := CreateOleObject('mailprocessor.addressbook');
		MailMessage := CreateOleObject('mailprocessor.mpmailmessage');
		Agents.SRV.ConnectWP('Пользователь','1');
		if not Agents.srv.connected	then
			begin
				Result:='Не могу присоединиться а MailProcessor.';
				exit;
			end;
		MailMessage.ID := 0;
		MailMessage.Recipient := Recipient ;
		MailMessage.Subject := Subject;
		MailMessage.Body := Body;
		MailMessage.Save;
		Result:='Сообщение сохранено в MailProcessor';
	end;	

procedure svlib_pSendMail(Recipient:string; Subject:string; Body:string);

	var
		Agents : Variant;	// Используется для отправки писем через MailProcessor
		MailMessage : Variant;	// Используется для отправки писем через MailProcessor

	begin
		Agents := CreateOleObject('mailprocessor.addressbook');
		MailMessage := CreateOleObject('mailprocessor.mpmailmessage');
		Agents.SRV.ConnectWP('Пользователь','1');
		if not Agents.srv.connected	then
			begin
				CreateHintE('Не могу присоединиться к MailProcessor','svlib_pSendMail');
				exit;
			end;
		MailMessage.ID := 0;
		MailMessage.Recipient := Recipient ;
		MailMessage.Subject := Subject;
		MailMessage.Body := Body;
		MailMessage.Save;
		CreateHintI('Сообщение сохранено в MailProcessor','svlib_pSendMail');
	end;	
	
function svlib_SendMailATT(Recipient:string; Subject:string; Body:string; Attachment:string):string;

	var
		Agents : Variant;	// Используется для отправки писем через MailProcessor
		MailMessage : Variant;	// Используется для отправки писем через MailProcessor

	begin
		Agents := CreateOleObject('mailprocessor.addressbook');
		MailMessage := CreateOleObject('mailprocessor.mpmailmessage');
		Agents.SRV.ConnectWP('Пользователь','1');
		if not Agents.srv.connected	then
			begin
				Result:='Не могу присоединиться к MailProcessor.';
				exit;
			end;
		MailMessage.ID := 0;
		MailMessage.Recipient := Recipient ;
		MailMessage.Subject := Subject;
		MailMessage.Body := Body;
		MailMessage.AddAttachment(Attachment);
		MailMessage.Save;
		Result:='Сообщение сохранено в MailProcessor';
	end;	

procedure svlib_pSendMailATT(Recipient:string; Subject:string; Body:string; Attachment:string);

	var
		Agents : Variant;	// Используется для отправки писем через MailProcessor
		MailMessage : Variant;	// Используется для отправки писем через MailProcessor

	begin
		Agents := CreateOleObject('mailprocessor.addressbook');
		MailMessage := CreateOleObject('mailprocessor.mpmailmessage');
		Agents.SRV.ConnectWP('Пользователь','1');
		if not Agents.srv.connected	then
			begin
				CreateHintE('Не могу присоединиться к MailProcessor','svlib_pSendMail');
				exit;
			end;
		MailMessage.ID := 0;
		MailMessage.Recipient := Recipient ;
		MailMessage.Subject := Subject;
		MailMessage.Body := Body;
		MailMessage.AddAttachment(Attachment);
		MailMessage.Save;
		CreateHintI('Сообщение сохранено в MailProcessor','svlib_pSendMail');
	end;	

function svlib_QueryToFile(Sql:string; QueryFile:string; Format:TDataPacketFormat = dfBinary):string; // Функция сохраняет результат SQL запроса в файл. 	
// Format: dfBinary,dfXML,dfXMLUTF8
	var
		Query : TQuery;
		CDS : TClientDataset;
		Stream	: TMemoryStream;
		FilePath: string;
		FileNameWithoutExt: string;
		FileExt: string;
		T1,T2,T3: TDateTime;
		InfoStart, InfoEnd: string;

	
	begin
		T1:=now;
		InfoStart:='Функция сохранения SQL запроса в файл';
		Query := TQuery.create(nil);
		Query.Sql.Text := Sql;
		Query.Databasename := 'dbkassa';
		Query.Open;

		CDS:= TClientDataset.Create(nil);
		ReadDataSet(CDS, Query);

		FilePath := ExtractFilePath(QueryFile);
		FileNameWithoutExt := ExtractFileNameWithoutExt(QueryFile);
		FileExt := ExtractFileExt(QueryFile);

		Stream := TMemoryStream.create;

		CDS.SaveToFile(QueryFile,Format); // Сохраняем датасет в файл dfBinary,dfXML,dfXMLUTF8
		InfoEnd:='Файл '+QueryFile+' успешно сохранен';

		Query.Free;
		Stream.Free;
		CDS.Free;
		T2:=now;
		T3:=T2-T1;
		Result:=InfoStart+#13#13+'Время начала: '+TimeToStr(T1)+#13+'Время окончания: '+TimeToStr(T2)+#13+'Время, затраченное: '+TimeToStr(T3)+#13#13+InfoEnd;
	end;

function svlib_GetDefaultStorage:Integer; // Возвращает номер склада по умолчанию
	begin
		Result := appinifile.readinteger('common','currentsklad',0); // Получаем номер склада по умолчанию
	end;

procedure svlib_pLogFile(LogFile:String; LogText:String);	
// Процедура записи в логфайл
	var
		LogF:TLogFile;

	begin
		LogF:=TLogFile.Create(LogFile,false);
		try
			LogF.AddStr(LogText);
		finally
			LogF.Free;
		end;
	end;


	
begin
	// заглушка CreateHintI('Библиотека функций','svLib for Solaris',10);
end.