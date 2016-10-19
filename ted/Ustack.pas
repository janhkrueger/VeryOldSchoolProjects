unit Ustack;
{Autor: Jan H. Krüger
 Kurs: TED Tutor: Herr Brauburger
 Datum: 23.10.2000
 Funktion: Berechnung von Termen über einen selbsterstellten Stack}
 
interface
uses UElement1;
 type
  TStack =class
    Public
  anfang:TElement;
  VAnzahl:integer;

    constructor create;
    procedure push(inhalt:TInhalt);
    procedure pop (var inhalt :tinhalt);
    function  leer:boolean;
    function  voll:boolean;
    procedure top(var inhalt:tinhalt);
    procedure free;
    procedure umwandlung;
  end;
implementation
 uses Dialogs,uDatei1;

constructor TStack.create;
begin
  Anfang:=nil;
  VAnzahl:=0;
end;

procedure tstack.Push(inhalt:TInhalt);
var stack:TElement;
begin
  if  not voll then
    begin
      stack:=TElement.create;
      stack.inhalt:=inhalt;
      stack.next:=anfang;
      anfang:=stack;
      Vanzahl:=Vanzahl+1;
    end
  else
    showmessage('Stack voll');
end;

procedure tstack.pop (var inhalt:tinhalt);
var stack:TElement;
begin
  if not leer then begin
    stack:=anfang;
    inhalt:=stack.inhalt;
    Anfang:=stack.next;
    stack.free;
    Vanzahl:=Vanzahl-1;
  end;
end;

function tstack.leer :boolean;
begin
  leer:=anfang=nil;
end;

function tstack.voll:boolean;
begin
  voll:=Vanzahl=40;
end;

procedure tstack.top(var inhalt:tinhalt);
begin
  if leer then showmessage('Stack ist leer')
else
  inhalt:=Anfang.Inhalt;
end;

procedure Tstack.free;
var inhalt:tinhalt;
begin
  while not leer do
    begin
      pop(inhalt);
    end;
end;

procedure Tstack.umwandlung;
var inhalt:tinhalt;
    a:integer;
begin
  a:=0;
  while not leer do
    begin
      pop(inhalt);
      form1.stack1.Cells[0,a]:= (inhalt);
      a:=a+1;
    end;
  end;
end.
