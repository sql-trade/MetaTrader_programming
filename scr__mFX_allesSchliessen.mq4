//+------------------------------------------------------------------+
//|                                          mFX-AllesSchliessen.mq4 |
//|                                       Copyright 2016, mindful FX |
//|                        http://www.mindfulfx.de/ea-programmierung |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, mindful FX"
#property link      "http://www.mindfulfx.de/ea-programmierung"
#property version   "1.00"
#property strict

//--- input parameters

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
      for(int Count = 0; Count<=OrdersTotal()-1 ; Count++)
         {
            if(OrderSelect(Count,SELECT_BY_POS,MODE_TRADES))
               {
                  int ot=OrderTicket();
                  if(OrderType()<=1)
                     {
                        double closeprice=Ask;
                        if(OrderType()==OP_BUY)closeprice=Bid;
                        while(IsTradeContextBusy()) Sleep(10);
                        bool oc=OrderClose(OrderTicket(),OrderLots(),closeprice,100,clrPeru);
                        if(!oc)Print("Ordernummer ",ot," konnte nicht geschlossen werden wg Fehler Code ",GetLastError());
                        else Count--;
                     }
                  else
                     {
                        while(IsTradeContextBusy()) Sleep(10);
                        bool od=OrderDelete(OrderTicket(),clrPeru);
                        if(!od)Print("Ordernummer ",ot," konnte nicht gelöscht werden wg Fehler Code ",GetLastError());
                        else Count--;
                     }
               }
         }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
