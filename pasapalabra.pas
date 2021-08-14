program Pasapalabra;
uses crt;
{Este programa es una versión simplificada del juego Pasapalabra, consistente en acertar la mayor
cantidad de palabras posibles, de las cuales cada una se corresponde con una letra del rosco para 
la que se ofrece una definición relativa a un concepto.

*ACLARACIONES*
-En una partida se enfrentan dos participantes.
-Se considera partida finalizada cuando uno de los dos jugadores no tiene preguntas pendientes en su rosco.
-Se verifica que los roscos de los jugadores sean distintos.
-Se controla que los nombres de usuario de los jugadores sean diferentes.
-En caso de empate, no se suman partidas ganadas a ningun jugador.
-En palabras donde se encuentre el caracter 'ñ', se debe reemplazar 'ñ' por 'ni'}

//DEFINICIÓN DE CONSTANTES Y TIPOS
const
    DirecJugadores= '/ip2/piabedini-jugadores.dat';
    DirecPalabras= '/ip2/palabras.dat';
    MaxJugadores= 1;
    InicioLetra= 1;
    FinLetra= 26;
    CantLetras= 26;

type
    TRta= (Pendiente,Acertada,Errada);

    ListaCircular= ^NodoRosco;
    NodoRosco= record
        Letra: Char;
        Palabra: String;
        Consigna: String;
        Rta: TRta;
        Sig: ListaCircular
    end;
    
    TArbolJugadores= ^NodoJugadores;
    NodoJugadores= record
        Nombre: Shortstring;
        PartidasGanadas: Integer;
        Menores: TArbolJugadores;
        Mayores: TArbolJugadores
    end;
    
    Reg_jugador= record
        Nombre: Shortstring;
        PartidasGanadas: Integer
    end;
    
    TArchivoJugadores= File of Reg_jugador;
    
    Reg_palabra= record
        Nro_set: Integer;
        Letra: Char;
        Palabra: String;
        Consigna: String
    end;
    
    TArchivoPalabras= File of Reg_palabra;
    
    Reg_partida= record
        Nombre: Shortstring;
        Rosco: ListaCircular
    end;
    
    TArregloPartida= array[0..MaxJugadores] of Reg_partida;


{--------------------------------------ABRIR ARCHIVO-------------------------------------}
//EXISTE ARCHIVO?
{Función que determina si está creado el archivo}
function ExisteArchivo(var ArchivoJugadores: TArchivoJugadores): Boolean;
begin
    {$I-}
    Reset(ArchivoJugadores);
    {$I+}
    ExisteArchivo:= (IOResult = 0);
end;

//ABRIR ARCHIVO
{Si el archivo existe, lo abre. Si no existe, lo crea y luego lo abre}
procedure AbrirArchivo(var ArchivoJugadores: TArchivoJugadores);
begin
    if ExisteArchivo(ArchivoJugadores) = True then
        Reset(ArchivoJugadores)
    else
        Rewrite(ArchivoJugadores);
end;


{--------------------------------------CREAR ARBOL---------------------------------------}
//CREAR NODO ARBOL
{Procedimiento que crea un nodo en el árbol}
procedure CrearNodoArbol(var Nodo: TArbolJugadores; Usuario: Shortstring; PartidasGanadas: Integer);
begin
    New(Nodo);
    Nodo^.Nombre:= Usuario;
    Nodo^.PartidasGanadas:= PartidasGanadas;
    Nodo^.Menores:= nil;
    Nodo^.Menores:= nil;
end;

//INSERTAR ORDENADO EN ARBOL
{Procedimiento que inserta un nodo ordenado por nombre de usuario en el árbol}
procedure InsertarOrdenadoEnArbol(var ArbolJugadores: TArbolJugadores; Nodo: TArbolJugadores);
begin
    if (ArbolJugadores = nil) then
        ArbolJugadores:= Nodo
    else
        if (Nodo^.Nombre < ArbolJugadores^.Nombre) then
            InsertarOrdenadoEnArbol(ArbolJugadores^.Menores,Nodo)
        else
            InsertarOrdenadoEnArbol(ArbolJugadores^.Mayores,Nodo);
end;


