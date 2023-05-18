import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart' as AppColors;
import 'audio_file.dart';

class DetailAudioPage extends StatefulWidget {
  final booksData;
  final int index;

  final String audioPath;
  const DetailAudioPage({Key? key, this.booksData, required this.index, required this.audioPath}) : super(key: key);

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer advancedPlayer;
  @override
  void initState(){
    super.initState();
    advancedPlayer=AudioPlayer();
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight=MediaQuery.of(context).size.height;
    final double screenWidth=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: screenHeight/3,
                child: Container(
                color: AppColors.audioBlueBackground,
            )),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    advancedPlayer.stop();
                    },
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search,),
                      onPressed: (){},
                    ),
                  ],
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
            )),
            Positioned(
                top: screenHeight*0.2,
                left: 0,
                right: 0,
                height:screenHeight*0.36 ,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight*0.13,),
                       Text(this.widget.booksData[this.widget.index]["title"],
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir"
                      ),
                      ),
                      Text(this.widget.booksData[this.widget.index]["text"], style: TextStyle(
                        fontSize: 20,
                      ),),
                      AudioFile(advancedPlayer:advancedPlayer, audioPath:this.widget.booksData[this.widget.index]["audio"]),
                    ],
                  ),
                  )
                  ),
            Positioned(
                top: screenHeight*0.12,
                left: (screenWidth-150)/2,
                right:(screenWidth-150)/2,
                height: screenHeight*0.19,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.audioGreyBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5),
                        image:  DecorationImage(
                          image: AssetImage(this.widget.booksData[this.widget.index]["img"]),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  ),
            )
            ),




          ],
      ),
    );
  }
}
