unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids,
      ExtCtrls, DBCtrls, StdCtrls, Grids, DB, sqldb, sqlite3conn,
      Unit2, Unit3, Unit4, Unit5, Global;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    SG1: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
  private

  public
    i: Integer;

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}



{ TForm1 }

procedure Create_Header;
begin
   Form1.SG1.Cells[0,0] := 'ID';
   Form1.SG1.Cells[1,0] := 'Nomor';
   Form1.SG1.Cells[2,0] := 'Nama';
   Form1.SG1.Cells[3,0] := 'Alamat';
   Form1.SG1.Cells[4,0] := 'Umur';
   Form1.SG1.Cells[5,0] := 'Sex';
   Form1.SG1.Cells[6,0] := 'Phone';
   Form1.SG1.Cells[7,0] := 'Allergi';
   Form1.SG1.Cells[8,0] := 'Riwayat';
   Form1.SG1.Cells[9,0] := 'Keterangan';
   Form1.SG1.Cells[10,0] := 'Pertama';
end;

procedure Create_Cells(Ind: Integer; Qry: TSQLQuery);
begin
Form1.SG1.Cells[0,Ind] := Qry.FieldByName('p_id').AsString;
Form1.SG1.Cells[1,Ind] := Qry.FieldByName('nomor').AsString;
Form1.SG1.Cells[2,Ind] := Qry.FieldByName('nama').AsString;
Form1.SG1.Cells[3,Ind] := Qry.FieldByName('alamat').AsString;
Form1.SG1.Cells[4,Ind] := Qry.FieldByName('umur').AsString;
Form1.SG1.Cells[5,Ind] := Qry.FieldByName('sex').AsString;
Form1.SG1.Cells[6,Ind] := Qry.FieldByName('phone').AsString;
Form1.SG1.Cells[7,Ind] := Qry.FieldByName('allergi').AsString;
Form1.SG1.Cells[8,Ind] := Qry.FieldByName('riwayat').AsString;
Form1.SG1.Cells[9,Ind] := Qry.FieldByName('keterangan').AsString;
Form1.SG1.Cells[10,Ind] := CHari(Qry.FieldByName('waktu').AsDateTime);
end;

procedure TForm1.FormShow(Sender: TObject);
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
   pQry.SQL.Text := 'select * from pasien';
   pQry.Database := Scon;
   pQry.Open;
   SG1.Clean;
   SG1.TitleFont.Color:=clRed;
   SG1.TitleFont.Style:=[fsBold];
   i := 0;
   Create_Header;
   while not pQry.EOF do
   begin
      i := i + 1;
      Create_Cells(i, pQry);
      pQry.Next;
   end;
   pQry.Close;
   SCon.Close;
   pQry.Free;
   STran.Free;
   SCon.Free;
end;

procedure TForm1.Image1Click(Sender: TObject);
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
     pQry.Params.CreateParam(ftString, 'k_nama', ptInput);
     pQry.SQL.Text := 'select * from pasien where nama like :k_nama';
     pQry.ParamByName('k_nama').Value:='%' + Edit1.Text + '%';
     pQry.Database := SCon;
     pQry.Open;
     SG1.Clean;
     SG1.TitleFont.Color:=clRed;
     SG1.TitleFont.Style:=[fsBold];
     i := 0;
     Create_Header;
     while not pQry.EOF do
     begin
        i := i + 1;
        Create_Cells(i, pQry);
        pQry.Next;
     end;
     pQry.Close;
     SCon.Close;
     pQry.Free;
     STran.Free;
     SCon.Free;
  end;

procedure TForm1.Image2Click(Sender: TObject);
begin
   Form2.Visible:=True;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
 if Edit2.Text<>'' then
  begin
    Form3.ID3:= StrToInt(Edit2.Text);
    Form3.Visible:=True;
  end
 else
  begin
   ShowMessage('ID belum diisi!');
  end
end;

procedure TForm1.Image4Click(Sender: TObject);
begin
 if Edit2.Text<>'' then
  begin
    Form4.ID4:= StrToInt(Edit2.Text);
    Form4.Visible:=True;
  end
 else
  begin
    ShowMessage('ID belum diisi!');
  end
 end;

procedure TForm1.Image5Click(Sender: TObject);
begin
 if Edit2.Text<>'' then
  begin
   Form5.ID5:= StrToInt(Edit2.Text);
   Form5.Visible:=True;
  end
 else
  begin
    ShowMessage('ID belum diisi!');
  end
end;


end.

