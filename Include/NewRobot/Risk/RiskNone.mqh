//+------------------------------------------------------------------+
//|                                                     RiskNone.mqh |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <NewRobot\ManagerRisk.mqh>

class RiskNone : public ManagerRisk
  {
private:

public:
                     RiskNone();
                    ~RiskNone();
  };
RiskNone::RiskNone()
  {
  }
RiskNone::~RiskNone()
  {
  }
//+------------------------------------------------------------------+
