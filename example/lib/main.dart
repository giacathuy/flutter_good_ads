import 'package:flutter/material.dart';
import 'package:flutter_good_ads/flutter_good_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final interstitialAd = const GoodInterstitial(
    adUnitId: 'ca-app-pub-3940256099942544/8691691433',
    adRequest: AdRequest(),
    interval: 60000,
  );

  @override
  void initState() {
    super.initState();
    interstitialAd.load();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      if (_counter % 5 == 0) {
        interstitialAd.show(reloadAfterShow: true);
      }
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
      body: Column(
        children: [
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (index == 5) {
                  return const GoodBannerStandard(
                    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
                    adRequest: AdRequest(),
                    adSize: AdSize.banner,
                  );
                } else if (index == 10) {
                  return const GoodBannerAdaptiveInline(
                    adUnitId: 'ca-app-pub-3940256099942544/9214589741',
                  );
                } else if (index == 15) {
                  return const GoodBannerAdaptiveAnchored(
                    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
                  );
                } else {
                  return ListTile(
                    title: Text(index.toString()),
                  );
                }
              },
              addAutomaticKeepAlives: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
