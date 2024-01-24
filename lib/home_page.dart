import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:voice_assistant/features.dart';
import 'package:voice_assistant/pallete.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistant/services/openAI.dart';

class HomePage extends StatefulWidget {
const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final speechToText = SpeechToText();
String lastWords = '' ;
 final OpenAIService openAIService= OpenAIService();


  @override

void initState() {
    
    super.initState();
    initSpeechToText();
    
  }


  Future<void>  initSpeechToText() async{

      await speechToText.initialize();
      setState(() {});

  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }


  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }


@override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }



  @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('ALEXA'),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
      
      
          children: [
      
            //virtual assistant pic
            Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                        color: Pallete.assistantCircleColor,
                        shape: BoxShape.circle,
                  
                      ),
                    ),
                  ),
                
                Container(
                height: 123,
                decoration:const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/images/virtualAssistant.png'))
                ),
                ),
                
                ],
            ),
      
      
                Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
               margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                top: 30,
               ),
               decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor,
               ),
               borderRadius: BorderRadius.circular(20).copyWith(
                topLeft: Radius.zero,
               ),
               ),
              
               child: const Text('Good Morning, what task can I do for you?', style: 
               TextStyle(
                color: Pallete.mainFontColor,
                fontSize: 21,
                fontFamily: 'Cera Pro',
               ),),
                ),
      
      
      Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(left: 22),
        alignment: Alignment.centerLeft,
        child:  const Text('Here are a few commands',
        style: TextStyle(
          color: Pallete.mainFontColor,
          fontFamily: 'Cera Pro',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ) ,),
      ),
      
      const Column(
        children: [
          FeatureBox(
        color: Pallete.firstSuggestionBoxColor,
        headerText: 'ChatGPT',
        descriptionText: 'A smarter way to stay organized and informed with ChatGPT',
          ),
           FeatureBox(
        color: Pallete.secondSuggestionBoxColor,
        headerText: 'Dall-E',
        descriptionText: 'Get inspired and stay creative with your perrsonal assistant powered by Dall-E',
          ),
      
          FeatureBox(
        color: Pallete.thirdSuggestionBoxColor,
        headerText: 'Smart Voice Assistant',
        descriptionText: 'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
          ),
      
        ],
      ),
      
      
      
          ]),
      ),



        floatingActionButton: FloatingActionButton(
          
          onPressed: () async{

              if(await speechToText.hasPermission && speechToText.isNotListening)
              {
                await startListening();

              }

              else if(speechToText.isListening)
              {
                await openAIService.isArtPromptAPI(lastWords);
                await  stopListening();
              }

              else{
                initSpeechToText();
              }


          },
          
          backgroundColor: Pallete.firstSuggestionBoxColor,
          child: const Icon(Icons.mic,),
        
        
        ),
        
    );
  }
} 