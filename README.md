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

## Exemplos

Para exemplificar a implementação e uso da estrutura e dos principais recursos, foi feito uma codificação para o setup ***Dunnigan***

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

Level.: A distância em pontos com base no preço da posição aberta

#### Saídas Parciais
Por padrão é possível fazer até 3 saídas parciais

-ManagerExpert
<ul>
  <li> SetOutputPartial1(lote, level)</li>
  <li> SetOutputPartial2(lote, level)</li>
  <li> SetOutputPartial3(lote, level)</li>
</ul>      

Lote.: Tamanho do lote da parcial

Level.: A distância em pontos com base no preço da posição aberta

#### Break Even
Por padrão é possível fazer até 3 break even

-ManagerExpert
<ul>
  <li> SetBreakEven1(level, stopgain)</li>
  <li> SetBreakEven2(level, stopgain)</li>
  <li> SetBreakEven3(level, stopgain)</li>
</ul>      

Level.: A distância em pontos com base no preço da posição aberta

Stopgain.: Distância em pontos que deve ser protegido

#### Horários
Existem 3 configuração de horário. 1-horário para iniciar os trades, procurar por operações, 2-horário para encerrar procura de trades e 3-horário de encerramento das posições ou ordens pendentes que foram abertas

SetHoursLimits("09:05", "17:00", "17:30");

#### Reversão de Posição
Por padrão é feito procura de entradas contrárias da posição aberta. Por exemplo, em posição aberta de compra o gerenciador estará procurando entradas em vendas. Para desabilitar, é possível fazer de duas formas. Setando False na função ***SetIsReserve*** da classe de base ManagerSignal. Ou reescrever as funções virtual CheckReverseSell e CheckReverseBuy retornando False ou adicionando a lógica correta para fazer a reversão.
