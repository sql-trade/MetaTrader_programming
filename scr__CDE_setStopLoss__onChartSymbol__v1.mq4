//+------------------------------------------------------------------+
//|                        netCDE_setStopLoss__onChartSymbol__v1.mq4 |
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
   Print(">>>> start ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
   Print(">>>> start ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
      
   string pSymbol = Symbol();
   int currTiNo ; //-- TicketNumber 
   int currType ; //-- buy/sell    

   for(int ii=0; ii <= OrdersTotal() -1; ii++) 
   {
      Print("ii-->Begin: " + IntegerToString( ii ) );
      if(OrderSelect(ii,SELECT_BY_POS)==true)
      {
         Print("info: *** 'if(OrderSelect(" + IntegerToString(ii) + ",SELECT_BY_POS)==true)' *** ");
         Print("pSymbol:  ", pSymbol       );
         Print("OrderSym: ", OrderSymbol() );
         
         currTiNo = OrderTicket();
         currType = OrderType();   
         
         if( pSymbol == OrderSymbol() )
         {
             Print("if-case: modify Order");
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
         }
         else   
             Print("else-case: NO OrderModification");
             
        }  //-- end if(OrderSelect(ii,SELECT_BY_POS)==true)
      
         Print("ii-->End: " + IntegerToString( ii ) );
        //-------------------------------------------------
    }  //-- end for  

  }  //-- end OnStart(
//+------------------------------------------------------------------+
