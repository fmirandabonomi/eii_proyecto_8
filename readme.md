# Proyecto 8: Descripción de sistemas digitales con VHDL

Electrónica II para Ing. Electrónica. 2024

## Objetivos

- Investigar el concepto de lenguaje de descripción de hardware.
- Realizar una breve reseña sobre el lenguaje de descripción de hardware VHDL 2008.
- Investigar el concepto de descripción de hardware a nivel compuerta y nivel transferencia de registros.
- Instala las siguientes herramientas para trabajar en desarrollo de hardware y simulación con vhdl: make, ghdl y gtkwave.
- Diseña, describe a nivel compuerta y evalúa mediante simulación los componentes implementando las siguientes funciones lógicas básicas
  - Compuerta *AND* de cuatro entradas
  - Compuerta *OR* de tres entradas
  - Compuerta *XOR* de dos entradas
  - Sumador completo
  - Comparador de 4 bit binario natural
  - Comparador de 4 bit complemento a dos
- Diseña, describe a nivel transferencia de registros, evalúa mediante simulación los siguientes componentes:
  - Función *cero* de 32 bit. La entrada es una señal de 32 bit y la salida una señal de un bit, que vale $1$ cuando la señal de entrada vale cero.
  - Función *AND* de dos entradas de 32 bit. Las entradas y la salida son señales de 32 bit. Cada bit de la salida es el producto lógico de los bits correspondientes de las entradas.
  - Función *OR* de dos entradas de 32 bit. Las entradas y la salida son señales de 32 bit. Cada bit de la salida es la suma lógica de los bits correspondientes de las entradas.
  - Función *XOR* de dos entradas de 32 bit. Las entradas y la salida son señales de 32 bit. Cada bit de la salida es el o exclusivo de los bits correspondientes de las entradas.
  - Función *SUMA/RESTA* de dos entradas de 32 bit. Incluye una entrada de selección, $0$ para suma y $1$ para resta, dos entradas de 32 bit y una salida de 32 bit. La salida es la suma o resta de las entradas según la entrada de selección.
  - Función *MENOR QUE* de 32 bit para valores en binario natural y con signo complemento a dos. Incluye una entrada de selección, $0$ con signo y $1$ sin signo, dos entradas, $A$ y $B$, de 32 bit y una salida de un bit. La salida es $1$ si la entrada $A$ es menor que la entrada $B$ y $0$ caso contrario. La comparación se realiza considerando valores en binario natural o en complemento a dos según indique la entrada de selección.
  - Función *desplazamiento a la izquierda* de un valor de 32 bit por la cantidad de bits indicada por un valor de 5 bit. Ingresa ceros por la derecha.
  - Función *desplazamiento a la derecha* de un valor de 32 bit por la cantidad de bits indicada por un valor de 5 bit. Cuenta con un selector de modo *con signo*. En modo sin signo ingresa ceros por la izquierda, en modo con signo copia el bit de signo (extensión de signo).
- A partir de los componentes desarrollados en el punto anterior, diseña, describe a nivel estructural y evalúa mediante simulación una unidad aritmética-lógica de 32 bit con dos entradas de operando, una entrada de selección, una salida de resultado y una salida de cero, con las funciones dadas por la Tabla 1.
- Diseña, describe a nivel comportamental y evalúa mediante simulación un registro de 32 bit con habilitación de escritura.

Tabla 1: Funciones de la ALU.

| *Sel* | *Y* | *Z* |
|:-----:|:---|:---:|
|`0000` | $A+B$ | $Y=0$ |
|`0001` | $A-B$ | $Y=0$ |
|`001-` | $A << B$ | $Y=0$ |
|`010-` | $A<B\quad$ Complemento a 2 | $Y=0$ |
|`011-` | $A<B\quad$ Binario natural | $Y=0$ |
|`1010` | $A >> B\,$ Binario natural | $Y=0$ |
|`1011` | $A >> B\,$ Complemento a 2 | $Y=0$ |
|`100-` | $A \oplus B$ | $Y=0$ |
|`110-` | $A \vee B$ | $Y=0$ |
|`111-` | $A \wedge B$ | $Y=0$ |

*Notas*:  *Sel* es la entrada de selección, de 4 bit. *A* y *B* son los operandos, de 32 bit. *Y* es el resultado, de 32 bit y *Z* es la salida de cero, de un bit. Los operadores '$<<$' y '$>>$' denotan desplazamiento a la izquierda y desplazamiento a la derecha respectivamente. Los operadores '$=$' y '$<$' denotan las operaciones relacionales *igual a* y *menor que*, que evalúan a $1$ si se cumple la condición y $0$ en caso contrario.

