unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids,
      ExtCtrls, DBCtrls, StdCtrls, DB, Grids, sqldb, sqlite3conn,
      Global;

type

  { TForm5 }

  TForm5 = class(TForm)
    SG: TStringGrid;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Simpan(Sender: TObject; aCol, aRow: Integer;
         const OldValue: string; var NewValue: String);

  private

  public
   ID5: Integer;
   i: Integer;
  end;

var
  Form5: TForm5;

implementation

{$R *.lfm}

{ TForm5 }

procedure Create_Header;
begin
   Form5.SG.Cells[0,0] := 'HID';
   Form5.SG.Cells[1,0] := 'Keluhan';
   Form5.SG.Cells[2,0] := 'Diagnosa';
   Form5.SG.Cells[3,0] := 'Pengobatan';
   Form5.SG.Cells[4,0] := 'Tanggal';
end;
procedure Create_Cells(Ind: Integer; Qry: TSQLQuery);
begin
Form5.SG.Cells[0,Ind] := Qry.FieldByName('h_id').AsString;
Form5.SG.Cells[1,Ind] := Qry.FieldByName('keluhan').AsString;
Form5.SG.Cells[2,Ind] := Qry.FieldByName('diagnos').AsString;
Form5.SG.Cells[3,Ind] := Qry.FieldByName('pengobatan').AsString;
Form5.SG.Cells[4,Ind] := CHari(Qry.FieldByName('tanggal').AsDateTime);
;
end;
procedure TForm5.FormShow(Sender: TObject);
var
  SCon : TSQLConnection;
  STran: TSQLTransaction;
  pQry : TSQLQuery;

begin
  SCon  := TSQLite3Connection.Create(nil);
  STran := TSQLTransaction.Create(SCon);
  SCon.Transaction := STran;
  SCon.DatabaseName:='datapas.db';
  pQry := TSQLQuery.Create(nil);
  pQry.SQL.Text := 'select * from pasien where p_id=:key';
  pQry.ParamByName('key').Value:=ID5;
  pQry.Database := Scon;
  pQry.Open;
  Edit1.Text:= IntToStr(ID5);
  Edit2.Text:=pQry.FieldByName('nomor').AsString;
  Edit3.Text:=pQry.FieldByName('nama').AsString;
  Edit4.Text:=pQry.FieldByName('alamat').AsString;
  Edit5.Text:=pQry.FieldByName('umur').AsString;
  Edit6.Text:=pQry.FieldByName('sex').AsString;
  Edit7.Text:=pQry.FieldByName('phone').AsString;
  Edit8.Text:=pQry.FieldByName('allergi').AsString;
  Edit9.Text:=pQry.FieldByName('riwayat').AsString;
  Edit10.Text:=pQry.FieldByName('keterangan').AsString;
  Edit11.Text:=CHari(pQry.FieldByName('waktu').AsDateTime);
  pQry.Close;
  pQry.Clear;
  pQry.SQL.Text := 'select * from history where p_id=:key';
  pQry.ParamByName('key').Value:=ID5;
  pQry.Open;
  SG.Clean;
  i:= 0;
  Create_Header;
  while not pQry.EOF do
  begin
     i := i + 1;
     Create_Cells(i, pQry);
     pQry.Next;
  end;
  pQry.Close;
  pQry.Free;
  STran.Free;
  SCon.Free;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  SG.Options:= SG.Options + [goEditing];
end;

procedure TForm5.Image1Click(Sender: TObject);
begin

end;

procedure TForm5.Simpan(Sender: TObject; aCol, aRow: Integer;
       const OldValue: string; var NewValue: String);
var
  SCon : TSQLConnection;
  STran: TSQLTransaction;
  pQry : TSQLQuery;
begin
//  Form5.Caption:=SG.Cells[2,1];
  SCon  := TSQLite3Connection.Create(nil);
  STran := TSQLTransaction.Create(SCon);
  SCon.Transaction := STran;
  SCon.DatabaseName:='datapas.db';
  pQry := TSQLQuery.Create(nil);
  Case aCol of
   1: begin
      pQry.SQL.Text := 'update history set keluhan=:kel where h_id=:hid';
      pQry.ParamByName('kel').Value:=SG.Cells[aCol,aRow];
   end;
   2: begin
      pQry.SQL.Text := 'update history set diagnos=:dia where h_id=:hid';
      pQry.ParamByName('dia').Value:=SG.Cells[aCol,aRow];
   end;
   3: begin
      pQry.SQL.Text := 'update history set pengobatan=:pob where h_id=:hid';
      pQry.ParamByName('pob').Value:=SG.Cells[aCol,aRow];
   end;
   4: begin
      pQry.SQL.Text := 'update history set tanggal=:tg where h_id=:hid';
      pQry.ParamByName('tg').Value:=StrToDate(SG.Cells[aCol,aRow]);
   end;
  end;
  pQry.ParamByName('hid').Value:=SG.Cells[0,aRow];
  pQry.DataBase:=SCon;
  pQry.ExecSQL;
  STran.Commit;
  pQry.Close;
  SCon.Close;
  pQry.Free;
  STran.Free;
  SCon.Free;
end;

end.

