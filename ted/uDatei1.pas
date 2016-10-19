unit uDatei1;
{Autor: Jan H. Krüger
 Kurs: TED Tutor: Herr Brauburger
 Datum: 23.10.2000
 Funktion: Berechnung von Termen über einen selbsterstellten Stack}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids,Buttons,UStack, UElement, ExtCtrls, Menus, ComCtrls;

type
  Tfrmmain = class(TForm)
    cbxterme: TComboBox;
    gitter_rechenweg: TStringGrid;
    gitter_stack: TStringGrid;
    lblstack: TLabel;
    lblRechenweg: TLabel;
    menue: TMainMenu;
    Datei: TMenuItem;
    Bearbeiten1: TMenuItem;
    Hilfe: TMenuItem;
    TermAuswerten1: TMenuItem;
    NeuenTermberechnen1: TMenuItem;
    Beenden1: TMenuItem;
    btnBerechnen: TButton;
    btnnewterm: TButton;
    Autor1: TMenuItem;
    Funktion1: TMenuItem;
    stbstatus: TStatusBar;
    Rechenwegspeichern1: TMenuItem;
    svdlg_Speichern: TSaveDialog;
    procedure  FormDestroy(Sender: TObject);
    procedure  FormCreate(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure TermAuswerten1Click(Sender: TObject);
    procedure NeuenTermberechnen1Click(Sender: TObject);
    procedure btnBerechnenClick(Sender: TObject);
    procedure btnnewtermClick(Sender: TObject);
    procedure Funktion1Click(Sender: TObject);
    procedure Autor1Click(Sender: TObject);
    procedure btnBerechnenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnnewtermMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure gitter_stackMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure gitter_rechenwegMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure Rechenwegspeichern1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmmain                                    : Tfrmmain;
  term                                       : string;
  zaehler_a, zaehler_b, zaehler_c, zaehler_d : integer;
  stack                                      : tstack;

implementation

uses jokerform;
{$R *.DFM}

procedure umwandlung;
var inhalt        : tinhalt;
    zeilenzaehler : integer;
begin
  zeilenzaehler := 0;
  while not stack.leer do
    begin
      stack.pop(inhalt);
      frmmain.gitter_stack.Cells[0,zeilenzaehler] := (inhalt);
      zeilenzaehler                               := zeilenzaehler + 1;
    end;
end;

procedure rechnen;
 var term_string                                         : string;
     zaehler1, laenge_term, klammerzaehler, zeilenzaehler1 , zeilenzaehler2 : integer;
begin
 //auswahl der rechenoperation und anschließende durchführung
 if frmmain.gitter_stack.cells[0,1] = '+' then frmmain.gitter_stack.Cells[0,3] := floattostr((strtofloat( frmmain.gitter_stack.Cells[0,2]))+(strtofloat( frmmain.gitter_stack.Cells[0,0])));
 if frmmain.gitter_stack.cells[0,1] = '-' then frmmain.gitter_stack.Cells[0,3] := floattostr((strtofloat( frmmain.gitter_stack.Cells[0,2]))-(strtofloat( frmmain.gitter_stack.Cells[0,0])));
 if frmmain.gitter_stack.cells[0,1] = '*' then frmmain.gitter_stack.Cells[0,3] := floattostr((strtofloat( frmmain.gitter_stack.Cells[0,2]))*(strtofloat( frmmain.gitter_stack.Cells[0,0])));
 if frmmain.gitter_stack.cells[0,1] = '/' then frmmain.gitter_stack.Cells[0,3] := floattostr((strtofloat( frmmain.gitter_stack.Cells[0,2]))/(strtofloat( frmmain.gitter_stack.Cells[0,0])));
 klammerzaehler := zaehler_b;
 laenge_term  := length( frmmain.cbxterme.text);
 while klammerzaehler <= 0 do begin
  if term[klammerzaehler] ='(' then klammerzaehler:=0;
  dec (klammerzaehler);
 end;
 zeilenzaehler1 := 0;
 zeilenzaehler2 := 3;
 while zeilenzaehler1 <= 100 do begin
  frmmain.gitter_stack.Cells[0, zeilenzaehler1] := frmmain.gitter_stack.Cells[0, zeilenzaehler2];
  inc (zeilenzaehler1);
  inc (zeilenzaehler2);
 end;
 while zaehler_b >= 0 do begin
  term_string := (term_string)+ frmmain.gitter_stack.cells[0,zaehler_b];
  zaehler_b := zaehler_b - 1;
 end;
 zaehler1 := zaehler_a + 2;
 while laenge_term >= zaehler1 do begin
  term_string := (term_string) + term[zaehler1];
  inc (zaehler1);
 end;
 frmmain.cbxterme.text := term_string;
end;

procedure Durchlauf;
//verantwortlich für rechenschritte und stack
var term2                           : string;
    position_in_term, zaehler, flag : integer;
    Inhalt                          : Tinhalt;
begin
  stack.free;
  frmmain.gitter_stack.cols[0].clear;
  if zaehler_c = 0 then frmmain.cbxterme.text := frmmain.cbxterme.text;
  term := frmmain.cbxterme.text ;
  frmmain.gitter_rechenweg.cells[0,zaehler_c] := term;
  zaehler_a := length(frmmain.cbxterme.text);
  inc (zaehler_c);
  position_in_term := 0;
  zaehler          := 0;
  flag             := 0;
  while zaehler <= 200 do begin
   if term[zaehler]= ')'then begin
      zaehler_a := zaehler - 1;
      zaehler_b := zaehler - 1;
      zaehler := 200;
    end;
    inc (zaehler);
  end;
  while position_in_term <= zaehler_a do begin
    if term[position_in_term] in ['0','1','2','3','4','5','6','7','8','9'] then begin  {Zahl oder Zeichen?}
       term2  := term2 + term[position_in_term];
       inhalt := term2;
       flag := 1;
    end;
    if term[position_in_term] in ['(',')','+','-','/','*'] then begin  {Abfrage welche Rechenartgebraucht wird}
      term2 := '';
      if flag = 1 then begin
         flag := 0;
         stack.push(inhalt);
      end;
      inhalt := (term[position_in_term]);
      stack.push(inhalt);
    end;
    position_in_term := position_in_term+1;
  end;
    stack.push(inhalt);
    umwandlung;
end;

procedure Tfrmmain.FormDestroy(Sender: TObject);
begin
  stack.free;
end;

procedure Tfrmmain.FormCreate(Sender: TObject);
//stack wird angelegt
begin
  stack := tstack.create;
end;

procedure Tfrmmain.Beenden1Click(Sender: TObject);
begin
  close;
end;

procedure berechne_den_term;
var
  position, zaehler : integer;
begin
  if zaehler_d = 1 then zaehler_d := zaehler_d + 1;
  zaehler   :=0;
  position  :=0;
  while position <= 50 do begin
    if frmmain.cbxterme.text[position] = ')' then zaehler := 1;
    inc(position);
  end;
  if zaehler = 1 then begin
    zaehler := zaehler + 1;
    if zaehler = 2 then durchlauf;
    zaehler := zaehler + 1;
    if zaehler = 3 then rechnen;
  end;
end;

procedure Tfrmmain.btnBerechnenClick(Sender: TObject);
begin
  berechne_den_term;
end;

procedure Tfrmmain.TermAuswerten1Click(Sender: TObject);
begin
  berechne_den_term;
end;

procedure new_term;
//bereitmachen des programms um neuen term auszurechnen
begin
  frmmain.cbxterme.text:=('');
  stack.free;
  frmmain.gitter_stack.cols[0].clear;;
  frmmain.gitter_rechenweg.cols[0].clear;
  zaehler_d := 1;
  zaehler_c := 0;
end;

procedure Tfrmmain.NeuenTermberechnen1Click(Sender: TObject);
begin
  new_term;
end;

procedure Tfrmmain.btnnewtermClick(Sender: TObject);
begin
  new_term;
end;

procedure Tfrmmain.Funktion1Click(Sender: TObject);
begin
  frmInfo.Show;
end;

procedure Tfrmmain.Autor1Click(Sender: TObject);
begin
   showmessage ('Jan H. Krüger');
end;

procedure Tfrmmain.btnBerechnenMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  stbstatus.simpletext := 'Hier können sie den Term schrittweise berechnen.'
end;

procedure Tfrmmain.btnnewtermMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  stbstatus.simpletext := 'Neue Terme berechnen.'
end;

procedure Tfrmmain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  stbstatus.simpletext := ''
end;

procedure Tfrmmain.gitter_stackMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  stbstatus.simpletext := 'Hier steht der Inhalt des Stacks.'
end;

procedure Tfrmmain.gitter_rechenwegMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  stbstatus.simpletext := 'Der Rechenweg zur Berechnung des Termes.'
end;

procedure Tfrmmain.Rechenwegspeichern1Click(Sender: TObject);
begin
   if svdlg_Speichern.Execute then gitter_rechenweg.cols[0].SavetoFile (svdlg_Speichern.Filename);
end;

end.