## Entregables

Las descripciones de hardware y bancos de prueba realizados. Usar este repositorio como base y añadirlos dento del subdirectorio `src`.

Un informe con la siguiente estructura:

- *Título*
- *Autor*
- *Resumen* (1 punto)
- *Introducción* (2 punto) Presenta los resultados de la investigación y las especificaciones de los componentes a desarrollar.
- *Materiales y Métodos* (2 puntos) Explica el proceso de diseño seguido para desarrollar componentes a nivel compuerta y a nivel transferencia de registros.
- *Resultados* (2 puntos) Describe los resultados obtenidos. No es necesario duplicar el código vhdl, pero sí describir en forma general el contenido de cada archivo.
- *Conclusiones* (2 puntos) Explica en tus palabras que es la descripción de hardware.
- *Referencias* (1 punto) Debes utilizar citas bibliográficas durante el desarrollo siempre que emplees ideas tomadas de la bibliografía. Esta sección incluye las referencias bibliográficas correspondientes, en formato APA.

## Organización de archivos

***IMPORTANTE**: El proyecto debe ser ubicado en una ruta de acceso que no incluya espacios. Los nombres de los archivos fuente no pueden incluir espacios.*

Los archivos de descripción de hardware se incluirán en el subdirectorio `src`. Cada archivo definirá una entidad de VHDL, y el nombre del archivo coincidirá con el nombre de la entidad (salvo por la extensión .vhd). Ver por ejemplo el Listado 1. Los bancos de prueba serán nombrados anteponiendo `sim_` al nombre de la entidad que ensayan. Por ejemplo, el banco de prueba para la entidad definida en el Listado 1 será el dado por el Listado 2. Los bancos de prueba deben incluir al menos un proceso que genere una excitación utilizando sentencias de asignación seguidas de sentencias de espera. Al terminar la secuencia de excitación deberá utilizarse el procedimiento `finish` del paquete `std.env` para dar por finalizada la simulación. Se sugiere incluir una sentencia de espera extra antes de terminar la simulación para que el último estado sea más fácilmente visible en el visor de formas de onda.

~~~~vhdl
library IEEE;
use IEEE.std_logic_1164.all;

entity and_2 is
  port (
    A : in  std_logic;
    B : in  std_logic;
    Y : out std_logic
  );
end and_2;

architecture arch of and_2 is
begin
  Y <= A and B;
end arch;
~~~~

Listado 1: Archivo `src/and_2.vhd`

~~~~vhdl
library IEEE;
use IEEE.std_logic_1164.all;
use std.env.finish;

entity sim_and_2 is
  -- vacío
end sim_and_2;

architecture sim of sim_and_2 is
  component and_2 is
    port (
      A : in  std_logic;
      B : in  std_logic;
      Y : out std_logic
    );
  end component; -- and_2
  signal AB : std_logic_vector (1 downto 0);
  signal Y : std_logic;
begin
  -- Dispositivo bajo prueba
  dut : and_2 port map (A=>AB(1),B=>AB(0),Y=>Y);

  excitaciones: process
  begin
    AB <= "00";
    wait for 1 ns;
    AB <= "01";
    wait for 1 ns;
    AB <= "10";
    wait for 1 ns;
    AB <= "11";
    wait for 1 ns;
    wait for 1 ns; -- Espera extra antes de salir
    finish;
  end process; -- excitaciones
end sim;
~~~~

Listado 2: Archivo `src/sim_and_2.vhd`, con el banco de prueba para la entidad `and_2`

## Ayuda para crear nuevos módulos

Al ser VHDL un lenguaje tan verborrágico y repetitivo, se vuelve engorroso rápidamente el realizar un gran número de módulos con sus respectivos bancos de prueba para simulación siguiendo las conveciones de nombres correctas. Como una ayuda para aliviar el trabajo repetitivo se incluyó en el guión de make una ayuda para generar nuevos archivos. Para ello utilizar el comando

~~~shell
make nuevo_<entidad>
~~~

donde &lt;entidad&gt; es el nombre de una entidad nueva. Este comando creará los archivos `src/<entidad>.vhd` y `src/sim_<entidad>.vhd`, conteniendo ejemplos de componente y banco de prueba respectivamente. Luego reemplazar los ejemplos por el diseño y banco de pruebas reales.

## Ejecución de las simulaciones

