//**************************************
// SVLIB - ����� ������� ��� SOLARIS V6
// Vladimir T. Sabitov
// ������ 2011.10.05
//**************************************
function svlib_ScanBadSeries(storage:integer):string;
	var
		info: string;
		t1,t2,t3: TDateTime;
	begin
		t1:=now;
		info:=ScanBadSeries_full(true, storage);
		t2:=now;
		t3:=t2-t1;
		Result:='����� ������ ������������: '+timetostr(t1)+#13+'����� ��������� ������������: '+timetostr(t2)+#13+'�����, ����������� �� ������������: '+timetostr(t3)+#13#13+info;
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
		CreateHintI('����� ������ ������������: '+timetostr(t1)+#13+'����� ��������� ������������: '+timetostr(t2)+#13+'�����, ����������� �� ������������: '+timetostr(t3)+#13#13+info,'svlib_pScanBadSeries');
	end;

function svlib_SendMail(Recipient:string; Subject:string; Body:string):string;

	var
		Agents : Variant;	// ������������ ��� �������� ����� ����� MailProcessor
		MailMessage : Variant;	// ������������ ��� �������� ����� ����� MailProcessor

	begin
		Agents := CreateOleObject('mailprocessor.addressbook');
		MailMessage := CreateOleObject('mailprocessor.mpmailmessage');
		Agents.SRV.ConnectWP('������������','1');
		if not Agents.srv.connected	then
			begin
				Result:='�� ���� �������������� � MailProcessor.';
				exit;
			end;
		MailMessage.ID := 0;
		MailMessage.Recipient := Recipient ;
		MailMessage.Subject := Subject;
		MailMessage.Body := Body;
		MailMessage.Save;
		Result:='��������� ��������� � MailProcessor';
	end;	

procedure svlib_pSendMail(Recipient:string; Subject:string; Body:string);

	var
		Agents : Variant;	// ������������ ��� �������� ����� ����� MailProcessor
		MailMessage : Variant;	// ������������ ��� �������� ����� ����� MailProcessor

	begin
		Agents := CreateOleObject('mailprocessor.addressbook');
		MailMessage := CreateOleObject('mailprocessor.mpmailmessage');
		Agents.SRV.ConnectWP('������������','1');
		if not Agents.srv.connected	then
			begin
				CreateHintE('�� ���� �������������� � MailProcessor','svlib_pSendMail');
				exit;
			end;
		MailMessage.ID := 0;
		MailMessage.Recipient := Recipient ;
		MailMessage.Subject := Subject;
		MailMessage.Body := Body;
		MailMessage.Save;
		CreateHintI('��������� ��������� � MailProcessor','svlib_pSendMail');
	end;	
	
function svlib_SendMailATT(Recipient:string; Subject:string; Body:string; Attachment:string):string;

	var
		Agents : Variant;	// ������������ ��� �������� ����� ����� MailProcessor
		MailMessage : Variant;	// ������������ ��� �������� ����� ����� MailProcessor

	begin
		Agents := CreateOleObject('mailprocessor.addressbook');
		MailMessage := CreateOleObject('mailprocessor.mpmailmessage');
		Agents.SRV.ConnectWP('������������','1');
		if not Agents.srv.connected	then
			begin
				Result:='�� ���� �������������� � MailProcessor.';
				exit;
			end;
		MailMessage.ID := 0;
		MailMessage.Recipient := Recipient ;
		MailMessage.Subject := Subject;
		MailMessage.Body := Body;
		MailMessage.AddAttachment(Attachment);
		MailMessage.Save;
		Result:='��������� ��������� � MailProcessor';
	end;	

procedure svlib_pSendMailATT(Recipient:string; Subject:string; Body:string; Attachment:string);

	var
		Agents : Variant;	// ������������ ��� �������� ����� ����� MailProcessor
		MailMessage : Variant;	// ������������ ��� �������� ����� ����� MailProcessor

	begin
		Agents := CreateOleObject('mailprocessor.addressbook');
		MailMessage := CreateOleObject('mailprocessor.mpmailmessage');
		Agents.SRV.ConnectWP('������������','1');
		if not Agents.srv.connected	then
			begin
				CreateHintE('�� ���� �������������� � MailProcessor','svlib_pSendMail');
				exit;
			end;
		MailMessage.ID := 0;
		MailMessage.Recipient := Recipient ;
		MailMessage.Subject := Subject;
		MailMessage.Body := Body;
		MailMessage.AddAttachment(Attachment);
		MailMessage.Save;
		CreateHintI('��������� ��������� � MailProcessor','svlib_pSendMail');
	end;	

function svlib_QueryToFile(Sql:string; QueryFile:string; Format:TDataPacketFormat = dfBinary):string; // ������� ��������� ��������� SQL ������� � ����. 	
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
		InfoStart:='������� ���������� SQL ������� � ����';
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

		CDS.SaveToFile(QueryFile,Format); // ��������� ������� � ���� dfBinary,dfXML,dfXMLUTF8
		InfoEnd:='���� '+QueryFile+' ������� ��������';

		Query.Free;
		Stream.Free;
		CDS.Free;
		T2:=now;
		T3:=T2-T1;
		Result:=InfoStart+#13#13+'����� ������: '+TimeToStr(T1)+#13+'����� ���������: '+TimeToStr(T2)+#13+'�����, �����������: '+TimeToStr(T3)+#13#13+InfoEnd;
	end;

function svlib_GetDefaultStorage:Integer;
	begin
		Result := appinifile.readinteger('common','currentsklad',0); // �������� ����� ������ �� ���������
	end;

procedure svlib_pLogFile(LogFile:String; LogText:String);	
// ��������� ������ � �������
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
	// �������� CreateHintI('���������� �������','svLib for Solaris',10);
end.