import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_map_project/screens/home_page.dart';



void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(      
      debugShowCheckedModeBanner: false,
      home: SplashScreen()   
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

    @override
    void initState() {
      super.initState();
      Future.delayed(const Duration(seconds: 5)).then((value) => 
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => 
      const HomePage())));    
}
    
      @override
      Widget build(BuildContext context) {
        return  Scaffold(          
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Center(
                child: SizedBox(
                height: 200,
                width: 200,              
                child: Image.asset("lib/assets/images/earth-grid.png", fit: BoxFit.contain,)
                          ),
              ),
            const Text("Easy-routes", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700))

              ]           
          )          
        );    
      }
    }