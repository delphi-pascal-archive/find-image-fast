unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtDlgs, ExtCtrls;

type
  FRes = record
    found: boolean;
    x,y: integer;
  end;
  
  TForm1 = class(TForm)
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    Image1: TImage;
    Image2: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function CompareIMG: FRes;
  end;
  TBuf = array of array of integer;

var
  Form1: TForm1;
  buf1, buf2: TBuf;

implementation

{$R *.dfm}

procedure LoagIMG(var buffer: TBuf; img: TImage; Name: String);
var
  x,y,c: integer;
  p: pByteArray;
begin
  img.Picture.LoadFromFile(Name);
  img.Picture.Bitmap.PixelFormat:=pf24Bit; // pf8Bit;
  SetLength(buffer, img.Height, img.Width);
  for y:=0 to img.Height-1 do begin
    p:=img.Picture.Bitmap.ScanLine[y];
    for x:=0 to img.Width-1 do begin
      c:=((p[x*3+0] shl 8+p[x*3+1]) shl 8)+p[x*3+2];
      buffer[y,x]:=c;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    LoagIMG(buf1, Image1, OpenPictureDialog1.FileName);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    LoagIMG(buf2, Image2, OpenPictureDialog1.FileName);
end;

function TForm1.CompareIMG: FRes;
var
  y, x, yy, xx: integer;
begin
  y:=0;
  repeat
    x:=0;
    repeat
      Result.found:=true;
      yy:=0;
      repeat
        xx:=0;
        repeat
          if buf1[y+yy, x+xx]<>buf2[yy,xx] then Result.found:=false;
          inc(xx);
        until (xx>=Image2.Width) or (Not Result.found);
        inc(yy);
      until (yy>=Image2.Height) or (Not Result.found);
      inc(x);
    until (x>Image1.Width-Image2.Width) or (Result.found);
    inc(y);
  until (y>Image1.Height-Image2.Height) or (Result.found);
  if Result.found then begin
    Result.x:=x-1;
    Result.y:=y-1;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  FindResult: FRes;
  SearchTime: cardinal;
  Freq, StartCount, EndCount: int64;
  HiResTimer: boolean;
begin
  if (Image1.Width<Image2.Width) or (Image1.Height<Image2.Height) then
    ShowMessage('Ошибка! Img1 меньше Img2')
  else begin
    Screen.Cursor:=crHourGlass;
    HiResTimer:=QueryPerformanceFrequency(Freq);
    if HiResTimer then QueryPerformanceCounter(StartCount) else SearchTime:=GetTickCount;
    FindResult:=CompareIMG;
    if HiResTimer then begin
      QueryPerformanceCounter(EndCount);
      SearchTime:=round((EndCount-StartCount)*1000/Freq);
    end else SearchTime:=GetTickCount-SearchTime;
    Screen.Cursor:=crDefault;
    if FindResult.found then begin
      with Image1.Picture.Bitmap.Canvas do begin
        Pen.Color:=clRed;
        MoveTo(FindResult.x, FindResult.y);
        LineTo(FindResult.x+Image2.Width-1, FindResult.y);
        LineTo(FindResult.x+Image2.Width-1, FindResult.y+Image2.Height-1);
        LineTo(FindResult.x, FindResult.y+Image2.Height-1);
        LineTo(FindResult.x, FindResult.y);
      end;
      ScrollBox1.HorzScrollBar.Position:=FindResult.x;
      ScrollBox1.VertScrollBar.Position:=FindResult.y;
      ShowMessage('Есть совпадение ;-)'+#10#13+'Время поиска: '+IntToStr(SearchTime)+' ms');
    end else ShowMessage('Нет совпвдений!');
  end;
end;

end.
