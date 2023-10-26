#property copyright   "Copyright 2023, .net-CDE"
#property description "print '(all) openOrders'"

#define   VERSION "1.0"
#property version VERSION
#property strict

#property indicator_chart_window

#define PROJECT_NAME MQLInfoString(MQL_PROGRAM_NAME)



//--input color ClrText = clrOrangeRed; //Schriftfarbe
input int FontSize = 8; //Schriftgröße

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit(){

      showText("infoOrdersTotal",88,30,"OrdersTotal: " + IntegerToString( OrdersTotal()), clrWhite );
   
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason){
   ObjectsDeleteAll(0,"infoOrdersTotal");
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]){
 
   
   showText("infoOrdersTotal",88,30,"OrdersTotal: " + IntegerToString( OrdersTotal()), clrWhite );
 
   return(rates_total);
}



bool showText(string objName, int x, int y,string text, color inputFarbe ){
   ResetLastError(); 
   if(ObjectFind(0,objName) > -1){
      ObjectSetString(0,objName,OBJPROP_TEXT,text);   
   }else{
      if(!ObjectCreate(0,objName,OBJ_LABEL,0,0,0)){ 
         Print(__FUNCTION__, ": failed to create text label! Error code = ",GetLastError()); 
         return false; 
      } 
      ObjectSetInteger(0,objName,OBJPROP_XDISTANCE,x); 
      ObjectSetInteger(0,objName,OBJPROP_YDISTANCE,y); 
      ObjectSetInteger(0,objName,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
      ObjectSetString (0,objName,OBJPROP_TEXT,text); 
      ObjectSetInteger(0,objName,OBJPROP_FONTSIZE,FontSize); 
      ObjectSetDouble (0,objName,OBJPROP_ANGLE,0); 
      ObjectSetInteger(0,objName,OBJPROP_ANCHOR,ANCHOR_LEFT); 
      ObjectSetInteger(0,objName,OBJPROP_COLOR,inputFarbe); 
      ObjectSetInteger(0,objName,OBJPROP_BACK,false); 
      ObjectSetInteger(0,objName,OBJPROP_SELECTABLE,false); 
      ObjectSetInteger(0,objName,OBJPROP_SELECTED,false); 
      ObjectSetInteger(0,objName,OBJPROP_HIDDEN,true); 
   }
   return true; 
} 

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
