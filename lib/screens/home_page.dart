import 'package:flutter/material.dart';

import '../database/contact_database.dart';
import '../model/contact.dart';
import 'add_contact_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // --------------------------------------------------
  // VARIABLES
  // --------------------------------------------------

  List<Contact> contacts = [];

  List<Contact> filteredContacts = [];

  final TextEditingController searchController =
  TextEditingController();

  bool isSearching = false;


  // --------------------------------------------------
  // INIT
  // --------------------------------------------------

  @override
  void initState() {
    super.initState();

    refreshContacts();
  }


  // --------------------------------------------------
  // GET CONTACTS
  // --------------------------------------------------

  Future<void> refreshContacts() async {
    final data = await ContactDatabase.getContacts();

    if (!mounted) return;

    setState(() {
      contacts = data;
      filteredContacts = data;
    });
  }


  // --------------------------------------------------
  // SEARCH
  // --------------------------------------------------

  void searchContacts(String value) {

    final query = value.trim().toLowerCase();

    setState(() {

      if (query.isEmpty) {

        filteredContacts = contacts;

      } else {

        filteredContacts = contacts.where((contact) {

          return contact.name
              .toLowerCase()
              .contains(query);

        }).toList();
      }
    });
  }


  // --------------------------------------------------
  // OPEN ADD CONTACT
  // --------------------------------------------------

  Future<void> openAddContact() async {

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const AddContactPage(),
      ),
    );

    if (result == true) {
      await refreshContacts();
    }
  }


  // --------------------------------------------------
  // AVATAR COLOR
  // --------------------------------------------------

  Color getAvatarColor(int index) {

    final colors = [
      const Color(0xFF673AB7),
      const Color(0xFF29ABE2),
      const Color(0xFF5DB39E),
      const Color(0xFFFF7A18),
      const Color(0xFFEF5DA8),
      const Color(0xFF31AFC1),
    ];

    return colors[index % colors.length];
  }


  // --------------------------------------------------
  // GET INITIALS
  // --------------------------------------------------

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

    return
      '${words[0][0]}${words[1][0]}'
          .toUpperCase();
  }


  // --------------------------------------------------
  // CONTACT ITEM
  // --------------------------------------------------

  Widget contactItem(
      Contact contact,
      int index,
      ) {

    return InkWell(

      onTap: () {
        // Later we will open Contact Details page.
      },

      child: Container(

        height: 70,

        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 7,
        ),

        child: Row(

          children: [

            // ------------------------------------------
            // AVATAR
            // ------------------------------------------

            CircleAvatar(

              radius: 17,

              backgroundColor:
              getAvatarColor(index),

              child: Text(

                getInitials(contact.name),

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(width: 11),


            // ------------------------------------------
            // CONTACT INFORMATION
            // ------------------------------------------

            Expanded(

              child: Column(

                mainAxisAlignment:
                MainAxisAlignment.center,

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  // NAME
                  Text(

                    contact.name,

                    maxLines: 1,

                    overflow:
                    TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 2),


                  // EMAIL
                  if (contact.email.isNotEmpty)

                    Text(

                      contact.email,

                      maxLines: 1,

                      overflow:
                      TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey.shade600,
                      ),
                    ),


                  // PHONE
                  Text(

                    contact.phone,

                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),


            // ------------------------------------------
            // ARROW
            // ------------------------------------------

            const Icon(

              Icons.chevron_right,

              size: 20,

              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }


  // --------------------------------------------------
  // EMPTY STATE
  // --------------------------------------------------

  Widget emptyState() {

    return Center(

      child: Column(

        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          Icon(
            Icons.contacts_outlined,
            size: 75,
            color: const Color(0xFFDCD8FF),
          ),

          const SizedBox(height: 18),

          const Text(

            'No contacts yet',

            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 7),

          Text(

            'Add your first contact by tapping\nthe + button below.',

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }


  // --------------------------------------------------
  // SEARCH BAR
  // --------------------------------------------------

  Widget searchBar() {

    return Container(

      height: 34,

      margin: const EdgeInsets.fromLTRB(
        12,
        10,
        12,
        5,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(8),

        border: Border.all(
          color: const Color(0xFFE5E5E5),
        ),
      ),

      child: TextField(

        controller: searchController,

        onChanged: searchContacts,

        style: const TextStyle(
          fontSize: 11,
        ),

        decoration: InputDecoration(

          hintText: 'Search contacts...',

          hintStyle: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade500,
          ),

          prefixIcon: const Icon(
            Icons.search,
            size: 16,
            color: Colors.grey,
          ),

          suffixIcon:
          searchController.text.isNotEmpty

              ? IconButton(
            padding: EdgeInsets.zero,

            onPressed: () {

              searchController.clear();

              searchContacts('');
            },

            icon: const Icon(
              Icons.close,
              size: 15,
              color: Colors.grey,
            ),
          )

              : null,

          border: InputBorder.none,

          contentPadding:
          const EdgeInsets.symmetric(
            vertical: 9,
          ),
        ),
      ),
    );
  }


  // --------------------------------------------------
  // DRAWER
  // --------------------------------------------------

  Widget buildDrawer() {

    return Drawer(

      width: 275,

      child: SafeArea(

        child: Column(

          children: [

            // ------------------------------------------
            // DRAWER HEADER
            // ------------------------------------------

            Container(

              height: 180,

              width: double.infinity,

              color: const Color(0xFF5146D8),

              padding:
              const EdgeInsets.fromLTRB(
                20,
                25,
                20,
                20,
              ),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                mainAxisAlignment:
                MainAxisAlignment.end,

                children: [

                  const Icon(
                    Icons.groups,
                    size: 45,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 15),

                  const Text(

                    'My Contacts',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(

                    'Manage your friends easily',

                    style: TextStyle(
                      color: Colors.white.withOpacity(.85),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),


            // ------------------------------------------
            // MY CONTACTS
            // ------------------------------------------

            ListTile(

              selected: true,

              selectedTileColor:
              const Color(0xFFF0EEFF),

              leading: const Icon(
                Icons.contacts,
                size: 19,
                color: Color(0xFF5146D8),
              ),

              title: const Text(
                'My Contacts',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF5146D8),
                  fontWeight: FontWeight.w500,
                ),
              ),

              trailing: const Icon(
                Icons.chevron_right,
                size: 18,
              ),

              onTap: () {
                Navigator.pop(context);
              },
            ),


            // ------------------------------------------
            // FAVORITES
            // ------------------------------------------

            ListTile(

              leading: const Icon(
                Icons.star,
                size: 19,
              ),

              title: const Text(
                'Favorites',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),

              trailing: const Icon(
                Icons.chevron_right,
                size: 18,
              ),

              onTap: () {
                Navigator.pop(context);
              },
            ),


            // ------------------------------------------
            // ADD CONTACT
            // ------------------------------------------

            ListTile(

              leading: const Icon(
                Icons.person_add,
                size: 19,
              ),

              title: const Text(
                'Add Contact',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),

              trailing: const Icon(
                Icons.chevron_right,
                size: 18,
              ),

              onTap: () {

                Navigator.pop(context);

                openAddContact();
              },
            ),


            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
            ),


            // ------------------------------------------
            // ABOUT APP
            // ------------------------------------------

            ListTile(

              leading: const Icon(
                Icons.info_outline,
                size: 19,
              ),

              title: const Text(
                'About App',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),

              trailing: const Icon(
                Icons.chevron_right,
                size: 18,
              ),

              onTap: () {},
            ),


            // ------------------------------------------
            // SETTINGS
            // ------------------------------------------

            ListTile(

              leading: const Icon(
                Icons.settings_outlined,
                size: 19,
              ),

              title: const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),

              trailing: const Icon(
                Icons.chevron_right,
                size: 18,
              ),

              onTap: () {},
            ),


            // ------------------------------------------
            // LOGOUT
            // ------------------------------------------

            ListTile(

              leading: const Icon(
                Icons.logout,
                size: 19,
              ),

              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),

              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }


  // --------------------------------------------------
  // BUILD
  // --------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // ================================================
      // APP BAR
      // ================================================

      appBar: AppBar(

        backgroundColor:
        const Color(0xFF5146D8),

        foregroundColor: Colors.white,

        elevation: 0,

        toolbarHeight: 62,

        leading: Builder(

          builder: (context) {

            return IconButton(

              onPressed: () {

                Scaffold.of(context).openDrawer();
              },

              icon: const Icon(
                Icons.menu,
                size: 21,
              ),
            );
          },
        ),

        title: const Text(

          'My Contacts',

          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),

        actions: [

          // SEARCH ICON
          IconButton(

            onPressed: () {

              FocusScope.of(context).requestFocus(
                FocusNode(),
              );

              searchController.selection =
                  TextSelection.fromPosition(
                    TextPosition(
                      offset:
                      searchController.text.length,
                    ),
                  );
            },

            icon: const Icon(
              Icons.search,
              size: 22,
            ),
          ),


          // MORE
          PopupMenuButton<String>(

            icon: const Icon(
              Icons.more_vert,
              size: 21,
            ),

            onSelected: (value) {

              if (value == 'refresh') {
                refreshContacts();
              }
            },

            itemBuilder: (context) {

              return const [

                PopupMenuItem(
                  value: 'refresh',
                  child: Text('Refresh'),
                ),

              ];
            },
          ),
        ],
      ),


      // ================================================
      // DRAWER
      // ================================================

      drawer: buildDrawer(),


      // ================================================
      // BODY
      // ================================================

      body: Column(

        children: [

          // SEARCH BOX
          searchBar(),


          // CONTACT LIST
          Expanded(

            child: filteredContacts.isEmpty

                ? emptyState()

                : RefreshIndicator(

              onRefresh:
              refreshContacts,

              child:
              ListView.builder(

                padding:
                const EdgeInsets.only(
                  top: 3,
                  bottom: 80,
                ),

                itemCount:
                filteredContacts.length,

                itemBuilder:
                    (context, index) {

                  return contactItem(
                    filteredContacts[index],
                    index,
                  );
                },
              ),
            ),
          ),
        ],
      ),


      // ================================================
      // FLOATING BUTTON
      // ================================================

      floatingActionButton:
      FloatingActionButton(

        onPressed:
        openAddContact,

        backgroundColor:
        const Color(0xFF5146D8),

        foregroundColor:
        Colors.white,

        elevation: 4,

        shape: const CircleBorder(),

        child: const Icon(
          Icons.add,
          size: 29,
        ),
      ),
    );
  }


  // --------------------------------------------------
  // DISPOSE
  // --------------------------------------------------

  @override
  void dispose() {

    searchController.dispose();

    super.dispose();
  }
}