unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, Unit2, Unit3, LCLProc, LazHelpHTML, UTF8Process;

type

  { TLoginForm }

  TLoginForm = class(TForm)
    BitBtnCancel: TBitBtn;
    BitBtnOK: TBitBtn;
    BitBtnSettings: TBitBtn;
    EditLogin: TEdit;
    EditPassword: TEdit;
    ImageBG: TImage;
    Login: TStaticText;
    Password: TStaticText;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnSettingsClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure RefreshSettings();
  public

  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.lfm}
procedure TLoginForm.FormShow(Sender: TObject);
begin
  RefreshSettings();
end;

procedure TLoginForm.RefreshSettings();
begin
  Font := SettingsForm.FontDialogFont.Font;
  Color := SettingsForm.ColorDialogForm.Color;
  if FileExists(SettingsForm.OpenBGDialog.FileName) then
    ImageBG.Picture.LoadFromFile(SettingsForm.OpenBGDialog.FileName)
  else
    ImageBG.Picture.Clear();
end;

procedure TLoginForm.BitBtnOKClick(Sender: TObject);
begin
      MainForm.PQConnection1.UserName := EditLogin.Text;
      MainForm.PQConnection1.Password := EditPassword.Text;
      MainForm.Show();
      Hide();
end;

procedure TLoginForm.BitBtnSettingsClick(Sender: TObject);
begin
      SettingsForm.ShowModal();
      RefreshSettings();
end;

procedure TLoginForm.Button1Click(Sender: TObject);
var
    v: THTMLBrowserHelpViewer;
    BrowserPath, BrowserParams: string;
    p: LongInt;
    URL: String;
    BrowserProcess: TProcessUTF8;
begin
  v:=THTMLBrowserHelpViewer.Create(nil);
    try
      v.FindDefaultBrowser(BrowserPath,BrowserParams);
      debugln(['Path=',BrowserPath,' Params=',BrowserParams]);

      URL:='http://www.lazarus.freepascal.org';
      p:=System.Pos('%s', BrowserParams);
      System.Delete(BrowserParams,p,2);
      System.Insert(URL,BrowserParams,p);

      // запуск браузера
      BrowserProcess:=TProcessUTF8.Create(nil);
      try
        BrowserProcess.CommandLine:=BrowserPath+' '+BrowserParams;
        BrowserProcess.Execute;
      finally
        BrowserProcess.Free;
      end;
    finally
      v.Free;
    end;
  //OpenURL('file:///home/jull/Загрузки/SUSU/roles/web_help/help1.html');
    //OpenURL('http://google.com');
end;

procedure TLoginForm.BitBtnCancelClick(Sender: TObject);
begin
      Application.Terminate();
end;

end.

