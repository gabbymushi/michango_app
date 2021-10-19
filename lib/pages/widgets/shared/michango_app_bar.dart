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
  String _selected = 'Loading...';

  @override
  void initState() {
    super.initState();
    _events = EventService().getEvents();
    print(_events);
    _getCurrentEvent(_events);
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
          TextButton(
            child: Row(
              children: <Widget>[
                Text(
                  _selected,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Encode Sans',
                    fontWeight: FontWeight.w200,
                    fontSize: 19,
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.white)
              ],
            ),
            onPressed: () => showModal(context),
          ),
        ],
      ),
    );
  }

  void _setCurrentEvent(id, name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _selected = _currentEvent.toUpperCase();
    });

    prefs.setString('currentEventId', id);
    prefs.setString('currentEventName', name);
  }

  void _getCurrentEvent(_events) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentEvent = prefs.getString('currentEventName');
    var _current = await _events;

    if (_currentEvent == null && _current.length > 0) {
      _currentEvent = _current[0].name;
      _setCurrentEvent(_current[0].id, _current[0].name);
    }

    print(_currentEvent);

    setState(() {
      _selected = _currentEvent.toUpperCase() ?? 'Select Event';
    });
  }

  void showModal(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        context: context,
        builder: (context) {
          return FutureBuilder(
              future: _events,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0))),
                    padding: EdgeInsets.all(17),
                    height: 200,
                    alignment: Alignment.center,
                    child: ListView.separated(
                        itemCount: snapshot.data.length,
                        separatorBuilder: (context, int) {
                          return Divider();
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              child: Text(
                                snapshot.data[index].name.toUpperCase(),
                                style: TextStyle(
                                  //color: Colors.white,
                                  fontFamily: 'Encode Sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _currentEvent =
                                      snapshot.data[index].name.toUpperCase();
                                });
                                _setCurrentEvent(snapshot.data[index].id,
                                    snapshot.data[index].name.toUpperCase());
                                Navigator.of(context).pop();
                              });
                        }),
                  );
                } else {
                  //_setCurrentEvent(null, 'No event');
                  return SizedBox(child: new CircularProgressIndicator());
                }
              });
        });
  }
}
