class BoardPage extends StatelessWidget {
  BoardPage({Key? key}) : super(key: key);

  final List<String> list = List.generate(30, (index) => "Item $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      floatingActionButton: FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30.0,
            ),
            Icon(
              Icons.calendar_today_rounded,
              color: Colors.black,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              '글 작성',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_box_outlined),
            color: Colors.black,
            iconSize: 30,
          )
        ],
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: FractionallySizedBox(
            widthFactor: 0.8,
            heightFactor: 0.95,
            child: Column(
              children: <Widget>[
                Expanded(
                  //flex: 9,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(
                          width: 1,
                          color: Colors.black54,
                        )),
                    child: _buildBoard(),
                  ),
                ),
                //Expanded(child: SizedBox(), flex: 1,)
              ],
            )),
      ),
    );
  }

  Widget _buildBoard() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 30,
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        return _buildRow(i ~/ 2);
      },
    );
  }

  Widget _buildRow(int i) {
    return ListTile(
      title: Text(list[i]),
      trailing: Icon(Icons.menu),
      onTap: () {
        print('Tab $i');
      },
    );
  }
}