//CREAR ARBOL
{Recorre el archivo y por cada jugador encontrado crea un nodo y lo inserta ordenado en el árbol.
Si el archivo no existe, no crea ni carga nada en el árbol}
procedure CrearArbol(var ArchivoJugadores: TArchivoJugadores; var ArbolJugadores: TArbolJugadores);
var Nodo: TArbolJugadores;
    RegistroJugador: Reg_jugador;
begin
    if ExisteArchivo(ArchivoJugadores) then
    begin
        AbrirArchivo(ArchivoJugadores);
        while not Eof(ArchivoJugadores) do
        begin
            Read(ArchivoJugadores,RegistroJugador);
            CrearNodoArbol(Nodo,RegistroJugador.Nombre,RegistroJugador.PartidasGanadas);
            InsertarOrdenadoEnArbol(ArbolJugadores,Nodo);
        end;
        Close(ArchivoJugadores);
    end;
end;


{--------------------------------------EJECUTAR MENU---------------------------------------}

{**********************AGREGAR JUGADOR*********************}

//ESTÁ EN ARBOL?
{Función booleana que determina si un usuario está en el árbol o no}
function EstaEnArbol(ArbolJugadores: TArbolJugadores; Usuario: Shortstring): Boolean;
begin
    if ArbolJugadores = nil then
        EstaEnArbol:= False
    else
        if Usuario < ArbolJugadores^.Nombre then
            EstaEnArbol:= EstaEnArbol(ArbolJugadores^.Menores,Usuario)
        else
            if Usuario > ArbolJugadores^.Nombre then
                EstaEnArbol:= EstaEnArbol(ArbolJugadores^.Mayores,Usuario)
            else
                EstaEnArbol:= True;
end;

//INSERTAR EN FINAL DE ARCHIVO
{Recibe un nodo de un jugador, crea un registro con los datos del jugador que están en el nodo 
y lo agrega al final del archivo de jugadores}
procedure InsertarEnFinalDeArchivo(var ArchivoJugadores: TArchivoJugadores; Nodo: TArbolJugadores);
var RegistroJugador: Reg_jugador;
begin
    RegistroJugador.Nombre:= Nodo^.Nombre;
    RegistroJugador.PartidasGanadas:= Nodo^.PartidasGanadas;
    AbrirArchivo(ArchivoJugadores);
    Seek(ArchivoJugadores,FileSize(ArchivoJugadores));
    Write(ArchivoJugadores,RegistroJugador);
    Close(ArchivoJugadores);
end;

//AGREGAR JUGADOR
{Procedimiento que pide un nombre de usuario y si el jugador ingresado no está en el árbol jugadores, lo agrega al árbol y luego al archivo}
procedure AgregarJugador(var ArchivoJugadores: TArchivoJugadores; var ArbolJugadores: TArbolJugadores);
var Usuario: Shortstring;
    Nodo: TArbolJugadores;
begin
    Writeln('Ingrese el nombre del nuevo jugador: ');
    Readln(Usuario);
    if not EstaEnArbol(ArbolJugadores,Usuario) then
    begin
        CrearNodoArbol(Nodo,Usuario,0);
        InsertarOrdenadoEnArbol(ArbolJugadores,Nodo);
        InsertarEnFinalDeArchivo(ArchivoJugadores,Nodo);
    end
    else
        Writeln('Error: Nombre de usuario en uso. ');
end;

{**********************VER JUGADORES*********************}

//VER JUGADORES
{Para ver los jugadores cargados en el árbol, se imprime el mismo in orden}
Procedure VerJugadores(ArbolJugadores: TArbolJugadores);
begin
    if (ArbolJugadores <> nil) then
    begin
        VerJugadores(ArbolJugadores^.Menores);
        Write('Nombre del jugador: ');
        Write(ArbolJugadores^.Nombre);
        Write(' - Cantidad de partidas ganadas: ');
        Writeln(ArbolJugadores^.PartidasGanadas);
        VerJugadores(ArbolJugadores^.Mayores);
    end;
end;

{**************************JUGAR*************************}

{==========CARGAR JUGADORES==========}

