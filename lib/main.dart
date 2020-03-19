import 'package:flutter/material.dart';

void main(){
  runApp(App());
}
const String _name = "Your Name";
class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FriendlyChat",
      home: ChatScreen(),
    );
  }
}
//ChatScreen Widget
class ChatScreen extends StatefulWidget{
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen>{
  final chatlist = <ChatMessage>[];
  @override
  final TextEditingController _textController = new TextEditingController();
  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text('FriendlyChat'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: new EdgeInsets.all(8.0),                     //new
              reverse: true,                                        //new
              itemBuilder: (_, int index) => chatlist[index],      //new
              itemCount: chatlist.length,
            )
          ),
          new Divider(height: 1.0),                                 //new
          new Container(                                            //new
            decoration: new BoxDecoration(
                color: Theme.of(context).cardColor),                  //new
            child: _buildTextComposer(),                       //modified
          ),
        ],
      ),
    );
  }
  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(
                  hintText: "Send a message"),
            ),
          ),
          Container(                                                 //new
            margin: EdgeInsets.symmetric(horizontal: 4.0),           //new
            child: IconButton(                                       //new
                icon: Icon(
                    Icons.send,
                  color: Colors.blue[600],),                                //new
                onPressed: () => _handleSubmitted(_textController.text)),  //new
          ),                                                             //new
        ],
      ),
    );
  }
  void _handleSubmitted(String text) {
    var mssg = new ChatMessage(text);
    _textController.clear();
    setState(() {
      chatlist.insert(0, mssg);
    });
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(child: new Text(_name[0])),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_name, style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}