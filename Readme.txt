���������� ������� svLib for Solaris

������� svlib_ ������������ ��� ���� ����� �������� �������� � ������������� �������.

svlib_ScanBadSeries(storage:integer):string;
	storage - ����� ������
������� ���������� ������ � ������� ���������� ���������� � ������� � ����������� ���������� �������� � ������� solaris, ���������� ����� 15.09.2011


svlib_SendMail(Recipient:string; Subject:string; Body:string):string;
������� ���������� ��������� ����� mailprocessor, ���������� ������ � ��������� �� ��������
	Recipient - ����
	Subject - ����
	Body - ���� ���������

svlib_pSendMail(Recipient:string; Subject:string; Body:string):string;
��������� ���������� ��������� ����� mailprocessor
	Recipient - ����
	Subject - ����
	Body - ���� ���������

function svlib_SendMailATT(Recipient:string; Subject:string; Body:string; Attachment:string):string;
������� ���������� ��������� ����� mailprocessor �� ���������
	Recipient - ����
	Subject - ����
	Body - ���� ���������
	Attachment - ��������

procedure svlib_pSendMailATT(Recipient:string; Subject:string; Body:string; Attachment:string);
��������� ���������� ��������� ����� mailprocessor �� ���������
	Recipient - ����
	Subject - ����
	Body - ���� ���������
	Attachment - ��������


svlib_Logfile(��� �����, �����); - ���������