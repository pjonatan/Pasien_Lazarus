unit Unit2;

{$mode objfpc}{$H+}

interface



uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids,
      ExtCtrls, DBCtrls, StdCtrls, DB, sqldb, sqlite3conn, Global;
type

  { TForm2 }

  TForm2 = class(TForm)
    CB1: TComboBox;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Image1: TImage;
    Image2: TImage;
    Panel1: TPanel;
    Panel10: TPanel;
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

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure Simpan;
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
 pQry.SQL.Text := 'insert into pasien(nomor,nama,alamat,umur,sex,phone,allergi,riwayat,keterangan,waktu) values(:no,:nm,:ala,:umu,:kel,:ph,:all,:riw,:ket,:wa)';
 pQry.ParamByName('no').Value:=Form2.Edit1.Text;
 pQry.ParamByName('nm').Value:=Form2.Edit2.Text;
 pQry.ParamByName('ala').Value:=Form2.Edit3.Text;
 pQry.ParamByName('umu').Value:=Form2.Edit4.Text;
 pQry.ParamByName('kel').Value:=Form2.CB1.Items[Form2.CB1.ItemIndex];
 pQry.ParamByName('ph').Value:=Form2.Edit6.Text;
 pQry.ParamByName('all').Value:=Form2.Edit7.Text;
 pQry.ParamByName('riw').Value:=Form2.Edit8.Text;
 pQry.ParamByName('ket').Value:=Form2.Edit9.Text;
 pQry.ParamByName('wa').Value:=StrToDate(Form2.Edit10.Text);
 pQry.DataBase:= SCon;
 pQry.ExecSQL;
 STran.Commit;
 pQry.Close;
 SCon.Close;
 pQry.Free;
 STran.Free;
 SCon.Free;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
   Edit10.Text:= hari;
   CB1.Items.Add('P');
   CB1.Items.Add('W');
end;

procedure TForm2.Image1Click(Sender: TObject);
begin
 if MessageDlg('Menyimpan data', 'Mau menyimpan data?', mtConfirmation,
   [mbYes, mbNo, mbIgnore],0) = mrYes
 then
   try
     Simpan;
   except
     ShowMessage('Ada yang belum diisi atau dipilih!');
  end;
end;
procedure TForm2.Image2Click(Sender: TObject);
begin
  Edit1.Text:= '';
  Edit2.Text:= '';
  Edit3.Text:= '';
  Edit4.Text:= '';
  Edit6.Text:= '';
  Edit7.Text:= '';
  Edit8.Text:= '';
  Edit9.Text:= '';
end;

end.

