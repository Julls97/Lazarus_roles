library project2;

{$mode objfpc}{$H+}

uses
  Classes, pqconnection
  { you can add units after this };
function pgroles_add(pg: TPQConnection; userName: string): boolean; cdecl;
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

  function pgroles_rename(pg: TPQConnection;  cdecl;
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

  function pgroles_password(pg: TPQConnection; cdecl;
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

  function pgroles_delete(pg: TPQConnection; userName: string): boolean; cdecl;
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

exports
  pgroles_add,
  pgroles_rename,
  pgroles_password,
  pgroles_delete;

begin
end.

