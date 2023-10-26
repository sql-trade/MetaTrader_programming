//+------------------------------------------------------------------+
//|                                   netCDE_getSignalProperties.mq4 |
//|                                    Copyright 2023, .net-CDE GmbH |
//|                                           https://www.net-CDE.de |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, .net-CDE GmbH"
#property link      "https://www.net-CDE.de"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
      //-- https://docs.mql4.com/constants/tradingconstants/signalproperties

      Print("currTiNo: ", OrderTicket() );   //-- TicketNumber ); 
      Print("currSymb: ", OrderSymbol() );                        
      Print("currType: ", OrderType()   );   //-- [ 0 = buy | 1 = sell ] //-- https://docs.mql4.com/trading/ordertype
                                             //-- https://docs.mql4.com/constants/tradingconstants/orderproperties   

        
      Print("currTPvalue: ", OrderTakeProfit() );
      Print("currSLvalue: ", OrderStopLoss()   );   
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
