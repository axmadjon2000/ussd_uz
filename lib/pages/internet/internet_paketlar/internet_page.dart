import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ussd_uz/constants/constant.dart';
import 'package:ussd_uz/models/internet/internet_model.dart';
import 'package:ussd_uz/models/internet/internet_screen_model.dart';
import 'package:ussd_uz/pages/home_screen/home_provider.dart';
import 'package:ussd_uz/pages/internet/internet_paketlar/internet_provider.dart';
import 'package:ussd_uz/pages/internet/widgets_custom/widget_cust.dart';
import 'package:ussd_uz/pages/main_screen/main_provider.dart';
import 'package:ussd_uz/utils/hiveee/hive_dbb.dart';
import 'package:ussd_uz/utils/mixinss.dart';
import 'package:ussd_uz/utils/prefs/shared_pref.dart';

import 'internet_provider.dart';
// ignore: must_be_immutable
class InternetPage extends StatefulWidget {
  static const String id="internet_page";
  late Color col;
  InternetPage({required this.col});
  static Widget screen(Color col)=>ChangeNotifierProvider<InternetProvider>(
    create:(context)=>InternetProvider(),
    child: InternetPage(col: col,),
  );
  @override
  _InternetPageState createState() => _InternetPageState();
}

class _InternetPageState extends State<InternetPage> with AddMessText,InfoShow{
  ComInter? comIn;
  List? month=[],day=[],night=[],tas_ix=[],non_stop=[],talim=[],constr=[];
  void getInfoInternetPack()async{
    comIn=HiveDB.loadInterInfo();
    print(comIn?.list.first.description);
    comIn?.list.forEach((i){
      if(i.operator==2&&i.muddat.split(" ").sorted()[0]=="30"&&i.category==9){
        month?.add(InternetPackages(mb:"${i.hajmi}",about: "To`plam narxi::${i.price}\nBerilgan trafik hajmi::${i.hajmi}\nAmal qilish muddati::${i.muddat}",desc:"${i.description}"));
      }else if(i.operator==2&&i.muddat.split(" ").sorted()[0]=="1"&&i.category==10){
        day?.add(InternetPackages(mb:"${i.hajmi}",about: "To`plam narxi::${i.price}\nBerilgan trafik hajmi::${i.hajmi}\nAmal qilish muddati::${i.muddat}",desc:"${i.description}"));
      }else if(i.operator==2&&i.category==11){
        night?.add(InternetPackages(mb:"${i.hajmi}",about: "To`plam narxi::${i.price}\nBerilgan trafik hajmi::${i.hajmi}\nAmal qilish muddati::${i.muddat}",desc:"${i.description}"));
      }else if(i.operator==2&&i.category==12){
        tas_ix?.add(InternetPackages(mb:"${i.hajmi}",about: "To`plam narxi::${i.price}\nBerilgan trafik hajmi::${i.hajmi}\nAmal qilish muddati::${i.muddat}",desc:"${i.description}"));
      }else if(i.operator==2&&i.category==13){
        non_stop?.add(InternetPackages(mb:"${i.hajmi}",about: "To`plam narxi::${i.price}\nBerilgan trafik hajmi::${i.hajmi}\nAmal qilish muddati::${i.muddat}",desc:"${i.description}"));
      }else if(i.operator==2&&i.category==14){
        constr?.add(InternetPackages(mb:"${i.hajmi}",about: "To`plam narxi::${i.price}\nBerilgan trafik hajmi::${i.hajmi}\nAmal qilish muddati::${i.muddat}",desc:"${i.description}"));
      }
    });
  }
  PageController? controller;
  int currentIndex=0;
  List? lt=[
    "Oylik paketlar",
    "Kunlik paketlar",
    "Tungi internet",
    "TAS-IX uchun paketlar",
    "Internet non-stop",
    "Constructor TR abanentlari uchun internet paketlar",
  ];
  String t='Uzmobile kompaniyasi internet paketlari';
  String content='Info';
  @override
 void initState(){
    super.initState();
    controller=PageController();
    getInfoInternetPack();
  }
  @override
  Widget build(BuildContext context){
    final Size size=MediaQuery.of(context).size;
    final val=Provider.of<InternetProvider>(context);
    return Consumer<InternetProvider>(
      builder: (context,valueInternet,child){
        return Scaffold(
            appBar: AppBar(
              backgroundColor:widget.col,
              elevation:0.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.of(context).pop();
                },
                splashColor: Colors.red,
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: ()=>showInfo(context,t,content),
                  icon: Icon(Icons.info_outline),
                  splashColor: Colors.red,
                ),
              ],
              title:Text('Internet paketlar'),
            ),
            body:SafeArea(
              child: Stack(
                children: [
                  PageView(
                    controller: this.controller,
                    onPageChanged: (index){
                      valueInternet.getEq(index);
                      currentIndex=valueInternet.getIn;
                    },
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:size.width*0.23),
                        height: size.height,
                        width: size.width,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount:month?.length,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder:(context,index)=>GestureDetector(child: myColumnWid(context,package: month![index],color: widget.col),onTap: ()=>showText(context,package: month![index],otherButton: 'Aktivlashtirish' ),),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:size.width*0.23),
                        height: size.height,
                        width: size.width,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount:day?.length,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder:(context,index)=>GestureDetector(child: myColumnWid(context,package: day![index],color: widget.col),onTap: ()=>showText(context,package: day![index],otherButton: 'Aktivlashtirish' ),),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:size.width*0.23),
                        height: size.height,
                        width: size.width,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount:night?.length,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder:(context,index)=>GestureDetector(child: myColumnWid(context,package: night![index],color: widget.col),onTap: ()=>showText(context,package: night![index],otherButton: 'Aktivlashtirish' ),),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:size.width*0.23),
                        height: size.height,
                        width: size.width,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount:tas_ix?.length,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder:(context,index)=>GestureDetector(child: myColumnWid(context,package: tas_ix![index],color:widget.col),onTap: ()=>showText(context,package: tas_ix![index],otherButton: 'Aktivlashtirish' ),),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:size.width*0.23),
                        height: size.height,
                        width: size.width,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount:non_stop?.length,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder:(context,index)=>GestureDetector(child: myColumnWid(context,package: non_stop![index],color: widget.col),onTap: ()=>showText(context,package: non_stop![index],otherButton: 'Aktivlashtirish' ),),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:size.width*0.23),
                        height: size.height,
                        width: size.width,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount:constr?.length,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder:(context,index)=>GestureDetector(child: myColumnWid(context,package: constr![index],color: widget.col),onTap: ()=>showText(context,package: constr![index],otherButton: 'Aktivlashtirish' ),),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: size.width,
                    height: size.height,
                    child:Column(
                      children: [
                        Container(
                          height: size.width*0.1,
                          color: Colors.white,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: lt?.length,
                            itemBuilder:(context,index)=>InkWell(child: _myWidget(context,color:widget.col,isActive:index==valueInternet.getIn?true:false, str:lt![index],),onTap: (){
                              valueInternet.getEq(index);
                              controller?.animateToPage(valueInternet.getIn, duration:Duration(milliseconds: 200), curve:Curves.easeIn);
                            },),
                          ),
                        ),
                        Container(
                          height: size.width*0.12,
                          width: size.width,
                          color: Colors.white,
                          margin: EdgeInsets.only(top:5),
                          padding: EdgeInsets.symmetric(horizontal: size.width*0.2),
                          child:  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: widget.col,
                            ),
                            width: double.infinity,
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: (){},
                              child: Text('Internet Trafikni\nTekshirish',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),),
                            ),
                          ).center(),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
        );
      },
    );
  }
}
Widget _myWidget(context,{required bool isActive,required String str,required Color color}){
  return Consumer<InternetProvider>(
    builder: (context,value,child)=>Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration:BoxDecoration(
          border:Border(
            bottom:isActive?BorderSide(
              width: 3,
              color: color,
            ):BorderSide(width: 3,color: Colors.white),
          )
      ),
      child:Text(str,style: TextStyle(color: color),).center(),
    ),
  );
}
mixin InfoShow{
  void showInfo(BuildContext context,[text,content]){
    showDialog(context: context,
        builder:(context)=>AlertDialog(
         title: Text(content),
         content: Text(text),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              child: Text('orqaga'),
              onPressed: ()=>Navigator.of(context).pop(),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
    );
  }
}
