(* ::Package:: *)

Clear[InfluxDB`ImportInfluxDB];
InfluxDB`ImportInfluxDB[filename_String,options___]:=Module[
{serverName,serverPort,userName,userPwd,databaseName,url,reps,raw},
reps={"ServerName","ServerPort","UserName","Password","DatabaseName"};
reps=reps/.List[options];
reps=reps/.{"ServerName"->"localhost","ServerPort"->8086,"UserName"->"root","Password"->"root","DatabaseName"->"test"};
url="http://"<>reps[[1]]<>":"<>ToString[reps[[2]]]<>"/db/"<>reps[[5]]<>"/series?u="<>URLEncode[reps[[3]]]<>"&p="<>URLEncode[reps[[4]]]<>"&q="<>URLEncode[Import[filename]];
raw=Import[url,"JSON"];
TimeSeries[{#[[1]]/1000.+AbsoluteTime[{1969,12,31,16,0,0}],#[[3]]}&/@(First@raw)[[2,2]]]
];
ImportExport`RegisterImport["InfluxDB",InfluxDB`ImportInfluxDB]