//ES VÁLIDO EL JUGADOR?
{Función booleana que verifica si el usuario está en el árbol de jugadores. De ser así, el jugador es válido,
y si el usuario no está en el árbol, el jugador no es válido}
function EsValidoElJugador(ArbolJugadores: TArbolJugadores; Usuario: Shortstring; NumDeUsuario: Integer): Boolean;
begin
    if EstaEnArbol(ArbolJugadores,Usuario) then
        EsValidoElJugador:= True
    else
    begin
        Writeln('Error: el nombre del jugador ingresado no esta registrado. ');
        EsValidoElJugador:= False;
    end;
end;

//CARGAR JUGADORES
{Solicita los nombres de los usuarios a jugar, crea un registro por jugador con el nombre de usuario y el puntero al rosco
correspondiente, y se los agrega al arreglo de la partida}
procedure CargarJugadores(ArbolJugadores: TArbolJugadores; var ArregloPartida: TArregloPartida; var SonJugadoresValidos: Boolean);
var Usuario1, Usuario2: Shortstring;
    RegistroUsuario1, RegistroUsuario2: Reg_partida;
begin
    SonJugadoresValidos:= False;
    Write('Ingrese el nombre del jugador 1: ');
    Readln(Usuario1);
    if EsValidoElJugador(ArbolJugadores,Usuario1,1) then
    begin
        Write('Ingrese el nombre del jugador 2: ');
        Readln(Usuario2);
        if EsValidoElJugador(ArbolJugadores,Usuario2,2) then
            if Usuario1 <> Usuario2 then
            begin
                RegistroUsuario1.Nombre:= Usuario1;
                RegistroUsuario2.Nombre:= Usuario2;
                ArregloPartida[0]:= RegistroUsuario1;
                ArregloPartida[1]:= RegistroUsuario2;
                SonJugadoresValidos:= True;
            end;
    end;
end;

{==========CARGAR ROSCO==========}

//CREAR NODO ROSCO
{Procedimiento que crea un nodo en una lista circular}
procedure CrearNodoRosco(var Nodo: ListaCircular; RegistroPalabra: Reg_palabra);
begin
    New(Nodo);
    Nodo^.Letra:= RegistroPalabra.Letra;
    Nodo^.Palabra:= RegistroPalabra.Palabra;
    Nodo^.Consigna:= RegistroPalabra.Consigna;
    Nodo^.Rta:= Pendiente;
end;

//CREAR ROSCO
{Procedimiento que pasa los datos del archivo palabras a la lista circular}
Procedure CrearRosco(var ArchivoPalabras: TArchivoPalabras; var Rosco: ListaCircular; NroSet: Integer); 
Var RegistroPalabra: Reg_palabra;
	Aux: ListaCircular;
    i: Integer;
begin
    Reset(ArchivoPalabras);
    Seek(ArchivoPalabras,(NroSet - InicioLetra) * FinLetra);
    Read(ArchivoPalabras,RegistroPalabra);
    CrearNodoRosco(Rosco,RegistroPalabra);
	Aux:= Rosco;
    For i:= InicioLetra to FinLetra - 1 do
    begin
		Read(ArchivoPalabras,RegistroPalabra);
        CrearNodoRosco(Aux^.Sig,RegistroPalabra);
		Aux:=Aux^.Sig;
	end;
	Aux^.Sig:= Rosco;
    Close(ArchivoPalabras);
end;

//NRO SET
{Función que devuelve un número entero aleatorio entre 1 y 5}
function NroSet(): Integer;
begin
    Randomize;
    NroSet:= Random(5)+1;
end;

//CARGAR ROSCOS
{Procedimiento que en función del número de set de cada jugador y el nombre de usuario carga un rosco asociado}
procedure CargarRoscos(var ArchivoPalabras: TArchivoPalabras; var ArregloPartida: TArregloPartida);
var SetUsuario1, SetUsuario2: Integer;
    RoscoUsuario1, RoscoUsuario2: ListaCircular;
begin
    SetUsuario1:= NroSet();
    SetUsuario2:= SetUsuario1;
    while (SetUsuario2 = SetUsuario1) do
        SetUsuario2:= NroSet();
    CrearRosco(ArchivoPalabras,RoscoUsuario1,SetUsuario1);
    CrearRosco(ArchivoPalabras,RoscoUsuario2,SetUsuario2);
    ArregloPartida[0].Rosco:= RoscoUsuario1;
    ArregloPartida[1].Rosco:= RoscoUsuario2;
