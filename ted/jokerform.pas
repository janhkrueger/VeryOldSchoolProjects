unit jokerform;
{Autor: Jan H. Krüger
 Kurs: TED Tutor: Herr Brauburger
 Datum: 23.10.2000
 Funktion: Berechnung von Termen über einen selbsterstellten Stack}
 
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmInfo = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnok: TButton;
    procedure btnokClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmInfo: TfrmInfo;

implementation

{$R *.DFM}

procedure TfrmInfo.btnokClick(Sender: TObject);
begin
  frmInfo.close;
end;

end.
