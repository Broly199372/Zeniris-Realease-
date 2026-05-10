# 🇧🇷 Zeniris
Linguagem de programação focada em jogos, sistemas reativos e execução leve.
Zeniris foi criada com o objetivo de simplificar a criação de jogos, mods e aplicações interativas através de uma sintaxe baseada em estados, dependências e execução automática por runtime.
A linguagem utiliza um modelo reativo onde funções podem ser ativadas automaticamente de acordo com o estado do mundo, entidades ou sistemas internos do jogo.
Filosofia
Zeniris foi projetada com foco em:
Simplicidade de leitura
Estrutura modular
Runtime leve
Execução reativa
Portabilidade
Compilação rápida
Desenvolvimento acessível
Organização automática de comportamento
A linguagem evita excesso de boilerplate e reduz a necessidade de grandes cadeias de if, verificações constantes e sistemas gigantescos de eventos manuais.
Estrutura da Linguagem
A base da Zeniris é construída sobre:
Functions
Dependências
Estados
Runtime reativo
Observadores
Bytecode .zni
Sistema modular
Imports
Build tools
Runtime nativo
Sistema Reativo
Em Zeniris, funções podem ser ativadas automaticamente quando determinados estados ou dependências forem detectados pela runtime.
O programador descreve:
dependências
estados
restrições
comportamento
A runtime é responsável por:
monitorar estados
carregar dependências necessárias
ativar funções automaticamente
otimizar execução
reutilizar eventos já registrados
Dependências
Dependências representam sistemas, módulos ou capacidades necessárias para uma Function existir ou executar corretamente.
O carregamento de dependências é controlado pela runtime.
A linguagem suporta múltiplas dependências simultâneas e ativação parcial de sistemas específicos.
Estados
Estados representam condições atuais de entidades, jogadores, sistemas ou objetos.
Exemplos de estados possíveis:
vivo
morto
ativo
desligado
voando
carregando
com energia
sem energia
Estados são utilizados pela runtime para decidir quando funções devem ser executadas.
Runtime
A runtime Zeniris é responsável por:
interpretar bytecode .zni
controlar execução
monitorar estados
gerenciar dependências
executar observers
atualizar systems
controlar ciclos de atualização
otimizar chamadas repetitivas
reduzir verificações desnecessárias
A runtime foi desenvolvida para permanecer pequena, portátil e eficiente.
Bytecode .zni
Zeniris utiliza um formato binário próprio chamado .zni.
O objetivo do .zni é:
reduzir carregamento
acelerar execução
facilitar exportação
permitir compatibilidade entre plataformas
proteger parcialmente código-fonte
validar versões e permissões
Sistema de Observadores
Observadores permitem que a runtime acompanhe alterações importantes dentro do jogo ou aplicação.
Eles são usados para:
detectar mudanças
ativar systems
atualizar estados
reagir a eventos
reduzir processamento constante
Sistema Multilíngue
Zeniris possui suporte interno para múltiplos idiomas.
A linguagem reconhece:
palavras-chave
mensagens
erros
propriedades
em diferentes idiomas suportados pela runtime.
O objetivo é tornar o desenvolvimento mais acessível internacionalmente.
Build Tools
Zeniris possui ferramentas nativas para:
compilação
execução
exportação
empacotamento
geração de projetos
build Android
build Desktop
validação de módulos
As build tools fazem parte do ecossistema oficial da linguagem.
Exportação
Zeniris foi planejada para exportação multiplataforma.
O ecossistema suporta:
Linux
Android
Desktop
sistemas embarcados leves
O suporte Web e novos targets fazem parte da evolução futura da plataforma.
Engine Integration
Zeniris foi construída pensando em integração com engines, runtimes gráficas e sistemas interativos.
A linguagem pode ser usada:
em jogos 2D
em jogos 3D
em mods
em ferramentas
em aplicações reativas
em sistemas multiplayer
em engines proprietárias
Objetivo do Projeto
Zeniris busca oferecer:
uma sintaxe acessível
execução eficiente
runtime leve
modularidade
portabilidade
facilidade de expansão
integração multiplataforma
sem abandonar controle técnico e performance.
Estado Atual
O projeto encontra-se em desenvolvimento ativo.
O ecossistema já possui:
compilador funcional
parser
lexer
AST
runtime
build tools
exportação desktop
exportação Android
bytecode próprio
sistema de imports
observadores
módulos
game loop
sistema multilíngue
Licença
MIT License.
Zeniris
Reactive Runtime • State System

