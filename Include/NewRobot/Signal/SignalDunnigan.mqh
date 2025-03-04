//+------------------------------------------------------------------+
//|                                               SignalDunnigan.mqh |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <NewRobot\ManagerSignal.mqh>

//-- Sinal de entrada Dunnigan
class SignalDunnigan : public ManagerSignal
  {
private:
   int               m_number_barras;

public:
                     SignalDunnigan();

   void              SetNumberBars(int value)   {     m_number_barras = value;      };
   bool              CheckOpenBuy(double &price,double &sl,double &tp,datetime &expiration);
   bool              CheckOpenSell(double &price,double &sl,double &tp,datetime &expiration);
   bool              CheckCloseOrderSell();
   bool              CheckCloseOrderBuy();

  };
//--
SignalDunnigan::SignalDunnigan()
  {
   this.m_number_barras = 3;//default 3 barras sequenciais
  }
//-- Verifica condições para cancelamento de Sell Order Stop/Limit
bool SignalDunnigan::CheckCloseOrderSell()
  {
   return(false);
  }
//-- Verifica condições para cancelamento de Buy Order Stop/Limit
bool SignalDunnigan::CheckCloseOrderBuy()
  {
   return(false);
  }
//-- Verifica condições de Compra
bool SignalDunnigan::CheckOpenBuy(double &price,double &sl,double &tp,datetime &expiration)
  {
   int quantity = 0;
   int index_candle = 1;

//--https://www.youtube.com/watch?v=_LZzc2wTZi0

//-- vamos analisar 6 candles a partir do index 1, ou seja, a partir candle anterior
//-- e verificar quantos se enquanta na condições de (máxima e mínimas) mais baixas
   for(int i=0; i<6; i++)
     {
      //-- 1-verifica se a mínima do candle atual é MENOR do que a do candle anterior
      //-- 2-verifica se a máxima do candle atual é MENOR do que a do candle anterior
      if(m_series.Low(index_candle)<m_series.Low(index_candle+1)&& m_series.High(index_candle)<m_series.High(index_candle+1))
         quantity++;
      else
         break;
      index_candle++;
     }

   quantity++;//-- incrementa mais, pois o primeiro candle da sequencia também deve ser levado em consideração

//-- agora verifica se a quantidade de candles identificados no FOR é maior ou igual a quantidade esperada
   if(quantity>=m_number_barras)
     {
      //-- acha o preço onde deve posicionar a order stop
      //-- usa o price_level para isso

      price = m_symbol.NormalizePrice(m_series.High(1)+m_price_level);
      sl = StopLoss(price, false);
      tp = TakeProfit(price, false);
      return true;
     }
   return(false);
  }
//-- Verifica condições de Venda
bool SignalDunnigan::CheckOpenSell(double &price,double &sl,double &tp,datetime &expiration)
  {
   int quantity= 0;
   int index_candle = 1;

//--https://www.youtube.com/watch?v=_LZzc2wTZi0

//-- vamos analisar 6 candles a partir do index 1, ou seja, a partir candle anterior
//-- e verificar quantos se enquanta na condições de (máxima e mínimas) mais altas
   for(int i=0; i<=6; i++)
     {
      //-- 1-verifica se a mínima do candle atual é MAIOR do que a do candle anterior
      //-- 2-verifica se a máxima do candle atual é MAIOR do que a do candle anterior
      if(m_series.Low(index_candle)>m_series.Low(index_candle+1)&& m_series.High(index_candle)>m_series.High(index_candle+1))
         quantity++;
      else
         break;
      index_candle++;
     }

   quantity++;//-- incrementa mais, pois o primeiro candle da sequencia também deve ser levado em consideração

//-- agora verifica se a quantidade de candles identificados no FOR é maior ou igual a quantidade esperada
   if(quantity>=m_number_barras)
     {
      //-- acha o preço onde deve posicionar a order stop
      //-- usa o price_level para isso
      price = m_symbol.NormalizePrice(m_series.Low(1)-m_price_level);
      sl = StopLoss(price, true);
      tp = TakeProfit(price, true);
      return true;
     }
   return(false);
  }
//+------------------------------------------------------------------+
