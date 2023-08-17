import 'package:flutter/material.dart';
import 'package:soru_uygulamasi/tumSorular.dart';

import 'constants.dart';

void main() => runApp(BilgiTesti());

class BilgiTesti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.indigo[700],
            body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: SoruSayfasi(),
                ))));
  }
}

class SoruSayfasi extends StatefulWidget {
  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}

class _SoruSayfasiState extends State<SoruSayfasi> {
  
  int dogruSayisi=0;
  int yanlisSayisi=0;

  List<Widget> secimler= [];

  tumSorular test_1=tumSorular();

  void butonFonksiyonu(bool secilenButon){

    if(test_1.testBittiMi()==true){

      showDialog(context: context, builder:(BuildContext context){
        return AlertDialog(
          title: new Text("Test Bitti!!"),
          content: new Text("Doğru: $dogruSayisi - Yanlış: $yanlisSayisi"),
          actions: <Widget>[
            new ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  setState(() {
                    test_1.testiSifirla();
                    secimler=[];
                  });
                },
                child: new Text("Yeniden Oyna"))
          ],
        );
      },
      );
    }else{
      setState(() {
        test_1.getSoruYaniti()==secilenButon
            ?secimler.add(kDogruIcon)
            :secimler.add(kYanlisIcon);
        
        test_1.getSoruYaniti()==secilenButon
            ?dogruSayisi++
            :yanlisSayisi++;

        test_1.sonrakiSoru();

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                test_1.getSoruMetni(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Wrap(
          runSpacing: 5,
          spacing: 5,
          children: secimler,
        ),
        Expanded(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Row(children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400],
                        textStyle: TextStyle(color: Colors.white),
                        padding:EdgeInsets.all(12)),
                          child: Icon(
                            Icons.thumb_down,
                            size: 30.0,
                          ),
                          onPressed: () {

                          butonFonksiyonu(false);

                          },
                        ))),
                Row(),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400],
                            textStyle: TextStyle(color: Colors.white),
                            padding: EdgeInsets.all(12)),
                          child: Icon(Icons.thumb_up, size: 30.0),

                          onPressed: () {

                          butonFonksiyonu(true);
                          
                          

                          },
                        ))),
              ])),
        )
      ],
    );
  }
}