# 🇪🇸 Zeniris
Zeniris
Lenguaje de programación enfocado en juegos, sistemas reactivos y ejecución ligera.
Zeniris fue creado con el objetivo de simplificar la creación de juegos, mods y aplicaciones interactivas mediante una sintaxis basada en estados, dependencias y ejecución automática por runtime.
El lenguaje utiliza un modelo reactivo donde las funciones pueden activarse automáticamente según el estado del mundo, entidades o sistemas internos del juego.
Filosofía
Zeniris fue diseñado con enfoque en:
Simplicidad de lectura
Estructura modular
Runtime ligera
Ejecución reactiva
Portabilidad
Compilación rápida
Desarrollo accesible
Organización automática del comportamiento
El lenguaje evita exceso de boilerplate y reduce la necesidad de grandes cadenas de if, verificaciones constantes y sistemas gigantescos de eventos manuales.
Estructura del Lenguaje
La base de Zeniris está construida sobre:
Functions
Dependencias
Estados
Runtime reactiva
Observadores
Bytecode .zni
Sistema modular
Imports
Build tools
Runtime nativa
Sistema Reactivo
En Zeniris, las funciones pueden activarse automáticamente cuando determinados estados o dependencias son detectados por la runtime.
El programador describe:
dependencias
estados
restricciones
comportamiento
La runtime es responsable de:
monitorear estados
cargar dependencias necesarias
activar funciones automáticamente
optimizar ejecución
reutilizar eventos ya registrados
Dependencias
Las dependencias representan sistemas, módulos o capacidades necesarias para que una Function exista o se ejecute correctamente.
La carga de dependencias es controlada por la runtime.
El lenguaje soporta múltiples dependencias simultáneas y activación parcial de sistemas específicos.
Estados
Los estados representan condiciones actuales de entidades, jugadores, sistemas u objetos.
Ejemplos de estados posibles:
vivo
muerto
activo
apagado
volando
cargando
con energía
sin energía
Los estados son utilizados por la runtime para decidir cuándo las funciones deben ejecutarse.
Runtime
La runtime Zeniris es responsable de:
interpretar bytecode .zni
controlar ejecución
monitorear estados
gestionar dependencias
ejecutar observers
actualizar systems
controlar ciclos de actualización
optimizar llamadas repetitivas
reducir verificaciones innecesarias
La runtime fue desarrollada para mantenerse pequeña, portable y eficiente.
Bytecode .zni
Zeniris utiliza un formato binario propio llamado .zni.
El objetivo del .zni es:
reducir tiempos de carga
acelerar ejecución
facilitar exportación
permitir compatibilidad entre plataformas
proteger parcialmente el código fuente
validar versiones y permisos
Sistema de Observadores
Los observadores permiten que la runtime supervise cambios importantes dentro del juego o aplicación.
Son utilizados para:
detectar cambios
activar systems
actualizar estados
reaccionar a eventos
reducir procesamiento constante
Sistema Multilenguaje
Zeniris posee soporte interno para múltiples idiomas.
El lenguaje reconoce:
palabras clave
mensajes
errores
propiedades
en diferentes idiomas soportados por la runtime.
El objetivo es hacer el desarrollo más accesible internacionalmente.
Build Tools
Zeniris posee herramientas nativas para:
compilación
ejecución
exportación
empaquetado
generación de proyectos
build Android
build Desktop
validación de módulos
Las build tools forman parte oficial del ecosistema del lenguaje.
Exportación
Zeniris fue planeado para exportación multiplataforma.
El ecosistema soporta:
Linux
Android
Desktop
sistemas embebidos ligeros
El soporte Web y nuevos targets forman parte de la evolución futura de la plataforma.
Integración con Engines
Zeniris fue construido pensando en integración con engines, runtimes gráficas y sistemas interactivos.
El lenguaje puede utilizarse:
en juegos 2D
en juegos 3D
en mods
en herramientas
en aplicaciones reactivas
en sistemas multijugador
en engines propietarias
Objetivo del Proyecto
Zeniris busca ofrecer:
una sintaxis accesible
ejecución eficiente
runtime ligera
modularidad
portabilidad
facilidad de expansión
integración multiplataforma
sin abandonar el control técnico y el rendimiento.
Estado Actual
El proyecto se encuentra en desarrollo activo.
El ecosistema ya posee:
compilador funcional
parser
lexer
AST
runtime
build tools
exportación desktop
exportación Android
bytecode propio
sistema de imports
observadores
módulos
game loop
sistema multilenguaje
Licencia
MIT License.
Zeniris
Reactive Runtime • State System

