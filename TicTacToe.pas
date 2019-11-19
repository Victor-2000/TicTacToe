program TicTacToe;

uses graph,crt;

type
  grid = array[1..3, 1..3] of 0..2;

const WRONGCO = 'Wrong coordinates, rewrite them:';

var
  Gd, Gm, X, Y, CX, CY, r, i: Integer;
  P: string;
  tab: grid;
  c,b: char;

procedure DrawGrid(var tab: grid);
var
  i, j: integer;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      tab[i, j] := 0;
  SetColor(white);
  Line(x div 10, y div 3, x - (x div 10), y div 3);
  Line(x div 10, y - (y div 3), x - (x div 10), y - (y div 3));
  Line(x div 3 + 50, y div 10, x div 3 + 50, y - y div 10);
  Line(x - x div 3 - 50, y div 10, x - x div 3 - 50, y - y div 10);
end;

procedure Oturn(var tab: grid);
var
  xp, yp: integer;
begin
  writeln('It is O turn now.');
  readln(xp, yp);
  while (xp < 1) or (xp > 3) or (yp < 1) or (yp > 3) do
  begin
    writeln(WRONGCO);
    readln(xp, yp);
  end;
  while tab[xp, yp] <> 0 do
  begin
    writeln(WRONGCO);
    readln(xp, yp);
  end;
  tab[xp, yp] := 2;
  SetColor(blue);
  case xp of
    1:
      case yp of
                        //Circles from the left part of the grid
        1: Circle(x div 4 - 20, y div 6, r);
        2: Circle(x div 4 - 20, y div 2, r);
        3: Circle(x div 4 - 20, y - y div 6, r);
      end;
    2:
      case yp of
                        //Circles from the middle part of the grid
        1: Circle(x div 2 + 5, y div 6, r);
        2: Circle(x div 2 + 5, y div 2, r);
        3: Circle(x div 2 + 5, y - y div 6, r);
      end;
    3:
      case yp of
                        //Circles from the right part of the grid
        1: Circle(x - x div 4 + 20, y div 6, r);
        2: Circle(x - x div 4 + 20, y div 2, r);
        3: Circle(x - x div 4 + 20, y - y div 6, r);
      end;
  end;
end;

procedure mux;//Drawing function for middle up x
begin
  line(x div 2 - r, y div 6 - r, x div 2 + r, y div 6 + r); line(x div 2 - r, y div 6 + r, x div 2 + r, y div 6 - r);
end;

procedure mmx;//Middle middle x
begin
  line(x div 2 - r, y div 2 - r, x div 2 + r, y div 2 + r); line(x div 2 - r, y div 2 + r, x div 2 + r, y div 2 - r);
end;

procedure mdx;//Middle down x
begin
  line(x div 2 - r, y - y div 6 - r, x div 2 + r, y - y div 6 + r); line(x div 2 - r, y - y div 6 + r, x div 2 + r, y - y div 6 - r);
end;

procedure lux;//Left up x
begin
  line(x div 4 - 20 - r, y div 6 - r, x div 4 - 20 + r, y div 6 + r); line(x div 4 - 20 - r, y div 6 + r, x div 4 - 20 + r, y div 6 - r);
end;

procedure lmx;//Left middle x
begin
  line(x div 4 - 20 - r, y div 2 - r, x div 4 - 20 + r, y div 2 + r); line(x div 4 - 20 - r, y div 2 + r, x div 4 - 20 + r, y div 2 - r);
end;

procedure ldx;//Left down x
begin
  line(x div 4 - 20 - r, y - y div 6 - r, x div 4 - 20 + r, y - y div 6 + r); line(x div 4 - 20 - r, y - y div 6 + r, x div 4 - 20 + r, y - y div 6 - r);
end;

procedure rux;//Right up x
begin
  line(x - x div 4 + 20 - r, y div 6 - r, x - x div 4 + 20 + r, y div 6 + r); line(x - x div 4 + 20 - r, y div 6 + r, x - x div 4 + 20 + r, y div 6 - r);
end;

procedure rmx;//Right middle x
begin
  line(x - x div 4 + 20 - r, y div 2 - r, x - x div 4 + 20 + r, y div 2 + r); line(x - x div 4 + 20 - r, y div 2 + r, x - x div 4 + 20 + r, y div 2 - r);
end;

procedure rdx;//Right down x
begin
  line(x - x div 4 + 20 - r, y - y div 6 - r, x - x div 4 + 20 + r, y - y div 6 + r); line(x - x div 4 + 20 - r, y - y div 6 + r, x - x div 4 + 20 + r, y - y div 6 - r);
end;

procedure Xturn(var tab: grid);
var
  xp, yp: integer;
