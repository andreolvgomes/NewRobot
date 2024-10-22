//+------------------------------------------------------------------+
//|                                                 ManageSignal.mqh |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Trade\PositionInfo.mqh>
#include <NewRobot\Utility\Series.mqh>
#include <NewRobot\Utility\Logs.mqh>
//#include <NewRobot\Utility\Functions.mqh>

//-- Classe base para implementação de Sinais/Técnicas de Entradas
class ManagerSignal//:public CObject
  {
protected:
   Series            m_series;
   double            m_stop_loss;
   double            m_take_profit;
   double            m_price_level;
   bool              m_reserve;
   CSymbolInfo       *m_symbol;         // pointer to the object-symbol
   ENUM_TIMEFRAMES   m_period;

public:
                     ManagerSignal();
   bool              IsNewBar();

   CLog*             Log;                 // Logging
   void              Init(ENUM_TIMEFRAMES period, CSymbolInfo *m_symbol);

   //-- funções para injetar valores p/ dentro da classe/objeto
   void              SetStopLoss(double value)     { m_stop_loss=value;       }
   void              SetTakeProfit(double value)   { m_take_profit=value;     }
   void              SetPriceLevel(double value)   { m_price_level=value;     }
   void              SetIsReserve(bool value) {this.m_reserve=value;}

   //-- obtem valores definidos de Take Profit e Stop Loss
   double            TakeProfit()                  {  return(m_take_profit);  };
   double            StopLoss()                    {  return(m_stop_loss);    };

   //-- funções para checar sinal de entrada buy/sell
   //-- virtuais para serem reescritas pela nova classe de sinais/técnicas
   virtual bool      CheckOpenBuy(double &price,double &sl,double &tp,datetime &expiration)        {  return (false);   };
   virtual bool      CheckOpenSell(double &price,double &sl,double &tp,datetime &expiration)       {  return (false);   };

   //-- funções para checar sinal de cancelamento de ordens pendentes
   //-- virtuais para serem reescritas pela nova classe de sinais/técnicas
   virtual bool      CheckCloseOrderSell() {  return (false);   };
   virtual bool      CheckCloseOrderBuy()  {  return (false);   };

   //-- função para reversão de posição
   //-- virtuais para serem reescritas pela nova classe de sinais/técnicas
   virtual bool      CheckReverseSell(double &price,double &sl,double &tp,datetime &expiration)
     {
      if(!m_reserve)
         return false;
      return (CheckOpenBuy(price,sl, tp, expiration));
     };
   virtual bool      CheckReverseBuy(double &price,double &sl,double &tp,datetime &expiration)
     {
      if(!m_reserve)
         return false;
      return (CheckOpenSell(price, sl, tp, expiration));
     };

protected:
   double            TakeProfit(double price, bool isSell);
   double            StopLoss(double price, bool isSell);
   //Functions         *function;
  };

//--Construtor
ManagerSignal::ManagerSignal()
  {
   Log=CLog::GetLog();
   m_series = new Series;
   m_stop_loss = 0;
   m_take_profit = 0;
   m_reserve = true;
  }
//-- Inicialização de objetos default da classe
void ManagerSignal::Init(ENUM_TIMEFRAMES period, CSymbolInfo *symbol)
  {
//function = new Functions();
//function.Init(symbol, period);

   m_period = period;
   m_series.Init(symbol.Name(), period);
   m_symbol = symbol;
  }
//-- Cálcula preço para posicionamento do Take Profit seguindo o que foi definido pela função
//-- SetTakeProfit(double value)
double ManagerSignal::TakeProfit(double price, bool isSell)
  {
   if(m_take_profit==0)
      return 0;

   if(isSell)
      return price-m_take_profit;
   return price+m_take_profit;
  }
//-- Cálcula preço para posicionamento do Stop Loss seguindo o que foi definido pela função
//-- SetStopLoss(double value)
double ManagerSignal::StopLoss(double price, bool isSell)
  {
   if(m_stop_loss== 0)
      return 0;
   if(isSell)
      return price+m_stop_loss;
   return price-m_stop_loss;
  }
//--
//+------------------------------------------------------------------+
//--
static datetime last_time_=0;
//--
bool ManagerSignal::IsNewBar()
  {
//--- memorize the time of opening of the last bar in the static variable
//--- current time
   datetime lastbar_timed=SeriesInfoInteger(m_symbol.Name(),m_period,SERIES_LASTBAR_DATE);
//--- if it is the first call of the function
   if(last_time_==0)
     {
      //--- set the time and exit
      last_time_=lastbar_timed;
      return(false);
     }
//--- if the time differs
   if(last_time_!=lastbar_timed)
     {
      //--- memorize the time and return true
      last_time_=lastbar_timed;
      return(true);
     }
//--- if we passed to this line, then the bar is not new; return false
   return(false);
  }
//+------------------------------------------------------------------+
