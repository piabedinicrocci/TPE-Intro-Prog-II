program creaSets;
uses crt;

const
    DirecPalabras= 'palabras.dat';

type
    
    Reg_palabra= record
        Nro_set: Integer;
        Letra: Char;
        Palabra: String;
        Consigna: String
    end;
    
    TArchivoPalabras= File of Reg_palabra;
    

procedure c(var archivo: TarchivoPalabras; nroSet: integer; letra: char; palabra: String; consigna: String);
var r: Reg_palabra;
begin
    r.Nro_set:= nroSet;
    r.Letra:= letra;
    r.Palabra:= palabra;
    r.Consigna:= consigna;
    write(archivo,r);
end;

var
    a: TArchivoPalabras;
begin
    Assign(a,DirecPalabras);
    rewrite(a);
    c(a,1,'A','alcachofa','Planta comestible con tallos blancos y hojas verdes. También esta en la ducha.');
    c(a,1,'B','botiquin','Caja en la que se guardan medicinas.');
    c(a,1,'C','camilla','Cama en la que se llevan de un lado a otro heridos o enfermos.');
    c(a,1,'D','dedicatoria','Palabras que se escriben y se dicen como regalo a alguien.');
    c(a,1,'E','empaniar','Mancharse un cristal con el vapor de agua.');
    c(a,1,'F','fabula','Cuento en el que los personajes son animales, con el que se aprende algo a través de una moraleja.');
    c(a,1,'G','guisar','Preparar alimentos cocinandolos con calor.');
    c(a,1,'H','hamaca','Tela resistente que se cuelga de sus extremos y se utiliza como cama.');
    c(a,1,'I','imperdible','Alfiler que se abrocha quedando su punta dentro de un gancho.');
    c(a,1,'J','jinete','Persona que monta a caballo.');
    c(a,1,'K','karaoke','Diversión consistente en interpretar una canción grabada, mientras se sigue la letra que aparece en una pantalla.');
    c(a,1,'L','litera','Mueble formado por dos camas puestas una encima de la otra.');
    c(a,1,'M','mayonesa','Salsa que se hace batiendo huevo y aceite.');
    c(a,1,'N','nuca','Parte posterior de la cabeza situada encima del cuello.');
    c(a,1,'O','orilla','Borde del mar, de un lago o de un río.');
    c(a,1,'P','planchar','Quitar las arrugar a una prenda.');
    c(a,1,'Q','quitamanchas','Producto natural o preparado que sirve para quitar manchas.');
    c(a,1,'R','racimo','Conjunto de uvas sostenidas en un mismo tallo.');
    c(a,1,'S','sembrar','Enterrar semillas en la tierra para que crezcan.');
    c(a,1,'T','taburete','Asiento sin respaldo');
    c(a,1,'U','untar','Extender mantequilla sobre una rebanada de pan.');
    c(a,1,'V','vecino','Persona que vive en el mismo barrio o edificio que otra.');
    c(a,1,'W','wifi','Sistema de conexión inalambrica para conectarse a internet.');
    c(a,1,'X','fenix','(Contiene la x) Ave fabulosa que los antiguos creyeron que era única y renacía de sus cenizas.');
    c(a,1,'Y','yunque','Hueso que se encuentra dentro del oído, situado entre el martillo y el estribo.');
    c(a,1,'Z','zumbido','Sonido que producen algunos insectos como la abeja o el mosquito.');