begin
  writeln('It is X turn now.');
  readln(xp, yp);
  while (xp < 1) or (xp > 3) or (yp < 1) or (yp > 3) do
  begin
    writeln('');
    readln(xp, yp);
  end;
  while tab[xp, yp] <> 0 do
  begin
    writeln(WRONGCO);
    readln(xp, yp);
  end;
  tab[xp, yp] := 1;
  SetColor(red);
  case xp of
    1:
      case yp of
                        //left x-es
        1: lux;
        2: lmx;
        3: ldx;
      end;
    2:
      case yp of
                        //midddle x-es
        1: mux;
        2: mmx;
        3: mdx;
      end;
    3:
      case yp of
                        //right x-es
        1: rux;
        2: rmx;
        3: rdx;
      end;
  end;
end;

procedure WinCondition(tab: grid; var i: integer);
var
  w: char;
begin
  if tab[1, 1] <> 0 then begin
    if tab[1, 1] = 1 then
      w := 'X'
    else
      w := 'O';
    if ((tab[1, 1] = tab[1, 2]) and (tab[1, 2] = tab[1, 3])) then
    begin
      i := 8;
      setColor(white);
      line(x div 4 - 20, y div 6 - r, x div 4 - 20, y - y div 6 + r);
      writeln('Congratulations ', w, ' you won!!!');
      exit;
    end;
    if ((tab[1, 1] = tab[2, 1]) and (tab[2, 1] = tab[3, 1])) then
    begin
      i := 8;
      setColor(white);
      line(x div 4 - 20 - r, y div 6, x - x div 4 + 20 + r, y div 6);
      writeln('Congratulations ', w, ' you won!!!');
      exit;
    end;
    if ((tab[1, 1] = tab[2, 2]) and (tab[2, 2] = tab[3, 3])) then
    begin
      i := 8;
      setColor(white);
      line(x div 4 - 20, y div 6, x - x div 4 + 20, y - y div 6);
      writeln('Congratulations ', w, ' you won!!!');
      exit;
    end;
  end;
  if tab[3, 3] <> 0 then begin
    if tab[3, 3] = 1 then
      w := 'X'
    else
      w := 'O';
    if ((tab[3, 3] = tab[3, 2]) and (tab[3, 2] = tab[3, 1])) then
    begin
      i := 8;
      setColor(white);
      line(x - x div 4 + 20, y div 6 - r, x - x div 4 + 20, y - y div 6 + r);
      writeln('Congratulations ', w, ' you won!!!');
      exit;
    end;
    if ((tab[3, 3] = tab[2, 3]) and (tab[2, 3] = tab[1, 3])) then
    begin
      i := 8;
      setColor(white);
      line(x div 4 - 20, y - y div 6, x - x div 4 + 20, y - y div 6);
      writeln('Congratulations ', w, ' you won!!!');
      exit;
    end;
  end;
  if tab[2, 2] <> 0 then begin
    if tab[2, 2] = 1 then
      w := 'X'
    else
      w := 'O';
    if ((tab[2, 2] = tab[2, 3]) and (tab[2, 2] = tab[2, 1])) then
    begin
      i := 8;
      setColor(white);
      line(x div 2, y div 6 - 20 - r, x div 2, y - y div 6 + 20 + r);
      writeln('Congratulations ', w, ' you won!!!');
      exit;
    end;
    if ((tab[2, 2] = tab[1, 2]) and (tab[2, 2] = tab[3, 2])) then
    begin
      i := 8;
      setColor(white);
      line(x div 4 - 20 - r, y div 2, x - x div 4 + 20 + r, y div 2);
      writeln('Congratulations ', w, ' you won!!!');
      exit;
    end;
    if ((tab[3, 1] = tab[2, 2]) and (tab[2, 2] = tab[1, 3])) then
    begin
      i := 8;
      setColor(white);
      line(x - x div 4 + 20, y div 6 - r, x div 4 - 20, y - y div 6 + r);
      writeln('Congratulations ', w, ' you won!!!');
      exit;
    end;
  end;
end;

begin
  InitGraph(Gd, Gm, P);
  //GetMaxY,GetMaxX - give the resolution of the window
  x := GetMaxX;
  y := GetMaxY;
  r := 110;
  c := 'r';
  while c = 'r' do
  begin
    writeln('Welcome to my tic-tac-toe game!');
    writeln('Made by Victor Ciobanu');
    writeln('For choosing a position please select the y and x coordinate of the grid.');
    writeln('Where y is height(can be 1-3) and x is the length(can be 1-3) and the origin point is in the top left.');
    DrawGrid(tab);
    i := 0;
    while i < 9 do
    begin
      if i mod 2 = 0 then
        Xturn(tab)
      else
        Oturn(tab);
      if i > 2 then
        WinCondition(tab, i);
      i := i + 1;
    end;
    writeln('Game over. For resetting the game press r, for ending the game press enter.');
    readln(c);
    writeln('Do you want me to delete the log history of the previous game?(type y if you want or enter if you do not)');
    readln(b);
    if b = 'y' then
      clrscr;
    ClearDevice;
  end;
  CloseGraph;
end.
