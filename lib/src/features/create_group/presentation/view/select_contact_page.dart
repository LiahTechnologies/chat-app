import 'package:flutter/material.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart'; 
import '../../../../core/model/chatmodel.dart';
import '../../../../core/utils/avtar_card.dart';
import '../../../../core/utils/contact_card.dart';
import 'create_group.dart';

class SelectContactPage extends StatefulWidget {
  const SelectContactPage({super.key, required this.isCreatGroup});
  final bool isCreatGroup;

  @override
  State<SelectContactPage> createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<SelectContactPage> {
 late List<Contact> deviceContact;
 bool showContact=false;

@override
  void initState() {
    super.initState();
       
    _askPermissions();
     
   
  }


 Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      
        getDeviceContact();
        
      
    } else {
      _handleInvalidPermissions(permissionStatus);
       
    }  
 
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }



  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


getDeviceContact() async{
 Iterable<Contact> contact = await ContactsService.getContacts(); 
 setState(() {
   deviceContact=contact.toList();
   showContact=true;
 });
}

  List<Contact> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackArrow(),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              "New Group",
              style:Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white) ),
            
            Text(
              "Add participants",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 26,
                color: Colors.white,
              )),
        ],
      ),
      body:showContact? Stack(
        children: [
          ListView.builder(
              itemCount: deviceContact.length,
              itemBuilder: (context, index) {
                if (index == 0)
                  return Container(
                    height: groups.length > 0 ? 90 : 10,
                  );
                return InkWell(
                    onTap: () {
                      if (!groups.contains(deviceContact[index])) {
                        setState(() {
                          // contacts[index].isSelected = true;
                          groups.add(deviceContact[index]);
                        });
                      } else {
                        setState(() {
                          groups.remove(deviceContact[index]);
                         
                        });
                      }


                    },
                    child: ContactCard(
                      contact: deviceContact[index],
                      group: groups,
                    ));
              }),
          if (groups.length > 0)
            Column(
              children: [
                Container(
                  height: 75,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: deviceContact.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (groups.contains(deviceContact[index]))
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  
                                  groups.remove(deviceContact[index]);
                                });
                              },
                              child: AvtarCard(contact: deviceContact[index]));
                        else
                          return Container();
                      }),
                ),
                Divider(
                  thickness: 0.5,
                )
              ],
            )
        ],
      )
      :const Center(child:Text("Loading...") ),

      
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: AppColor.lightButtonColor,
        onPressed: () {

          if(widget.isCreatGroup){
                    if(groups.length>2)
                    nextScreen(context, CreateGroup(members: groups,));
                    else {
                      final snackBar =
              SnackBar(content: Text("Members can't less than 2"),backgroundColor: Colors.red,);
             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

          }


          if(!widget.isCreatGroup){

          }
        },
        child: widget.isCreatGroup? Text("Next",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white),):Text("Add",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white),),
      ),
    );
  }
}
