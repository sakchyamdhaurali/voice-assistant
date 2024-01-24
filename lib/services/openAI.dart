import 'dart:convert';

import 'package:http/http.dart' as http;

import '../secret_key.dart';



class OpenAIService{

 Future<String> isArtPromptAPI(String prompt) async{
  try{
  final response= await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $openAIAPIKey',
  },
body: jsonEncode({
  'model': 'gpt-3.5-turbo',
    'messages': [
      {
        'role': 'user',
        'content': 'Does this message want to generate image,picture or anything similar? $prompt. Simply answer with yes or no.',
      },
    
    ],

})

  );

print(response.body);
if(response.statusCode==200){
  print('yay');
}
return 'AI';
}

catch(e){
  return e.toString(); 
}
 }

  Future<String> chatGPTAPI(String prompt) async{
    return 'CHATGPT';
  }


  Future<String> dallEAPI(String prompt) async{
return 'DALL-E';  


}


}