end;

{==========ACTUALIZAR GANADOR==========}

//CANTIDAD DE ACIERTOS
{Función que contabiliza la cantidad de respuestas correctas en un rosco}
function CantDeAciertos(Rosco: ListaCircular): Integer;
var Iterador: ListaCircular;
    ContadorAciertos: Integer;
begin
    ContadorAciertos:= 0;
    Iterador:= Rosco^.Sig;
    if (Rosco^.Rta = Acertada) then
        ContadorAciertos:= ContadorAciertos + 1;
    while (Iterador <> Rosco) do
    begin
        if Iterador^.Rta = Acertada then
            ContadorAciertos:= ContadorAciertos + 1;
        Iterador:= Iterador^.Sig;
    end;
    CantDeAciertos:= ContadorAciertos;
end;

//ACTUALIZAR ARBOL
{Procedimiento que actualiza la cantidad de partidas ganadas en el árbol}
procedure ActualizarArbol(var ArbolJugadores: TArbolJugadores; Usuario: Shortstring);
begin
    if (ArbolJugadores^.Nombre = Usuario) then
        ArbolJugadores^.PartidasGanadas:= ArbolJugadores^.PartidasGanadas + 1
    else
        if (Usuario < ArbolJugadores^.Nombre) then
            ActualizarArbol(ArbolJugadores^.Menores,Usuario)
        else
            ActualizarArbol(ArbolJugadores^.Mayores,Usuario);
end;

//ACTUALIZAR ARCHIVO
{Procedimiento que actualiza la cantidad de partidas ganadas en el archivo}
procedure ActualizarArchivo(var ArchivoJugadores: TArchivoJugadores; Usuario: Shortstring);
var RegistroUsuario: Reg_jugador;
    UsuarioEncontrado: Boolean;
begin
    UsuarioEncontrado:= False;
    Reset(ArchivoJugadores);
    while not UsuarioEncontrado do
    begin
        read(ArchivoJugadores,RegistroUsuario);
        if(RegistroUsuario.Nombre = Usuario) then
            UsuarioEncontrado:= True;
    end;
    RegistroUsuario.PartidasGanadas:= RegistroUsuario.PartidasGanadas + 1;
    Seek(archivojugadores, FilePos(ArchivoJugadores) - 1);
    Write(ArchivoJugadores,RegistroUsuario);
    Close(ArchivoJugadores);
end;

//ACTUALIZAR GANADOR
{Procedimiento que determina qué jugador ganó, muestra un mensaje por pantalla y lo actualiza en el árbol y en el archivo}
procedure ActualizarGanador(var ArchivoJugadores: TArchivoJugadores; var ArbolJugadores: TArbolJugadores; ArregloPartida: TArregloPartida);
var CantDeAciertosUsuario1, CantDeAciertosUsuario2: Integer;
    Ganador: Shortstring;
begin
    CantDeAciertosUsuario1:= CantDeAciertos(ArregloPartida[0].Rosco);
    CantDeAciertosUsuario2:= CantDeAciertos(ArregloPartida[1].Rosco);
    If (CantDeAciertosUsuario1 <> CantDeAciertosUsuario2) then
    begin
        If CantDeAciertosUsuario1 = CantDeAciertosUsuario2 then
            Writeln('Los jugadores han empatado')
        else
        begin
            If CantDeAciertosUsuario1 < CantDeAciertosUsuario2 then
                Ganador:= ArregloPartida[1].Nombre
            else
                Ganador:= ArregloPartida[0].Nombre;
            writeln('El ganador de la partida es: ', Ganador,'!!!');
            ActualizarArbol(ArbolJugadores,Ganador);
            ActualizarArchivo(ArchivoJugadores,Ganador);
        end;
    end;
end;

{==========DESARROLLAR JUGADA==========}

//RESPUESTA CORRECTA?
{Función booleana que verifica que la respuesta ingresada por el jugador sea correcta}
function RespuestaCorrecta(RtaJugador: String; Nodo: ListaCircular): Boolean;
begin
    if (RtaJugador = Nodo^.Palabra) then
        RespuestaCorrecta:= True
    else
        RespuestaCorrecta:= False;
