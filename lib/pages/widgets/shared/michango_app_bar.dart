import 'package:flutter/material.dart';
import 'package:michango/models/event.dart';
import 'package:michango/services/event_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MichangoAppBar extends StatelessWidget implements PreferredSizeWidget {
  //Future final <List<Event>> _events;
  //_events=EventService().getEvents();

  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: EventsDropDownButton()),
    );
  }
}

class EventsDropDownButton extends StatefulWidget {
  //const EventsDropDownButton({ Key? key }) : super(key: key);

  @override
  _EventsDropDownButtonState createState() => _EventsDropDownButtonState();
}

class _EventsDropDownButtonState extends State<EventsDropDownButton> {
  //Future <List<Event>> _events;
  String dropdownValue;
  Future<List<Event>> _events;
  String _currentEvent = '';
  String _selected = '';

  @override
  void initState() {
    super.initState();
    _events = EventService().getEvents();
    _getCurrentEvent();
  }

/*   @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _events,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dropdownValue =
                snapshot.data.length > 0 ? snapshot.data[0].id : 'No Event';
            _setCurrentEvent(snapshot.data[0].id);

            return Container(
              child: Theme(
                data: Theme.of(context).copyWith(canvasColor: Colors.cyan[600]),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w200,
                      fontFamily: 'Encode Sans'),
                  /*    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ), */
                  onChanged: (String newValue) {
                    showModal(context);
                    /*  setState(() {
                      dropdownValue = newValue;
                      _setCurrentEvent(newValue);
                    }); */
                  },
                  items: snapshot.data
                      .map<DropdownMenuItem<String>>((Event event) {
                    return DropdownMenuItem<String>(
                      value: event.id,
                      child: Text(event.name),
                    );
                  }).toList(),
                ),
              ),
            );
          } else {
            return SizedBox(child: new CircularProgressIndicator());
          }
        });
  } */

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: Text('Selected item: $_selected'),
            onPressed: () => showModal(context),
          ),
          /*  Text('Selected item: $_selected') */
        ],
      ),
    );
  }

  void _setCurrentEvent(id, name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _selected = _currentEvent;
    });

    prefs.setString('currentEventId', id);
    prefs.setString('currentEventName', name);
  }

  void _getCurrentEvent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentEvent = prefs.getString('currentEventName');

    setState(() {
      _selected = _currentEvent;
    });
    
    print(_currentEvent);
  }

  void showModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return FutureBuilder(
              future: _events,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _currentEvent = snapshot.data.length > 0
                      ? snapshot.data[0].name
                      : 'No Event';
                  _setCurrentEvent(snapshot.data[0].id, snapshot.data[0].name);

                  return Container(
                    padding: EdgeInsets.all(8),
                    height: 200,
                    alignment: Alignment.center,
                    child: ListView.separated(
                        itemCount: snapshot.data.length,
                        separatorBuilder: (context, int) {
                          return Divider();
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              child: Text(snapshot.data[index].name),
                              onTap: () {
                                setState(() {
                                  _currentEvent = snapshot.data[index].name;
                                });
                                _setCurrentEvent(snapshot.data[index].id,
                                    snapshot.data[index].name);
                                Navigator.of(context).pop();
                              });
                        }),
                  );
                } else {
                  return SizedBox(child: new CircularProgressIndicator());
                }
              });
        });
  }
}
