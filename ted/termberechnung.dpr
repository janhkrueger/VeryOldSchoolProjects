program termberechnung;

uses
  Forms,
  uDatei1 in 'uDatei1.pas' {frmmain},
  UElement in 'UElement.pas',
  Ustack in 'D:\PROGRAMME\ICQ\RECEIVED FILES\[IB] ß¢ÙrﬁÃÙ—\Ustack.pas',
  jokerform in 'jokerform.pas' {frminfo};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfrmmain, frmmain);
  Application.CreateForm(Tfrminfo, frminfo);
  Application.Run;
end.
