program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  LCLTranslator,
  Forms, Unit1, Unit2, Unit3,
  fpspreadsheet, fpsTypes, xlsbiff8, fpsutils,
  sysutils, Unit4

  { you can add units after this };

{$R *.res}
procedure InitLang();
var
  MyWorkBook: TsWorkbook;
  MyWorkSheet: TsWorksheet;
begin
  MyWorkBook := TsWorkbook.Create();

  if (not FileExists('settings.xls')) then
  begin
    SetDefaultLang('en', '', True);
    exit();
  end;

  MyWorkBook.ReadFromFile('settings.xls', sfExcel8);

  MyWorkSheet := MyWorkBook.GetWorksheetByName('Form');
  if (MyWorkSheet.ReadAsText(2, 1) = 'en') then
    SetDefaultLang('en', '', True)
  else
    SetDefaultLang('ru', '', True);
end;

begin
  InitLang();
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TLoginForm, LoginForm);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.Run;
end.

