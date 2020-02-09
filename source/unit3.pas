unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids,
      ExtCtrls, DBCtrls, StdCtrls, DB, sqldb, sqlite3conn,
      Global;

type

  { TForm3 }

  TForm3 = class(TForm)
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private

  public
   ID3: Integer;
  end;

var
  Form3: TForm3;

implementation

{$R *.lfm}

{ TForm3 }

procedure Periksa;
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
 pQry.SQL.Text := 'insert into history(p_id,keluhan,diagnos,pengobatan,tanggal)' +
            'values(:pid,:kel,:dia,:pob,:tg)';
 pQry.ParamByName('pid').Value:=Form3.Edit1.Text;
 pQry.ParamByName('kel').Value:=Form3.Edit12.Text;
 pQry.ParamByName('dia').Value:=Form3.Edit13.Text;
 pQry.ParamByName('pob').Value:=Form3.Edit15.Text;
 pQry.ParamByName('tg').Value:=StrToDate(Form3.Edit14.Text);
 pQry.DataBase:= SCon;
 pQry.ExecSQL;
 STran.Commit;
 pQry.Close;
 SCon.Close;
 pQry.Free;
 STran.Free;
 SCon.Free;
end;

procedure TForm3.FormShow(Sender: TObject);
var
  SCon : TSQLConnection;
  STran: TSQLTransaction;
  pQry : TSQLQuery;

begin
 Edit1.Text:= IntToStr(ID3);
 Edit14.Text:= hari;
 SCon  := TSQLite3Connection.Create(nil);
 STran := TSQLTransaction.Create(SCon);
 SCon.Transaction := STran;
 SCon.DatabaseName:='datapas.db';
 pQry := TSQLQuery.Create(nil);
 pQry.SQL.Text := 'select * from pasien where p_id=:key';
 pQry.ParamByName('key').Value:=ID3;
 pQry.Database := Scon;
 pQry.Open;
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
 pQry.Free;
 STran.Free;
 SCon.Free;
end;

procedure TForm3.Image2Click(Sender: TObject);
begin
  if MessageDlg('Menyimpan data', 'Mau menyimpan data?', mtConfirmation,
    [mbYes, mbNo, mbIgnore],0) = mrYes
  then
    try
      Periksa;
    except
      ShowMessage('Ada yang belum diisi!');
    end;
end;
end.

