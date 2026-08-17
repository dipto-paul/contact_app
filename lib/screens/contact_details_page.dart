import 'package:flutter/material.dart';

import '../database/contact_database.dart';
import '../model/contact.dart';
import 'edit_contact_page.dart';

class ContactDetailsPage extends StatefulWidget {
  final Contact contact;

  const ContactDetailsPage({
    super.key,
    required this.contact,
  });

  @override
  State<ContactDetailsPage> createState() =>
      _ContactDetailsPageState();
}

class _ContactDetailsPageState
    extends State<ContactDetailsPage> {



  late Contact contact;



  @override
  void initState() {
    super.initState();

    contact = widget.contact;
  }




  String getInitials(String name) {

    final words = name
        .trim()
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.isEmpty) {
      return '?';
    }

    if (words.length == 1) {
      return words[0][0].toUpperCase();
    }

    return '${words[0][0]}${words[1][0]}'
        .toUpperCase();
  }


  Future<void> editContact() async {

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditContactPage(
          contact: contact,
        ),
      ),
    );

    // If contact was updated
    if (result == true) {

      final contacts =
      await ContactDatabase.getContacts();

      Contact? updatedContact;

      for (final item in contacts) {

        if (item.id == contact.id) {
          updatedContact = item;
          break;
        }
      }

      if (updatedContact != null && mounted) {

        setState(() {
          contact = updatedContact!;
        });
      }
    }
  }


  Future<void> deleteContact() async {

    await ContactDatabase.deleteContact(
      contact.id!,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Contact deleted successfully',
        ),
      ),
    );

    // Return true to Home Page
    Navigator.pop(context, true);
  }


  void showDeleteDialog() {

    showDialog(
      context: context,

      builder: (dialogContext) {

        return Dialog(

          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(12),
          ),

          child: Padding(

            padding: const EdgeInsets.fromLTRB(
              20,
              22,
              20,
              14,
            ),

            child: Column(

              mainAxisSize:
              MainAxisSize.min,

              children: [


                Container(

                  height: 48,

                  width: 48,

                  decoration:
                  const BoxDecoration(

                    shape: BoxShape.circle,

                    color: Color(0xFFFFE5E5),
                  ),

                  child: const Icon(

                    Icons.delete,

                    color: Colors.red,

                    size: 25,
                  ),
                ),


                const SizedBox(height: 15),


                const Text(

                  'Delete Contact',

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),


                const SizedBox(height: 10),


                Text(

                  'Are you sure you want to delete\n'
                      '${contact.name}?',

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),


                const SizedBox(height: 18),



                Row(

                  children: [

                    // CANCEL
                    Expanded(

                      child: OutlinedButton(

                        onPressed: () {

                          Navigator.pop(
                            dialogContext,
                          );
                        },

                        style:
                        OutlinedButton.styleFrom(

                          foregroundColor:
                          Colors.black87,

                          side: BorderSide(
                            color:
                            Colors.grey.shade300,
                          ),

                          minimumSize:
                          const Size(
                            0,
                            40,
                          ),

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(8),
                          ),
                        ),

                        child: const Text(
                          'Cancel',
                        ),
                      ),
                    ),


                    const SizedBox(width: 10),


                    // DELETE
                    Expanded(

                      child: ElevatedButton(

                        onPressed: () {

                          Navigator.pop(
                            dialogContext,
                          );

                          deleteContact();
                        },

                        style:
                        ElevatedButton.styleFrom(

                          backgroundColor:
                          Colors.red,

                          foregroundColor:
                          Colors.white,

                          elevation: 0,

                          minimumSize:
                          const Size(
                            0,
                            40,
                          ),

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(8),
                          ),
                        ),

                        child: const Text(
                          'Delete',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  Widget detailRow({

    required IconData icon,

    required String value,

    required String label,

  }) {

    return Padding(

      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 13,
      ),

      child: Row(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [


          Icon(

            icon,

            size: 21,

            color: Colors.grey.shade700,
          ),


          const SizedBox(width: 16),


          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(

                  value,

                  style: const TextStyle(

                    fontSize: 12,

                    fontWeight:
                    FontWeight.w600,

                    color:
                    Colors.black87,
                  ),
                ),

                const SizedBox(height: 4),

                Text(

                  label,

                  style: TextStyle(

                    fontSize: 10,

                    color:
                    Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(


      appBar: AppBar(

        backgroundColor:
        const Color(0xFF5146D8),

        foregroundColor:
        Colors.white,

        elevation: 0,

        toolbarHeight: 62,



        leading: IconButton(

          onPressed: () {

            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back,
            size: 22,
          ),
        ),



        title: const Text(

          'Contact Details',

          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),


        actions: [

          // EDIT
          IconButton(

            onPressed: editContact,

            icon: const Icon(
              Icons.edit,
              size: 20,
            ),
          ),


          // DELETE
          IconButton(

            onPressed:
            showDeleteDialog,

            icon: const Icon(
              Icons.delete_outline,
              size: 21,
            ),
          ),
        ],
      ),



      body: SafeArea(

        child: Column(

          children: [

            const SizedBox(height: 28),



            Container(

              height: 62,

              width: 62,

              decoration:
              const BoxDecoration(

                shape: BoxShape.circle,

                color: Color(0xFF673AB7),
              ),

              child: Center(

                child: Text(

                  getInitials(
                    contact.name,
                  ),

                  style: const TextStyle(

                    color: Colors.white,

                    fontSize: 20,

                    fontWeight:
                    FontWeight.w500,
                  ),
                ),
              ),
            ),


            const SizedBox(height: 12),



            Text(

              contact.name,

              style: const TextStyle(

                fontSize: 15,

                fontWeight:
                FontWeight.w600,

                color: Colors.black87,
              ),
            ),


            const SizedBox(height: 25),


            Container(

              margin: const EdgeInsets.symmetric(
                horizontal: 14,
              ),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(10),

                border: Border.all(
                  color:
                  const Color(0xFFE5E5E5),
                ),
              ),

              child: Column(

                children: [

                  // PHONE
                  detailRow(

                    icon:
                    Icons.phone,

                    value:
                    contact.phone,

                    label:
                    'Mobile',
                  ),


                  // DIVIDER
                  Divider(

                    height: 1,

                    indent: 14,

                    endIndent: 14,

                    color:
                    Colors.grey.shade200,
                  ),


                  // EMAIL
                  detailRow(

                    icon:
                    Icons.email,

                    value:
                    contact.email,

                    label:
                    'Email',
                  ),


                  // DIVIDER
                  Divider(

                    height: 1,

                    indent: 14,

                    endIndent: 14,

                    color:
                    Colors.grey.shade200,
                  ),


                  // ADDRESS
                  detailRow(

                    icon:
                    Icons.location_on,

                    value:
                    contact.address,

                    label:
                    'Address',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}