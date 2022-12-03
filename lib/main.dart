import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

import 'app_init.dart';

void main()async {
  await appInit();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  MethodChannel channel = MethodChannel('kommunicate_flutter');
  // This widget is the root of your application.
  @override
  void initState() {
    channel.setMethodCallHandler((call)async{
      if(call.method == 'onPluginLaunch'){
        print("OnPluginLaunch");
        print(call.arguments);
      } else if(call.method == 'onPluginDismiss'){
        print("onPluginDismiss");
        print(call.arguments);
      } else if(call.method == 'onConversationResolved'){
        print("onConversationResolved");
        print(call.arguments);
      } else if(call.method == 'onConversationRestarted'){
        print("onConversationRestarted");
        print(call.arguments);
      } else if(call.method == 'onRichMessageButtonClick'){
        print("onRichMessageButtonClick");
        print(call.arguments);
      } else if(call.method == 'onStartNewConversation'){
        print("onStartNewConversation");
        print(call.arguments);
      } else if(call.method == 'onSubmitRatingClick'){
        print("onSubmitRatingClick");
        print(call.arguments);
      } else if(call.method == 'onMessageReceived'){
        print("onMessageReceived");
        print(call.arguments);
      } else if(call.method == 'onBackButtonClicked'){
        print("onBackButtonClicked");
        print(call.arguments);
      } else if(call.method == 'onMessageSent'){
        print("onMessageSent");
        print(call.arguments);
      }
      else if(call.method == 'onAttachmentClick'){
        print("onAttachmentClick");
        print(call.arguments);
      }
      else if(call.method == 'OnFaqClick'){
        print("OnFaqClick");
        print(call.arguments);
      }
      else if(call.method == 'onLocationClick'){
        print("onLocationClick");
        print(call.arguments);
      }
      else if(call.method == 'onNotificationClick'){
        print("onNotificationClick");
        print(call.arguments);
      }
      else if(call.method == 'onVoiceButtonClick'){
        print("onVoiceButtonClick");
        print(call.arguments);
      }
      else if(call.method == 'onRatingEmoticonsClick'){
        print("onRatingEmoticonsClick");
        print(call.arguments);
      }
      else if(call.method == 'onRateConversationClick'){
        print("onRateConversationClick");
        print(call.arguments);
      }

      return null;
    });    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Push Notifications',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{

            try {
              dynamic conversationObject = {
                'appId': '1399b0b2d35860300bda59a27f7c6b4a7' // The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
              };
              dynamic result = await KommunicateFlutterPlugin.buildConversation(conversationObject);
              print("Conversation builder success : " + result.toString());
            } on Exception catch (e) {
              print("Conversation builder error occurred : " + e.toString());
            }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