end;

//JUGAR TURNO
{Gestiona el turno de un jugador mientras éste no haya respondido todas las consignas (es decir, 
tenga preguntas pendientes), no se haya equivocado o no haya hecho pasapalabra}
procedure JugarTurno(var Nodo: ListaCircular; var CantidadPP: Integer; UsuarioActual: Shortstring);
var RtaJugador: String;
    HizoPP, RtaIncorrecta: Boolean;
begin
    HizoPP:= False;
    RtaIncorrecta:= False;
    while ((not HizoPP) and (not RtaIncorrecta) and (CantidadPP > 0)) do
    begin
        if(Nodo^.Rta = Pendiente) then
        begin
            Writeln;
            Writeln('Turno del jugador: ',UsuarioActual);
            Writeln('Letra: ',Nodo^.Letra);
            Writeln('Consigna: ',Nodo^.Consigna);
            Writeln;
            Write('Ingrese la respuesta o PP para pasar la palabra: ');
            Readln(RtaJugador);
            if RtaJugador <> 'pp' then
            begin
                if RespuestaCorrecta(RtaJugador,Nodo) then
                begin
                    Nodo^.Rta:= Acertada;
                    Clrscr();
                    Writeln('Respuesta correcta');
                end
                else
                begin
                    Nodo^.Rta:= Errada;
                    RtaIncorrecta:= True;
                    Clrscr();
                    Writeln('Respuesta incorrecta.');
                    Writeln('La respuesta correcta es: ',Nodo^.Palabra);
                end;
                CantidadPP:= CantidadPP - 1;
            end
            else
            begin
                Clrscr();
                HizoPP:= True;
            end;
        end;
        Nodo:= Nodo^.Sig;
    end;
end;

//INTERCAMBIAR JUGADORES
{Actualiza los datos necesarios para que el siguiente turno lo juegue el siguiente jugador}
procedure IntercambiarJugadores(var UsuarioActual: Shortstring; Usuario1, Usuario2: Shortstring; var CursorUsuarioActual, CursorUsuario1, CursorUsuario2: ListaCircular; var PPUsuarioActual, PPUsuario1, PPUsuario2: Integer);
begin
    if (UsuarioActual = Usuario1) then
    begin
        PPUsuario1:= PPUsuarioActual;
        CursorUsuario1:= CursorUsuarioActual;
        UsuarioActual:= Usuario2;
        PPUsuarioActual:= PPUsuario2;
        CursorUsuarioActual:= CursorUsuario2;
    end
    else
    begin
        PPUsuario2:= PPUsuarioActual;
        CursorUsuario2:= CursorUsuarioActual;
        UsuarioActual:= Usuario1;
        PPUsuarioActual:= PPUsuario1;
        CursorUsuarioActual:= CursorUsuario1;
    end;
end;

//DESARROLLAR JUGADA
{Fija el jugador 1 como el actual y hace que mientras los 2 jugadores tenga preguntas pendientes,
jueguen e intercambien de turno}
procedure DesarrollarJugada(var ArregloPartida: TarregloPartida);
var PPUsuarioActual, PPUsuario1, PPUsuario2: Integer;
    CursorUsuarioActual, CursorUsuario1, CursorUsuario2: ListaCircular;
    UsuarioActual, Usuario1, Usuario2: Shortstring;
begin
    PPUsuario1:= CantLetras;
    PPUsuario2:= CantLetras;
    Usuario1:= ArregloPartida[0].Nombre;
    Usuario2:= ArregloPartida[1].Nombre;
    CursorUsuario1:= ArregloPartida[0].Rosco;
    CursorUsuario2:= ArregloPartida[1].Rosco;
    PPUsuarioActual:= PPUsuario1;
    CursorUsuarioActual:= CursorUsuario1;
    UsuarioActual:= Usuario1;
    while (PPUsuario1 > 0) and (PPUsuario2 > 0) do
    begin
        JugarTurno(CursorUsuarioActual,PPUsuarioActual,UsuarioActual);
        IntercambiarJugadores(UsuarioActual,Usuario1,Usuario2,CursorUsuarioActual,CursorUsuario1,CursorUsuario2,PPUsuarioActual,PPUsuario1,PPUsuario2);
    end;
