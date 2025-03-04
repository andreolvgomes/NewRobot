//+------------------------------------------------------------------+
//|                                                     Dunnigan.mq5 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <NewRobot\ManagerExpert.mqh>
#include <NewRobot\ManagerTrailing.mqh>
#include <NewRobot\ManagerSignal.mqh>
#include <NewRobot\ManagerRisk.mqh>

#include <NewRobot\Signal\SignalDunnigan.mqh>
#include <NewRobot\Trailing\TrailingNone.mqh>

ManagerExpert *manager;

//-- OnInit
int OnInit()
  {
   ChartSetInteger(0, CHART_SHOW_GRID, false); // false to remove grid

//-- responsável por gerenciar e executação de ordens e posições
   manager = new ManagerExpert;
//-- time frame e magic
   manager.Init(PERIOD_M2, 123456);
//-- Limite para expirar ordens pendentes
   manager.SetExpiration(1);
//-- Horários:
//-- 1-hora de iniciar entradas do dia
//-- 2-hora de encerrar entradas do dia
//-- 3-hora de encerrar posições/ordens abertas do dia
   manager.SetHoursLimits("09:05", "17:00", "17:30");

//-- ENTRADAS PARCIAIS;AUMENTO DE POSIÇÃO
//-- Aumento 1: a 100 pontos do pç da posição entrar com lote=2
   manager.SetInputPartial1(2, 100);
//-- Aumento 2: a 150 pontos do pç da posição entrar com lote=2
   manager.SetInputPartial2(2, 150);
//-- Aumento 3: a 200 pontos do pç da posição entrar com lote=2
   manager.SetInputPartial3(2, 200);

//-- SAÍDAS PARCIAIS
//-- Parcial 1: com 100 pontos liquida lote=1
   manager.SetOutputPartial1(1, 100);
//-- Parcial 2: com 150 pontos liquida lote=1
   manager.SetOutputPartial2(1, 150);
//-- Parcial 3: com 200 pontos liquida lote=1
   manager.SetOutputPartial3(1, 200);

//-- BREAK EVEN
//-- BreakEven 1: 250 pontos a favor protege 5 pontos
   manager.SetBreakEven1(250, 5);
//-- BreakEven 2: 300 pontos a favor protege 50 pontos
   manager.SetBreakEven2(300, 50);
//-- BreakEven 3: 350 pontos a favor protege 100 pontos
   manager.SetBreakEven3(350, 100);

//-- SINAL DE NEGOCIAÇÃO
   SignalDunnigan *signal = new SignalDunnigan;
//-- número de barras sequenciais
   signal.SetNumberBars(3);
//-- reversão de posição; default: Sim
   signal.SetIsReserve(false);
//-- ponto price level, nesse exemplo, 5 ponto abaixo da mínima/máxima do candle de referência
   signal.SetPriceLevel(5);
//-- pontos stop loss
   signal.SetStopLoss(300);
//-- pontos take profit
   signal.SetTakeProfit(500);
   manager.InitSignal(signal);

//-- TRAILING STOP
//-- TrailingNone usada para exemplo
   TrailingNone *trailing = new TrailingNone;
   manager.InitTrailing(trailing);

//-- gerenciamento de risco
   ManagerRisk *risk = new ManagerRisk;
   risk.SetLots(2);
   risk.SetMaximumInputs(10);
   risk.SetMaximumLoss(10000);
   risk.SetMaximumProfit(10000);
   manager.InitRisk(risk);

   return(INIT_SUCCEEDED);
  }
//-- OnTick
void OnTick()
  {
   manager.Execute();
  }
//+------------------------------------------------------------------+
