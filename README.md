# MQL5: Estrutura Rápida
Estrutura rápida para implementação de novas estratégias e sinais de entrada.

Quando comecei codificar meus próprios robôs em MQL5, toda vez que precisava desenvolver algum sinal, além de codificar o próprio sinal, 
havia a necessidade de programar também as funções básicas, tais como: abrir posição, encerrar posição, cancelar entradas e etc. Depois
de algum tempo surgiu mais necessidades, como: aumento de posição, saídas parciais, break even, trailing stop, horários e outros.
Cansado de sofrer com isso, comecei pesquisar sobre estruturas prontas que oferecessem uma forma fácil e padrão dos principais recursos de 
entrada e saída de um trade, então e me deparei como o ***"Assistente MQL5"*** que facilitava a implementação
de estratégias. Tentei usar, pesquisei sobre, no entanto, achei muito complicado e também não consegui nem encontrei formas e adicionar os
recursos que mais utilizava. Então, a partir do Assistente MQL5 comecei a me aprofundar mais na linguagem, aprender mais sobre e criar minha própria estrutura com os recursos que mais usava.

***Observação:***
Para codificar usei ***Assistente MQL5*** como base, não quis reinventar a roda em alguns aspectos, apenas criar algo que eu tivesse 100% de controle, aprender mais sobre codificação na linguagem e desenvolver recursos que fossem atender minhas necessidades.

### Conta HEDGE e NET
Até o momento, 29/12/2019, foi criado para abrir/gerenciar apenas uma posição por vez

## Principais Classes
- Tudo gira em torno dessas 4 classes

\Include\ManagerExpert.mqh: Responsável por executar e gerenciar trade

\Include\ManagerTrailing.mqh: Classe base com métodos virtuais para serem sobrescritos por novas classes de Trailing Stop. Toda classe com uma nova lógica de trailing stop deve herdar desta.

\Include\ManagerSignal.mqh: Classe base com métodos virtuais para serem sobrescritos por novas classes de Sinais. Toda classe com nova lógica de sinal deve herdar desta.

\Include\ManagerRisk.mqh: Classe base com métodos virtuais para serem sobrescritos por novas classes de Risco. Toda classe com nova lógica de risco deve herdar desta.

## Exemplo: Posição aberta
Exemplo de posição aberta de venda, Stop Loss posicionado e as 3 ordens para aumento de posição também posicionadas

![venda-incremento](https://user-images.githubusercontent.com/2820984/71563115-1fb35300-2a69-11ea-9172-ce7f33015ae6.jpg)

## Recursos Padrões

#### Aumento de Posição/Entrada Parcial
Por padrão é possível fazer até 3 aumento de posição

-ManagerExpert
<ul>
  <li> SetInputPartial1(lote, level)</li>
  <li> SetInputPartial2(lote, level)</li>
  <li> SetInputPartial3(lote, level)</li>
</ul>      

Lote.: Tamanho do lote do aumento

Level.: A distância em pontos a partir do preço da posição aberta

![aumento-posicao](https://user-images.githubusercontent.com/2820984/71563201-5e95d880-2a6a-11ea-9e5a-9525f7bea868.jpg)

#### Saídas Parciais
Por padrão é possível fazer até 3 saídas parciais

-ManagerExpert
<ul>
  <li> SetOutputPartial1(lote, level)</li>
  <li> SetOutputPartial2(lote, level)</li>
  <li> SetOutputPartial3(lote, level)</li>
</ul>

Lote.: Tamanho do lote da parcial

Level.: A distância em pontos a partir do preço da posição aberta

![saidas-parciais](https://user-images.githubusercontent.com/2820984/71563195-48881800-2a6a-11ea-80fa-cf2e9a3fa1a7.jpg)

#### Break Even
Por padrão é possível fazer até 3 break even

-ManagerExpert
<ul>
  <li> SetBreakEven1(level, stopgain)</li>
  <li> SetBreakEven2(level, stopgain)</li>
  <li> SetBreakEven3(level, stopgain)</li>
</ul>      

Level.: A distância em pontos a partir do preço da posição aberta

Stopgain.: Distância em pontos que deve ser protegido

![breakeven](https://user-images.githubusercontent.com/2820984/71563199-550c7080-2a6a-11ea-85c5-3a303b0d3053.jpg)

#### Horários
Existem 3 configurações de horários. 1-horário para iniciar os trades, procurar por operações, 2-horário para encerrar procura de trades e 3-horário de encerramento das posições e/ou ordens pendentes abertas

SetHoursLimits("09:05", "17:00", "17:30");

#### Reversão de Posição
Por padrão é feito procura de entradas contrárias da posição aberta. Por exemplo, em posição aberta de compra o gerenciador estará procurando por vendas. Para desabilitar, é possível fazer de duas formas, setando False na função ***SetIsReserve*** da classe de base ManagerSignal. Ou reescrever as funções virtual CheckReverseSell e CheckReverseBuy retornando False ou adicionando a lógica correta para fazer a reversão.

## Considerações finais
- Em \Robot foi criado um exemplo usando os principais recursos na implementação setup ***Dunnigan***
- Apesar de ter usado o ***Assistente MQL5*** como base, após  ter codificado tudo isso aprendi muito sobre a linguagem MQL5, até então não dominava muito bem.
