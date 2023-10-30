//+------------------------------------------------------------------+
//|                                            netCDE_saveCharts.mq4 |
//|                                    Copyright 2023, .net-CDE GmbH |
//|                                           https://www.net-CDE.de |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, .net-CDE GmbH"
#property link      "https://www.net-CDE.de"
#property version   "1.00"
#property strict

#include  <charts/chart.mqh>
#include  <stdlib.mqh>

#define HOUR_MS (60 * 60 * 1000)
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
{
//---
    CChart chart;
    while ( !IsStopped() )  //--  ?? StoppEvent ?
    {
       for ( long cid=ChartFirst(); cid>=0 && !IsStopped(); cid=ChartNext(cid) )
       {
         chart.Attach(cid);   
         
         string timeframe = EnumToString( (ENUM_TIMEFRAMES)chart.Period() );
         string filename  = StringFormat( "%I64d-%s.png", cid, timeframe );
         if ( !chart.ScreenShot( filename, chart.WidthInPixels(), chart.HeightInPixels(0) ))
            {
               Print(ErrorDescription(GetLastError() ));
            }  //-- end if
       
         chart.Detach();
       }  //-- end for        
       Sleep(60000);  //-- milliseconds >> 6ß*1000 = 1min    
    }  //-- end while
  }
//+------------------------------------------------------------------+