# 🏴󠁧󠁢󠁥󠁮󠁧󠁿 Zeniris
Zeniris
Programming language focused on games, reactive systems, and lightweight execution.
Zeniris was created with the goal of simplifying the development of games, mods, and interactive applications through a syntax based on states, dependencies, and automatic runtime execution.
The language uses a reactive model where functions can be automatically activated according to the state of the world, entities, or internal game systems.
Philosophy
Zeniris was designed with focus on:
Readability
Modular structure
Lightweight runtime
Reactive execution
Portability
Fast compilation
Accessible development
Automatic behavior organization
The language avoids excessive boilerplate and reduces the need for massive if chains, constant checks, and oversized manual event systems.
Language Structure
The foundation of Zeniris is built around:
Functions
Dependencies
States
Reactive runtime
Observers
.zni bytecode
Modular system
Imports
Build tools
Native runtime
Reactive System
In Zeniris, functions can automatically activate when specific states or dependencies are detected by the runtime.
The developer describes:
dependencies
states
restrictions
behavior
The runtime is responsible for:
monitoring states
loading required dependencies
activating functions automatically
optimizing execution
reusing registered events
Dependencies
Dependencies represent systems, modules, or capabilities required for a Function to exist or execute properly.
Dependency loading is controlled by the runtime.
The language supports multiple simultaneous dependencies and partial activation of specific systems.
States
States represent current conditions of entities, players, systems, or objects.
Examples of possible states:
alive
dead
active
disabled
flying
charging
energized
exhausted
States are used by the runtime to determine when functions should execute.
Runtime
The Zeniris runtime is responsible for:
interpreting .zni bytecode
controlling execution
monitoring states
managing dependencies
executing observers
updating systems
controlling update cycles
optimizing repeated calls
reducing unnecessary checks
The runtime was designed to remain small, portable, and efficient.
.zni Bytecode
Zeniris uses its own native binary format called .zni.
The purpose of .zni is to:
reduce loading times
improve execution speed
simplify export systems
allow cross-platform compatibility
partially protect source code
validate versions and permissions
Observer System
Observers allow the runtime to monitor important changes inside the game or application.
They are used to:
detect changes
activate systems
update states
react to events
reduce constant processing
Multilanguage System
Zeniris includes internal support for multiple languages.
The language can recognize:
keywords
messages
errors
properties
across different languages supported by the runtime.
The goal is to make development more accessible internationally.
Build Tools
Zeniris includes native tools for:
compilation
execution
exporting
packaging
project generation
Android builds
Desktop builds
module validation
The build tools are part of the official ecosystem of the language.
Export System
Zeniris was designed for multiplatform exporting.
The ecosystem currently supports:
Linux
Android
Desktop
lightweight embedded systems
Web support and additional targets are part of the future roadmap of the platform.
Engine Integration
Zeniris was designed with integration in mind for engines, graphical runtimes, and interactive systems.
The language can be used for:
2D games
3D games
mods
tools
reactive applications
multiplayer systems
proprietary engines
Project Goal
Zeniris aims to provide:
accessible syntax
efficient execution
lightweight runtime
modularity
portability
scalability
multiplatform integration
without sacrificing technical control and performance.
Current Status
The project is currently under active development.
The ecosystem already includes:
functional compiler
parser
lexer
AST
runtime
build tools
desktop exporting
Android exporting
native bytecode
import system
observers
modules
game loop
multilanguage system
License
MIT License.
Zeniris
Reactive Runtime • State System