c(a,2,'A','ajo','Planta con raiz comestible, de color blanco y olor fuerte.');
    c(a,2,'B','baston','Palo de madera que sirve para apoyarse al andar.');
    c(a,2,'C','cactus','Planta verde con muchas espinas.');
    c(a,2,'D','danzar','Moverse al ritmo de una música.');
    c(a,2,'E','embudo','Objeto con forma de cono que se utiliza para pasar líquidos de un recipiente a otro.');
    c(a,2,'F','fauces','Boca y dientes de animales muy fieros.');
    c(a,2,'G','gatear','Avanzar con las rodillas y las palmas de las manos.');
    c(a,2,'H','hambre','Sensación que provocan las ganas de comer.');
    c(a,2,'I','interruptor','Aparato que se usa para abrir o cerrar el paso de la corriente eléctrica.');
    c(a,2,'J','jungla','Selva propia del clima tropical.');
    c(a,2,'K','ketchup','Salsa de tomate condimentada con vinagre, azúcar y especias.');
    c(a,2,'L','ladrillos','Pieza de arcilla con la que se construyen muros.');
    c(a,2,'M','manada','Grupo de animales de la misma especie que van juntos.');
    c(a,2,'N','nana','Canción de cuna que se canta a los bebés para que se duerman.');
    c(a,2,'O','oculista','Médico especialista en las enfermedades de los ojos.');
    c(a,2,'P','pesadilla','Sueño que produce angustia o temor.');
    c(a,2,'Q','quirofano','Habitación de hospital donde los médicos realizan las operaciones.');
    c(a,2,'R','raiz','Parte por la que se alimenta una planta, que esta bajo tierra.');
    c(a,2,'S','susurrar','Hablar muy bajito.');
    c(a,2,'T','talon','Parte posterior del pie de una persona.');
    c(a,2,'U','umbral','Parte inferior de una puerta.');
    c(a,2,'V','vacaciones','Tiempo de descanso en el que las personas no trabajan o no van al colegio.');
    c(a,2,'W','walabi','Animal marsupial que habita en Australia. Se parece al canguro pero es de menor tamaño.');
    c(a,2,'X','extremidades','Órganos externos, articulados con el tronco, que cumplen funciones de locomoción, vuelo o manipulación de objetos en los animales.');
    c(a,2,'Y','yegua','Hembra del caballo.');
    c(a,2,'Z','zurda','Persona que habitualmente utiliza su mano o pie izquierdos.');
    c(a,3,'A','alcachofa','Planta comestible de color verde con hojas pequeñas y duras.');
    c(a,3,'B','bache','Hoyo que hay en una carretera.');
    c(a,3,'C','careta','Pieza de cartón o plastico que sirve para taparse la cara. Se usa especialmente en fiestas.');
    c(a,3,'D','delantal','Prenda que se pone encima de la ropa y que sirve para no mancharla.');
    c(a,3,'E','empujar','Hacer fuerza contra algo para moverlo.');
    c(a,3,'F','fila','Personas o cosas colocadas en línea, una detras de otra.');
    c(a,3,'G','guiniar','Gesto de cerrar un solo ojo durante un momento.');
    c(a,3,'H','hebilla','Pieza de metal que sirve para adornar o cerrar bolsos, cinturones…');
    c(a,3,'I','iceberg','Gran trozo de hielo que flota en el mar.');
    c(a,3,'J','jabon','Sustancia que sirve para lavar.');
    c(a,3,'K','kebab','Masa de carne picada que, ensartada en una varilla, se asa haciéndose girar ante una fuente de calor.');
    c(a,3,'L','lazo','Cinta anudada que sirve para atar y adornar.');
    c(a,3,'M','mantel','Pieza de tela con la que se cubre la mesa durante las comidas.');
    c(a,3,'N','nadie','Ninguna persona.');
    c(a,3,'O','orquesta','Conjunto de músicos que tocan instrumentos dirigidos con una batuta.');
    c(a,3,'P','pompa','Esfera transparente de jabón, llena de aire.');
    c(a,3,'Q','quebrar','Convertir en trozos algo que es duro.');
    c(a,3,'R','relincho','Sonido que produce el caballo.');
    c(a,3,'S','segar','Cortar la hierba u otras plantas.');
    c(a,3,'T','tandem','Bicicleta para dos o mas personas.');
    c(a,3,'U','ultimo','Es lo contrario de primero.');
    c(a,3,'V','vid','Planta cuyo fruto es la uva.');
    c(a,3,'W','web','Pagina online que podemos visitar desde diferentes dispositivos como el ordenador o la tablet.');
    c(a,3,'X','xilofago','Insecto que roe la madera, como por ejemplo la termita.');
    c(a,3,'Y','yeti','Supuesto gigante con forma de hombre, del cual se dice que vive en el Himalaya.');
    c(a,3,'Z','zafarse','Escaparse o esconderse para evitar un encuentro o riesgo.');
    c(a,4,'A','aguacate','Fruto tropical de color verde con forma de pera, piel muy dura y un hueso grande en el interior.');
    c(a,4,'B','buhardilla','Último piso de una casa que tiene el techo inclinado.');
    c(a,4,'C','cebolla','Planta redonda y comestible con muchas capas blancas.');
    c(a,4,'D','definicion','Explicación del significado de una palabra.');
    c(a,4,'E','escama','Lamina dura que cubre el cuerpo de algunos animales, como peces o serpientes');
    c(a,4,'F','flequillo','Parte del cabello que cae sobre la frente.');
    c(a,4,'G','grua','Maquina que se usa para levantar y transportar grandes pesos.');
    c(a,4,'H','herramienta','Instrumento de hierro o acero que sirve para trabajar con las manos.');
    c(a,4,'I','imitar','Hacer lo mismo que otra persona.');
    c(a,4,'J','jabali','Animal salvaje que se parece al cerdo, con grandes colmillos.');
    c(a,4,'K','kilt','Falda corta y a cuadros que utilizan los hombres escoceses en su traje tradicional.');
    c(a,4,'L','limonada','Bebida refrescante hecha con zumo de limón, agua y azúcar.');
    c(a,4,'M','manguera','Tubo largo y flexible que sirve para regar.');
    c(a,4,'N','nuez','Fruto comestible del nogal, cuya cascara es dura y rugosa.');
    c(a,4,'O','olivo','Arbol de tronco corto y grueso cuyo fruto es la aceituna.');
    c(a,4,'P','pinguino','Ave que no vuela, de color negro con el pecho blanco, que vive en el Polo Sur.');
    c(a,4,'Q','quitanieves','Maquina que sirve para quitar la nieve de calles y carreteras.');
    c(a,4,'R','receta','Nota donde el médico indica el nombre del medicamento que debe tomar el enfermo.');
    c(a,4,'S','semana','Período de tiempo que dura de lunes a domingo.');
    c(a,4,'T','tachar','Trazar una línea por encima de algo escrito.');
    c(a,4,'U','unguento','Medicamento líquido o pastoso que se unta en una parte del cuerpo y sirve para aliviar o calmar dolores.');
    c(a,4,'V','viga','Tabla de madera o hierro larga y gruesa que sirve para hacer los techos de las casas y sostener edificios.');
    c(a,4,'W','waterpolo','Deporte que se practica en una piscina, consistente en meter el balón en la portería contraria.');
    c(a,4,'X','torax','(Contiene la x) Pecho de las personas y de los animales.');
    c(a,4,'Y','yedra','Planta trepadora, leñosa, de raíces adherentes que brotan de los tallos. Repta sobre el suelo y trepa a lo largo de otras plantas o de las casas.');
    c(a,4,'Z','zancada','Paso largo que se da con movimiento acelerado o por tener las piernas largas.');
    c(a,5,'A','alicates','Herramienta que sirve para sujetar o cortar objetos menudos.');
    c(a,5,'B','bobina','Hilo enrollado');
    c(a,5,'C','cascabel','Bolita de metal hueca con un objeto dentro que suena al moverse.');
    c(a,5,'D','deshojar','Quitar las hojas de una planta o los pétalos de una flor.');
    c(a,5,'E','esqueleto','Conjunto de huesos de personas o animales.');
    c(a,5,'F','frasco','Recipiente pequeño de cristal.');
    c(a,5,'G','gajo','Parte en que estan divididos algunas frutas como la mandarina.');
    c(a,5,'H','hojear','Pasar las hojas de un libro o de una revista.');
    c(a,5,'I','infancia','Parte de la vida en que se es niño.');
    c(a,5,'J','jabato','Cría del jabalí.');
    c(a,5,'K','kilo','Medida de peso que equivale a mil gramos.');
    c(a,5,'L','lanzar','Arrojar un objeto con fuerza.');
    c(a,5,'M','moraleja','Enseñanza que hay al final de una fabula.');
    c(a,5,'N','nenufar','Planta de flores grandes, generalmente de color rosa o blanco, que flota en el agua.');
    c(a,5,'O','ojal','Abertura alargada por la que se pasa un botón para abrochar una prenda.');
    c(a,5,'P','pezunia','Parte dura y oscura donde termina la pata de algunos animales.');
    c(a,5,'Q','quicio','Parte en la que estan las bisagras en una puerta o ventana.');
    c(a,5,'R','rebosar','Salirse un líquido por encima de los bordes del recipiente que lo contiene.');
    c(a,5,'S','solapa','Parte de una prenda de vestir que corresponde al pecho y que suele ir doblada hacia afuera.');
    c(a,5,'T','turbante','Gorro de tela enrollado alrededor de la cabeza.');
    c(a,5,'U','uniforme','Traje que sirve para identificar a personas que realizan algunos trabajos.');
    c(a,5,'V','veleta','Objeto que señala en qué dirección sopla el viento.');
    c(a,5,'W','windsurf','Deporte que consiste en navegar de pie sobre una tabla con vela.');
    c(a,5,'X','xenofobia','Fobia a los extranjeros.');
    c(a,5,'Y','yelmo','Parte de la armadura que protege la cabeza y la cara.');
    c(a,5,'Z','zambullirse','Meterse de golpe en el a');
end.