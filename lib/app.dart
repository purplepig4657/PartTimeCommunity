import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screen_body.dart';
import 'bottom_appbar.dart';
import 'appbar.dart';
import 'pages/authentication.dart';
import 'pages/free_board.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PartTimeCommunity',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<ApplicationState>(
          builder: (context, appState, _) => BackNotifier(
            startPrevious: appState.startPrevious,
            bodyState: appState.bodyState,
          ),
        ),
        title: Consumer<ApplicationState>(
          builder: (context, appState, _) => TitleNotifier(
            bodyState: appState.bodyState,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) =>
                appState.bodyState == ApplicationBodyState.logout
                    ? Authentication(
                        email: appState.email,
                        loginState: appState.loginState,
                        startLoginFlow: appState.startLoginFlow,
                        verifyEmail: appState.verifyEmail,
                        signInWithEmailAndPassword:
                            appState.signInWithEmailAndPassword,
                        cancelRegistration: appState.cancelRegistration,
                        registerAccount: appState.registerAccount,
                        signOut: appState.signOut,
                      )
                    : ScreenBody(
                        email: appState.email,
                        bodyState: appState.bodyState,
                        freeBoardContent: appState.freeBoardContent,
                        startLoginFlow: appState.startLoginFlow,
                        startHome: appState.startHome,
                        startBoard: appState.startBoard,
                        startWriteContent: appState.startWriteContent,
                        startReadContent: appState.startReadContent,
                        selectContent: appState.selectContent,
                        selectedContent: appState.selectedContent,
                        //addContentToFreeBoard: appState.addContentToFreeBoard,
                        startPrevious: appState.startPrevious,
                        startMessage: appState.startMessage,
                        startTimetable: appState.startTimetable,
                        startPersonal: appState.startPersonal,
                        startMap: appState.startMap,
                        startReview: appState.startReview,
                        reviewContent: appState.reviewContent,
                        startWriteReview: appState.startWriteReview,
                        signOut: appState.signOut,
                ),
          ),
        ],
      ),
      bottomNavigationBar: Consumer<ApplicationState>(
        builder: (context, appState, _) => BottomBarNotifier(
            bodyState: appState.bodyState,
            startHome: appState.startHome,
            startBoard: appState.startBoard,
            startMessage: appState.startMessage,
            startTimetable: appState.startTimetable,
            startPersonal: appState.startPersonal,
            startMap: appState.startMap),
      ),
      floatingActionButton: Consumer<ApplicationState>(
        builder: (context, appState, _) => FloatingButtonNotifier(
            bodyState: appState.bodyState,
            previousState: appState.previousState,
            startPrevious: appState.startPrevious,
            startMap: appState.startMap),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    _freeBoardSubscription = FirebaseFirestore.instance
        .collection('freeboard')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      _freeBoardContent = [];
      for (final document in snapshot.docs) {
        _freeBoardContent.add(
          BoardContent(
            title: document.data()['title'] as String,
            content: document.data()['content'] as String,
            name: document.data()['name'] as String,
            userId: document.data()['userId'] as String,
          ),
        );
      }
      notifyListeners();
    });

    _reviewSubscription = FirebaseFirestore.instance
        .collection('review')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      _reviewContent = [];
      for (final document in snapshot.docs) {
        _reviewContent.add(
          ReviewContent(
            content: document.data()['content'] as String,
            date: document.data()['timestamp'] as int,
            name: document.data()['name'] as String,
            userId: document.data()['userId'] as String,
          ),
        );
      }
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        _bodyState = ApplicationBodyState.home;
      } else {
        _loginState = ApplicationLoginState.emailAddress;
        _bodyState = ApplicationBodyState.logout;
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.emailAddress;
  ApplicationLoginState get loginState => _loginState;

  ApplicationBodyState _bodyState = ApplicationBodyState.logout;
  ApplicationBodyState get bodyState => _bodyState;

  ApplicationBodyState _previousState = ApplicationBodyState.home;
  ApplicationBodyState get previousState => _previousState;

  StreamSubscription<QuerySnapshot>? _freeBoardSubscription;
  List<BoardContent> _freeBoardContent = [];
  List<BoardContent> get freeBoardContent => _freeBoardContent;
  BoardContent selectedContent =
      BoardContent(title: 'default', content: 'default', name: 'default', userId: 'default');

  StreamSubscription<QuerySnapshot>? _reviewSubscription;
  List<ReviewContent> _reviewContent = [];
  List<ReviewContent> get reviewContent => _reviewContent;
  ReviewContent selectedReviewContent =
  ReviewContent(content: 'default', date: 0, name: 'default', userId: 'default');

  String? _email;
  String? get email => _email;

  var previous = [];

  void savePreviousState() {
    previous.add(_bodyState);
  }

  void startPrevious() {
    if (!previous.isEmpty && _bodyState != ApplicationBodyState.logout) {
      ApplicationBodyState pre = previous[previous.length - 1];
      previous.removeAt(previous.length - 1);
      _bodyState = pre;
      notifyListeners();
    }
  }

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> registerAccount(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void startHome() {
    print("Home");
    savePreviousState();
    _bodyState = ApplicationBodyState.home;
    notifyListeners();
  }

  void startBoard(page) {
    if (page == 1) {
      print("FreeBoard");
      savePreviousState();
      _bodyState = ApplicationBodyState.free_board;
      notifyListeners();
    }
  }

  void startMessage() {
    print("Message");
    savePreviousState();
    _bodyState = ApplicationBodyState.message;
    notifyListeners();
  }

  void startTimetable() {
    print("Timetable");
    savePreviousState();
    _bodyState = ApplicationBodyState.timetable;
    notifyListeners();
  }

  void startPersonal() {
    print("Personal");
    savePreviousState();
    _bodyState = ApplicationBodyState.personal;
    notifyListeners();
  }

  void startWriteContent() {
    savePreviousState();
    _bodyState = ApplicationBodyState.write_content;
    notifyListeners();
  }

  void startReadContent() {
    savePreviousState();
    _bodyState = ApplicationBodyState.read_content;
    notifyListeners();
  }

  void selectContent(BoardContent content) {
    selectedContent = content;
  }

  void startMap() {
    print("Map");
    savePreviousState();
    _bodyState = ApplicationBodyState.map;
    notifyListeners();
  }

  void startReview() {
    print("Review");
    savePreviousState();
    _bodyState = ApplicationBodyState.review;
    notifyListeners();
  }

  void startWriteReview() {
    print("WriteReview");
    savePreviousState();
    _bodyState = ApplicationBodyState.write_review;
    notifyListeners();
  }
}

class BoardContent {
  BoardContent({required this.title, required this.content,
    required this.name, required this.userId});
  final String title;
  final String content;
  final String name;
  final String userId;
}

class ReviewContent {
  ReviewContent({required this.content, required this.date,
    required this.name, required this.userId});
  final String content;
  final int date;
  final String name;
  final String userId;
}
