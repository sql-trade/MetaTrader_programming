//+------------------------------------------------------------------+
//|                                           netCDE_setStopLoss.mq4 |
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
   string pFilter  = "";              //-- inputParameter

   string currSymb ;  //-- Symbol
   int    currTiNo ;  //-- TicketNo
   int    currType ;  //-- [ 0 = buy | 1 = sell ] //-- https://docs.mql4.com/trading/ordertype
                                                  //-- https://docs.mql4.com/constants/tradingconstants/orderproperties
 
   double PriceAsk = MarketInfo(Symbol(), MODE_ASK);
   double PriceBid = MarketInfo(Symbol(), MODE_BID);  //-- Close[0]
                                                  
   double currTPvalue ;               //-- current setting TakeProfit
   double currSLvalue ;               //-- current setting StopLoss
   //-- double trgtTPvalue ;               //-- target setting  TakeProfit
   //-- double trgtSLvalue ;               //-- target setting  StopLoss
   
   if(OrderSelect(0,SELECT_BY_POS)==true)
   {
      Print("info: *** 'if(OrderSelect(0,SELECT_BY_POS)==true)' *** ");
      
      currSymb = OrderSymbol();   //-- Symbol = Underlying
      currTiNo = OrderTicket();   //-- TicketNumber 
      currType = OrderType();      
            
      currTPvalue = OrderTakeProfit();
      currSLvalue = OrderStopLoss();

      if(currType == 0)   //-- buy
      {
         bool res = OrderModify( currTiNo, OrderOpenPrice(), NormalizeDouble(Bid-50*Point, Digits), OrderTakeProfit(), 0, clrNONE );  
              if(!res)
                 Print("Error in OrderModify. Error code=",GetLastError());
              else
                 Print("Order modified successfully.");
              //--  end if   
         Print("info: calc 'Bid-50*Point' ");
      }  
      
      if(currType == 1)   //-- sell
      {
         bool res = OrderModify( currTiNo, OrderOpenPrice(), NormalizeDouble(Ask+50*Point, Digits), OrderTakeProfit(), 0, clrNONE );  
              if(!res)
                 Print("Error in OrderModify. Error code=",GetLastError());
              else
                 Print("Order modified successfully.");
              //--  end if   
         Print("info: calc 'Ask+50*Point' ");        
      }  

      Print("currTiNo: ", currTiNo);
      Print("currSymb: ", currSymb);
      Print("currType: ", currType);

      Print("PriceAsk: ", PriceAsk);
      Print("PriceBid: ", PriceBid);

      Print("currTPvalue: ", currTPvalue);
      Print("currSLvalue: ", currSLvalue);

   }
   else
   {
      Print("OrderSelect failed error code is ", GetLastError());
   } 
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
