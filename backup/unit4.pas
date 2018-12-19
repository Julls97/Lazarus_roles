unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, pqconnection;

implementation
//function pgroles_add(pg: TPQConnection; userName: string): boolean;
//  cdecl; external 'libpgroles.so';

function pgroles_add(pg: TPQConnection; userName: string): boolean; //cdecl; external 'libproject2.so';
function pgroles_rename(pg: TPQConnection; userNameOld, userNameNew: string): boolean; //cdecl; external 'libproject2.so';
function pgroles_password(pg: TPQConnection; userName, password: string): boolean; //cdecl; external 'libproject2.so';
function pgroles_delete(pg: TPQConnection; userName: string): boolean; //cdecl; external 'libproject2.so';

function pgroles_add(pg: TPQConnection; userName: string): boolean;
  begin
    if (userName <> '') then
    begin
      pg.ExecuteDirect('CREATE USER "' + userName + '";');
      pg.Transaction.Commit();
      Result := True;
    end
    else
      Result := False;
  end;

  function pgroles_rename(pg: TPQConnection;
    userNameOld, userNameNew: string): boolean;
  begin
    if (userNameOld <> '') and (userNameNew <> '') then
    begin
      pg.ExecuteDirect('ALTER ROLE "' + userNameOld + '" RENAME TO "' +
        userNameNew + '";');
      pg.Transaction.Commit();
      Result := True;
    end
    else
      Result := False;
  end;

  function pgroles_password(pg: TPQConnection;
    userName, password: string): boolean;
  begin
    if (userName <> '') and (password <> '') then
    begin
      pg.ExecuteDirect('ALTER ROLE "' + userName + '" PASSWORD ''' + password + ''';');
      pg.Transaction.Commit();
      Result := True;
    end
    else
      Result := False;
  end;

  function pgroles_delete(pg: TPQConnection; userName: string): boolean;
  begin
    if (userName <> '') then
    begin
      pg.ExecuteDirect('DROP ROLE "' + userName + '";');
      pg.Transaction.Commit();
      Result := True;
    end
    else
      Result := False;
end;

end.

