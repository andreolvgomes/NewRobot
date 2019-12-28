//+------------------------------------------------------------------+
//|                                                       Series.mqh |
//|                                 Copyright 2015, Vasiliy Sokolov. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, Vasiliy Sokolov."
#property link      "http://www.mql5.com"
//+------------------------------------------------------------------+
//| Access to quotes of the required instrument and timeframe.       |
//+------------------------------------------------------------------+
class Series
  {
protected:
   string            m_symbol;
   ENUM_TIMEFRAMES   m_timeframe;

public:

                     Series();

   void              Init(string symbol, ENUM_TIMEFRAMES timeframe);
   int               Total(void);

   double            Open(int index, ENUM_TIMEFRAMES timeframe = WRONG_VALUE);
   double            High(int index);
   double            Low(int index);
   double            Close(int index);
   long              Volume(int index);
   long              TickVolume(int index);
   datetime          Time(int index);
   int               Amp(int index);
   ENUM_TIMEFRAMES   TimeFrame() {return m_timeframe;};
  };

//--Price of the Close
double Series::Open(int index, ENUM_TIMEFRAMES timeframe = WRONG_VALUE)
  {
   if(timeframe == WRONG_VALUE)
      timeframe = m_timeframe;

   double value[];
   if(CopyOpen(m_symbol, timeframe, index, 1, value) == 0)
      return 0.0;
   return value[0];
  }
//--Price of the Close
double Series::High(int index)
  {
   double value[];
   if(CopyHigh(m_symbol, m_timeframe, index, 1, value) == 0)
      return 0.0;
   return value[0];
  }
double Series::Low(int index)
  {
   double value[];
   if(CopyLow(m_symbol, m_timeframe, index, 1, value) == 0)
      return 0.0;
   return value[0];
  }
double Series::Close(int index)
  {
   double value[];
   if(CopyClose(m_symbol, m_timeframe, index, 1, value) == 0)
      return 0.0;
   return value[0];
  }
long Series::Volume(int index)
  {
   long value[];
   if(CopyRealVolume(m_symbol, m_timeframe, index, 1, value) == 0)
      return 0;
   return value[0];
  }
long Series::TickVolume(int index)
  {
   long value[];
   if(CopyTickVolume(m_symbol, m_timeframe, index, 1, value) == 0)
      return 0;
   return value[0];
  }
datetime Series::Time(int index)
  {
   datetime value[];
   if(CopyTime(m_symbol, m_timeframe, index, 1, value) == 0)
      return 0;
   return value[0];
  }
int Series::Amp(int index)
  {
   return (int)MathAbs(High(index) -Low(index));
  }
//+------------------------------------------------------------------+
//| Default constructor.                                             |
//+------------------------------------------------------------------+
Series::Series()
  {
  }
//+------------------------------------------------------------------+
//| Sets the timeframe of the symbol.                                |
//+------------------------------------------------------------------+
void Series::Init(string symbol,ENUM_TIMEFRAMES timeframe)
  {
   m_symbol = symbol;
   m_timeframe=timeframe;
  }
//+------------------------------------------------------------------+
//| Returns the available number of bars.                            |
//+------------------------------------------------------------------+
int Series::Total(void)
  {
   return Bars(m_symbol, m_timeframe);
  }
//+------------------------------------------------------------------+
//| Access to Open prices of the required instrument and timeframe.  |
//+------------------------------------------------------------------+
class Open : public Series
  {
public:
   double            operator[](int index)
     {
      double value[];
      if(CopyOpen(m_symbol, m_timeframe, index, 1, value) == 0)
         return 0.0;
      return value[0];
     }
  };
//+------------------------------------------------------------------+
//| Access to High prices of the instrument bar.                     |
//+------------------------------------------------------------------+
class High : public Series
  {
public:
   double            operator[](int index)
     {
      double value[];
      if(CopyHigh(m_symbol, m_timeframe, index, 1, value) == 0)
         return 0.0;
      return value[0];
     }
  };
//+------------------------------------------------------------------+
//| Access to Low prices of the instrument bar.                      |
//+------------------------------------------------------------------+
class Low : public Series
  {
public:
   double            operator[](int index)
     {
      double value[];
      if(CopyLow(m_symbol, m_timeframe, index, 1, value) == 0)
         return 0.0;
      return value[0];
     }
  };
//+------------------------------------------------------------------+
//| Access to Close prices of the symbol bar.                        |
//+------------------------------------------------------------------+
class Close : public Series
  {
public:
   double            operator[](int index)
     {
      double value[];
      if(CopyClose(m_symbol, m_timeframe, index, 1, value) == 0)
         return 0.0;
      return value[0];
     }
  };
//+------------------------------------------------------------------+
//| Access to real volumes of a symbol bar.                          |
//+------------------------------------------------------------------+
class Volume : public Series
  {
public:
   long              operator[](int index)
     {
      long value[];
      if(CopyRealVolume(m_symbol, m_timeframe, index, 1, value) == 0)
         return 0;
      return value[0];
     }
  };
//+------------------------------------------------------------------+
//| Access to tick volumes of a symbol bar.                          |
//+------------------------------------------------------------------+
class TickVolume : public Series
  {
public:
   long              operator[](int index)
     {
      long value[];
      if(CopyTickVolume(m_symbol, m_timeframe, index, 1, value) == 0)
         return 0;
      return value[0];
     }
  };
//+------------------------------------------------------------------+
//| Access to the bar opening time.                                  |
//+------------------------------------------------------------------+
class Time : public Series
  {
public:
   datetime          operator[](int index)
     {
      datetime value[];
      //ArraySetAsSeries(value,true);
      if(CopyTime(m_symbol, m_timeframe, index, 1, value) == 0)
         return 0;
      return value[0];
     }
  };
//+------------------------------------------------------------------+
