unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids,
      ExtCtrls, DBCtrls, StdCtrls, DB, sqldb, sqlite3conn, Global;

type

  { TForm4 }

  TForm4 = class(TForm)
    CB1: TComboBox;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Image1: TImage;
    Image2: TImage;
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
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private

  public
   ID4: Integer;
  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}

{ TForm4 }

procedure Ubah;
var
  SCon : TSQLConnection;
  STran: TSQLTransaction;
  pQry : TSQLQuery;

begin
  SCon:= TSQLite3Connection.Create(nil);
  Stran:= TSQLTransaction.Create(SCon);
  SCon.Transaction:= STran;
  SCon.DatabaseName:='datapas.db';
  pQry:= TSQLQuery.Create(nil);
  pQry.SQL.Text := 'update pasien set nomor=:no, nama=:nm, ' +
        'alamat=:al, umur=:um, sex=:sx, phone=:ph, allergi=:ai, ' +
        'riwayat=:rw, keterangan=:kt, waktu=:wa where p_id = :key';
  pQry.ParamByName('no').Value:=Form4.Edit2.Text;
  pQry.ParamByName('nm').Value:=Form4.Edit3.Text;
  pQry.ParamByName('al').Value:=Form4.Edit4.Text;
  pQry.ParamByName('um').Value:=Form4.Edit5.Text;
  pQry.ParamByName('sx').Value:= Form4.CB1.Text;
  pQry.ParamByName('ph').Value:=Form4.Edit7.Text;
  pQry.ParamByName('ai').Value:=Form4.Edit8.Text;
  pQry.ParamByName('rw').Value:=Form4.Edit9.Text;
  pQry.ParamByName('kt').Value:=Form4.Edit10.Text;
  pQry.ParamByName('wa').Value:= StrToDate(Form4.Edit11.Text);
  pQry.ParamByName('key').Value:= Form4.ID4;
  pQry.DataBase:= SCon;
  Stran.StartTransaction;
  pQry.ExecSQL;
  Stran.Commit;
  pQry.Close;
  pQry.Free;
  STran.Free;
  SCon.Free;
  Form4.Close;
end;

procedure TForm4.FormShow(Sender: TObject);
var
  SCon : TSQLConnection;
  STran: TSQLTransaction;
  pQry : TSQLQuery;
  s: String;
begin
  CB1.Items.Add('P');
  CB1.Items.Add('W');
  Edit1.Text:=IntToStr(ID4);
  SCon  := TSQLite3Connection.Create(nil);
  STran := TSQLTransaction.Create(SCon);
  SCon.Transaction := STran;
  SCon.DatabaseName:='datapas.db';
  pQry := TSQLQuery.Create(nil);
  pQry.SQL.Text := 'select * from pasien where p_id=:key';
  pQry.ParamByName('key').Value:=ID4;
  pQry.Database := Scon;
  pQry.Open;
  Edit2.Text:=pQry.FieldByName('nomor').AsString;
  Edit3.Text:=pQry.FieldByName('nama').AsString;
  Edit4.Text:=pQry.FieldByName('alamat').AsString;
  Edit5.Text:=pQry.FieldByName('umur').AsString;
  Edit7.Text:=pQry.FieldByName('phone').AsString;
  Edit8.Text:=pQry.FieldByName('allergi').AsString;
  Edit9.Text:=pQry.FieldByName('riwayat').AsString;
  Edit10.Text:=pQry.FieldByName('keterangan').AsString;
  s:=pQry.FieldByName('sex').AsString;
  Case s of
    'P': CB1.ItemIndex:=0;
    'W': CB1.ItemIndex:=1;
  end;
  s:=CHari(pQry.FieldByName('waktu').AsDateTime);
  Edit11.Text:=s;
  pQry.Close;
  pQry.Free;
  STran.Free;
  SCon.Free;
end;

procedure TForm4.Image1Click(Sender: TObject);
begin
  if MessageDlg('Mengubah data', 'Mau mengubah data?', mtConfirmation,
  [mbYes, mbNo, mbIgnore],0) = mrYes
  then
    try
      Ubah;
    except
      ShowMessage('Ada yang salah, coba periksa!');
    end;
end;

procedure TForm4.Image2Click(Sender: TObject);
var
  SCon : TSQLConnection;
  STran: TSQLTransaction;
  pQry : TSQLQuery;

begin
  if MessageDlg('Menghapus data', 'Mau menghapus data?', mtConfirmation,
  [mbYes, mbNo, mbIgnore],0) = mrYes
  then
   begin
     SCon  := TSQLite3Connection.Create(nil);
     STran := TSQLTransaction.Create(SCon);
     SCon.Transaction := STran;
     SCon.DatabaseName:='datapas.db';
     pQry := TSQLQuery.Create(nil);
     pQry.SQL.Text := 'delete from pasien where p_id=:key';
     pQry.ParamByName('key').Value:=ID4;
     pQry.DataBase:= SCon;
     Stran.StartTransaction;
     pQry.ExecSQL;
     Stran.Commit;
     pQry.Close;
     pQry.Free;
     STran.Free;
     SCon.Free;
     Form4.Close;
   end;
end;

end.


