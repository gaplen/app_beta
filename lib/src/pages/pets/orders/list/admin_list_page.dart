
import 'package:app_beta/src/pages/pets/orders/list/admin_list_controller.dart';
import 'package:app_beta/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AdminOrdersListPage extends StatefulWidget {
  const AdminOrdersListPage({Key key}) : super(key: key);

  @override
  _AdminOrdersListPageState createState() =>
      _AdminOrdersListPageState();
}

class _AdminOrdersListPageState extends State<AdminOrdersListPage> {
  AdminOrdersListController _con = new AdminOrdersListController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con.status?.length,
      child: Scaffold(
        key: _con.key,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            centerTitle: true,
            title: Text('Admin panel'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue.shade100,
            flexibleSpace: Column(
              children: [
                SizedBox(height: 40),
                _menuDrawer(),
              ],
            ),
          ),
        ),
        drawer: _drawer(),

        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _widPanel(),
           
            ],
          ),
        ),
      ),
    );
  }


  Widget _widPanel(){
    return Container(
      child: Column(
        children: [
             Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _con.goToCategoryCreate,
                    child: Container(
                      height: 150,
                      width: 150,
                      color: Colors.red,
                      child: Center(child: Text('Crear Categoria', style: TextStyle(color: Colors.black),)),
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: _con.goToProductCreate,
                    child: Container(
                      height: 150,
                      width: 150,
                      color: Colors.red,
                      child: Center(child: Text('Añadir Mascota', style: TextStyle(color: Colors.black),),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

               Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    color: Colors.red,
                    child: TextButton(
                      onPressed: (){
                        print(' puto perro');
                      } ,
                      // _con.goToRestaurantOrder,
                      child: Text('solicitudes', style: TextStyle(color: Colors.black),),
                    )
                  ),
                  SizedBox(width: 10),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      height: 150,
                      width: 150,
                      color: Colors.red,
                      child: Center(child: Text('Otros')),
                    ),
                  ),
                ],
              ),
            
        ],
      ),
    );
  }
  
  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/menu.png', width: 20, height: 20),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: MyColors.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.phone ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: _con.user?.image != null
                          ? NetworkImage(_con.user?.image)
                          : AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  )
                ],
              )),
          ListTile(
            onTap: _con.goToCategoryCreate,
            title: Text('Crear categoria'),
            trailing: Icon(Icons.list_alt),
          ),
          ListTile(
            onTap: _con.goToProductCreate,
            title: Text('Añadir Mascota'),
            trailing: Icon(Icons.local_pizza),
          ),
          _con.user != null
              ? _con.user.roles.length > 1
                  ? ListTile(
                      onTap: _con.goToRoles,
                      title: Text('Seleccionar rol'),
                      trailing: Icon(Icons.person_outline),
                    )
                  : Container()
              : Container(),
          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar sesion'),
            trailing: Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {}); // CTRL + S
  }
}