Para ejecutar todas las simulaciones abrrir una teminal en el directorio del proyecto y ejecutar el comando `make`. Los resultados estarán disponibles en el subdirectorio `resultados`. Por ejemplo, las formas de onda creadas al ejecutar la simulación `sim_and_2` estarán en el archivo `resultados/and_2.ghw` (sin el prefijo sim_). Para ver las formas de onda utilizar el comando `gtkwave -f <archivo.ghw>` por ejemplo para ver el resultado de la simulación `sim_and_2` utilizar el comando `gtkwave -f resultados/and_2.ghw`. Ademas de ejecutar las simulaciones make genera un diagrama esquemático en formato de imagen vectorial `.svg`, también en la carpeta resultados. En el caso del componete `and_2` genera el archivo `resultados/and_2.svg`. Los archivos `.svg` pueden abrirse con un navegador. Puedes también previsualizarlo en visual studio code instalando alguna extensión. Recomendamos la extensión "SVG Previewer", que puedes ubicar buscando `vitaliymaz.vscode-svg-previewer` en la solapa de extensiónes.

Para ejecutar solamente una simulación en particular usar `make <entidad>` donde `<entidad>` es el nombre de la entidad a simular (que coincide con el nombre del banco de prueba sin el prefijo `sim_`). Por ejemplo para ejecutar solamente la simulación `sim_and_2` utilizar el comando `make and_2`

Para eliminar todos los resultados de las simulaciones ejecutar el comando `make clean`

## Instalación de las herramientas en Windows

Utilizaremos la herramienta *ghdl* de análisis, compilación, simulación y síntesis para el lenguaje de descripción de hardware **VHDL**, el visor de formas de onda *gtkwave*, la utilidad *make* para automatización de tareas, la herramienta de síntesis *yosys* y el programa *netlistsvg* para .

En sistemas operativos windows utilizaremos la distribución de softeare *MSYS2* para instalar las herramientas necesarias. Descargar y ejecutar el instalador de *MSYS2* desde [https://www.msys2.org/](https://www.msys2.org/). Instalar en el directorio por defecto (`C:\msys64`). Luego de finalizada la instalación actualizar MSYS2. Para ello buscar en el menú inicio y ejecutar *MSYS2 64bit -> MSYS2 MSYS*. En la consola que se abre ejecutar el comando

~~~~shell
pacman -Syu --noconfirm
~~~~

Al finalizar el comando es posible que se cierre la ventana. En ese caso volver a ejecutar *MSYS2 MSYS*. Repetir la ejecución del comando hasta que el resultado  sea similar al del Listado 3.

~~~shell
# pacman -Syu --noconfirm
:: Synchronizing package databases...
 clangarm64 is up to date
 mingw32 is up to date
 mingw64 is up to date
 ucrt64 is up to date
 clang32 is up to date
 clang64 is up to date
 msys is up to date
:: Starting core system upgrade...
 there is nothing to do
:: Starting full system upgrade...
 there is nothing to do
~~~

Listado 3: Resultado del comando `pacman -Syu --noconfirm` cuando MSYS2 está actualizado.

Una vez actualizado, ejecutar los comandos

~~~shell
pacman -S mingw-w64-ucrt-x86_64-ghdl-llvm --noconfirm
pacman -S make mingw-w64-ucrt-x86_64-gtkwave --noconfirm
pacman -S mingw-w64-ucrt-x86_64-yosys --noconfirm 
pacman -S mingw-w64-ucrt-x86_64-nodejs --noconfirm
~~~

para instalar ghdl, make, gtkwave, yosys y nodejs (necesario para netlistsvg). Luego cerrar la terminal de MSYS2 con el comando `exit`.

Abrir la terminal *MSYS UCRT* desde el menú inicio *MSYS2 64bit -> MSYS2 UCRT* y ejecutar el siguiente comando para instalar *netlistsvg* en *nodejs*

~~~shell
npm install -g netlistsvg
~~~

luego cerrar la terminal con el comando *exit*.

Una vez instaladas las herramientas hay que modificar las rutas de acceso por defecto (PATH) para que sean fácilmente accesibles. Para ello en la configuración del sistema busca "entorno" y selecciona "Editar las variables de entorno del sistema". Selecciona "Variables de entorno..." en la hoja de propiedades. En el cuadro "Variables de usuario" selecciona Path con doble click. Al final de la lista añade las entradas `C:\msys64\ucrt64\bin` y `C:\msys64\usr\bin` en ese orden.

## Agregados de Visual Studio Code

Se recomienda utilizar como editor de texto Visual Studio Code. En Visual Studio Code instalar el agregado "VHDL", que encontrarás buscando `puorc.awesome-vhdl` en la pestaña de agregados, que da soporte para el lenguaje VHDL. Además recomendamos "SVG Previewer", que encontrarás buscando `vitaliymaz.vscode-svg-previewer` en la solapa de extensiones, para visualizar los esquemáticos producidos en formato SVG.
