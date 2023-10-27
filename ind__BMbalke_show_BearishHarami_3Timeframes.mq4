#property copyright "Copyright 2021, Alexander Karl"
#property description "Systematik von Alexander Karl"
#property description "Code von BM Trading GmbH | Projektnr. 10359-1"
#property description "Alles Gute und viel Erfolg im Trading!"
#property description "\nBitte testen Sie das Programm ausgiebig in einem Demokonto. Durch das Versagen von Hardware, Software oder Internetverbindungen können Schäden entstehen. Die BM Trading GmbH kann hierfür keine Haftung übernehmen."
#define VERSION "1.0"
#property version VERSION
#property strict

#property indicator_chart_window

#define PROJECT_NAME MQLInfoString(MQL_PROGRAM_NAME)

#define OBJ_NAME_LABEL1 PROJECT_NAME + "Label1"
#define OBJ_NAME_LABEL2 PROJECT_NAME + "Label2"
#define OBJ_NAME_LABEL3 PROJECT_NAME + "Label3"

input ENUM_TIMEFRAMES Timeframe1 = PERIOD_M5; //Zeiteinheit 1
input ENUM_TIMEFRAMES Timeframe2 = PERIOD_M15; //Zeiteinheit 2
input ENUM_TIMEFRAMES Timeframe3 = PERIOD_H1; //Zeiteinheit 3
input int MaxDeviationPoints = 2; //Max Abweichung Close1/Open0

input color ClrText = clrRed; //Schriftfarbe
input int FontSize = 12; //Schriftgröße

int OnInit(){

   showBearishHarami(Timeframe1,OBJ_NAME_LABEL1,250,20);
   showBearishHarami(Timeframe2,OBJ_NAME_LABEL2,250,40);
   showBearishHarami(Timeframe3,OBJ_NAME_LABEL3,250,60);
   
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason){
   ObjectsDeleteAll(0,PROJECT_NAME);
}

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
   
   showBearishHarami(Timeframe1,OBJ_NAME_LABEL1,250,20);
   showBearishHarami(Timeframe2,OBJ_NAME_LABEL2,250,40);
   showBearishHarami(Timeframe3,OBJ_NAME_LABEL3,250,60);

   return(rates_total);
}

void showBearishHarami(ENUM_TIMEFRAMES tf, string objName, int x, int y){   
   string text = timeframeToString(tf);        
   if(checkBearishHarami(tf)) text = StringConcatenate(text," Bearish Harami");
   else text = StringConcatenate(text," ???");
   showText(objName,x,y,text);
}

bool checkBearishHarami(ENUM_TIMEFRAMES tf){
   double close0 = iClose(_Symbol,tf,0);
   double open0 = iOpen(_Symbol,tf,0);
   double high0 = iHigh(_Symbol,tf,0);

   double high1 = iHigh(_Symbol,tf,1);
   double close1 = iClose(_Symbol,tf,1);

   if(close0 < open0){
      if(high1 > high0){
         if((int)(MathAbs(close1 - open0)*MathPow(10,_Digits)) <= MaxDeviationPoints){
            return true;
         }
      }
   }
   return false;
}

bool showText(string objName, int x, int y,string text){
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
      ObjectSetString(0,objName,OBJPROP_TEXT,text); 
      ObjectSetInteger(0,objName,OBJPROP_FONTSIZE,FontSize); 
      ObjectSetDouble(0,objName,OBJPROP_ANGLE,0); 
      ObjectSetInteger(0,objName,OBJPROP_ANCHOR,ANCHOR_LEFT); 
      ObjectSetInteger(0,objName,OBJPROP_COLOR,ClrText); 
      ObjectSetInteger(0,objName,OBJPROP_BACK,false); 
      ObjectSetInteger(0,objName,OBJPROP_SELECTABLE,false); 
      ObjectSetInteger(0,objName,OBJPROP_SELECTED,false); 
      ObjectSetInteger(0,objName,OBJPROP_HIDDEN,true); 
   }
   return true; 
} 

string timeframeToString(ENUM_TIMEFRAMES tf){
   switch(tf){
      case PERIOD_M1: return "M1";
      case PERIOD_M5: return "M5";
      case PERIOD_M15: return "M15";
      case PERIOD_M30: return "M30";
      case PERIOD_H1: return "H1";
      case PERIOD_H4: return "H4";
      case PERIOD_D1: return "D1";
      case PERIOD_W1: return "W1";
      case PERIOD_MN1: return "MN1";
      default: return "n/a";
   }
}
