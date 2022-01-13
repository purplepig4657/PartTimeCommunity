class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SnackBar',
      theme: ThemeData(primaryColor: Colors.white),
      home: SnackBarPractice(),
    );
  }
}

class SnackBarPractice extends StatefulWidget {
  @override
  _SnackBarPracticeState createState() => _SnackBarPracticeState();
}

class _SnackBarPracticeState extends State<SnackBarPractice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
              width: 130,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),primary: Color(0xffFF6280), // background// foreground
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 10.0,),
                      Text('동네 찾기'),
                    ],
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('동네 찾기 성공!',
                        textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }),
            )));
  }
}