end;

//JUGAR
{Procedimiento que lee y carga los jugadores en el arreglo partida y, si son jugadores válidos, carga el rosco de cada jugador,
desarrolla la partida y actualiza el ganador en el árbol y en el archivo}
procedure Jugar(var ArchivoJugadores: TArchivoJugadores; var ArchivoPalabras: TArchivoPalabras; var ArbolJugadores: TArbolJugadores);
var ArregloPartida: TArregloPartida;
    SonJugadoresValidos: Boolean;
begin
    CargarJugadores(ArbolJugadores,ArregloPartida,SonJugadoresValidos); {Lee por teclado los dos jugadores, verifica que se hayan registrado previamente y de ser así, los registra en el arreglo de partida}
    if (SonJugadoresValidos) then {Si los nombres de usuarios ingresados fueron correctos}
    begin
        CargarRoscos(ArchivoPalabras,ArregloPartida); {Se agregan los roscos al arreglo partida}
        DesarrollarJugada(ArregloPartida); {Se ejecuta la partida}
        ActualizarGanador(ArchivoJugadores,ArbolJugadores,ArregloPartida); {Se actualiza la cantidad de partidas ganadas del ganador en el árbol y el archivo de jugadores}
    end;
end;


{--------------------------------------DESPLEGAR MENU---------------------------------------}
procedure DesplegarMenu(var ArchivoJugadores: TArchivoJugadores; var ArchivoPalabras: TArchivoPalabras; var ArbolJugadores: TArbolJugadores);
var Opcion: String;
begin
    TextColor(LightCyan);
    writeln('-------------------------------------------------------------------------------');
    writeln('----------------------------------PASAPALABRA----------------------------------');
    writeln('-------------------------------------------------------------------------------');
    NormVideo; {Colores por defecto}
    Writeln;
    Opcion:= 'Inicializacion';
    while (Opcion <> '4') do
    begin
        Writeln('1. Agregar un jugador.');
        Writeln('2. Ver lista de jugadores.');
        Writeln('3. Jugar.');
        Writeln('4. Salir.');
        Writeln;
        TextColor(LightMagenta);
        Writeln('Ingrese una opcion del menu: ');
        NormVideo; {Colores por defecto}
        Readln(Opcion);
        Writeln;
        Case Opcion of
            '1':
            begin
                Clrscr();
                AgregarJugador(ArchivoJugadores,ArbolJugadores);
                Writeln;
            end;
            '2':
            begin 
                Clrscr();
                VerJugadores(ArbolJugadores);
                Writeln;
                TextColor(LightGreen);
                Writeln('Ingrese cualquier tecla para continuar: ');
                NormVideo; {Colores por defecto}
                Readln;
                Clrscr();
                TextColor(LightCyan);
                Writeln('-------------------------------------------------------------------------------');
                Writeln('----------------------------------PASAPALABRA----------------------------------');
                Writeln('-------------------------------------------------------------------------------');
                NormVideo; {Colores por defecto}
                Writeln;
            end;
            '3': 
            begin
                Clrscr();
                Jugar(ArchivoJugadores,ArchivoPalabras,ArbolJugadores);
                Writeln;
            end;
            '4':
            begin
                TextColor(LightRed);
                Writeln('Has salido del juego.');
                Writeln;
            end;
            else
            begin
                Clrscr();
                TextColor(LightRed);
                Writeln('Opcion invalida');
                NormVideo; {Colores por defecto}
                Writeln;
            end;
        end;
    end;
end;


{-------------------------------------------MAIN------------------------------------------}
var ArchivoJugadores: TArchivoJugadores;
    ArchivoPalabras: TArchivoPalabras;
    ArbolJugadores: TArbolJugadores;
begin
    Clrscr();
    Assign(ArchivoJugadores,DirecJugadores);
    Assign(ArchivoPalabras,DirecPalabras);
    CrearArbol(ArchivoJugadores,ArbolJugadores);
    DesplegarMenu(ArchivoJugadores,ArchivoPalabras,ArbolJugadores);
end.