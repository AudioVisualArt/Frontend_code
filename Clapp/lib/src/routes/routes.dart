import 'package:Clapp/src/Finance/pages/finances.dart';
import 'package:Clapp/src/Finance/pages/new_goal.dart';

import 'package:Clapp/src/NewHome/Pages/home_market_page.dart';
import 'package:Clapp/src/NewHome/Pages/home_page_principal.dart';
import 'package:Clapp/src/NewHome/Pages/home_servicios_page.dart';
import 'package:Clapp/src/PhotoFind/pages/find_fast_page.dart';
import 'package:Clapp/src/Props/Pages/prop_edit_page.dart';
import 'package:Clapp/src/Props/Pages/prop_page.dart';
import 'package:Clapp/src/ScreenPlay/Pages/screenplay_edit_page.dart';
import 'package:Clapp/src/ScreenPlay/Pages/screenplay_page.dart';
import 'package:Clapp/src/Space/pages/new_space.dart';
import 'package:Clapp/src/Space/pages/new_space2.dart';
import 'package:Clapp/src/Space/pages/spaces_page.dart';
import 'package:Clapp/src/Space/pages/spaces_page.dart';
import 'package:Clapp/src/StockPhoto/pages/stockphoto_edit_page.dart';
import 'package:Clapp/src/User/pages/actividad_page.dart';
import 'package:Clapp/src/User/pages/contracts_page.dart';
import 'package:Clapp/src/User/pages/edit_profile_page.dart';
import 'package:Clapp/src/User/pages/inicio_clapp_terminos.dart';
import 'package:Clapp/src/item/pages/menu_mostrar.dart';
import 'package:Clapp/src/projectos/pages/presupuesto_page.dart';
import 'package:Clapp/src/projectos/pages/Project_page.dart';
import 'package:Clapp/src/Space/pages/space_details.dart';
import 'package:Clapp/src/User/pages/contracts_page.dart';
import 'package:Clapp/src/projectos/pages/presupuesto_page.dart';
import 'package:Clapp/src/projectos/pages/project_details_outsider.dart';
import 'package:Clapp/src/projectos/pages/recomendados_page.dart';
import 'package:Clapp/src/services/pages/contratar_page.dart';
import 'package:Clapp/src/User/pages/sign_up_google.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/User/pages/message_info_page.dart';
import 'package:Clapp/src/projectos/pages/collaborator_page.dart';
import 'package:Clapp/src/services/pages/other_page.dart';
import 'package:Clapp/src/Contract/pages/new_contract.dart';
import 'package:Clapp/src/Contract/pages/ver_contratos.dart';
import 'package:Clapp/src/projectos/pages/project_details.dart';
import 'package:Clapp/src/User/pages/home_page.dart';
import 'package:Clapp/src/User/pages/login_page.dart';
import 'package:Clapp/src/User/pages/signup_page.dart';
import 'package:Clapp/src/item/pages/producto_page.dart';
import 'package:Clapp/src/item/pages/ver_productos_page.dart';
import 'package:Clapp/src/MyStudio/pages/my_studio_page.dart';
import 'package:Clapp/src/MyStudio/pages/store_page.dart';
import 'package:Clapp/src/projectos/pages/new_project_page.dart';
import 'package:Clapp/src/Contract/pages/new_contract.dart';
import 'package:Clapp/src/Contract/pages/ver_contratos.dart';
import 'package:Clapp/src/User/pages/settings_page.dart';
import 'package:Clapp/src/User/pages/profile_page.dart';
import 'package:Clapp/src/User/pages/messages_page.dart';
import 'package:Clapp/src/services/pages/services_page.dart';
import 'package:Clapp/src/item/pages/ver_productos_compra.dart';
import 'package:Clapp/src/item/pages/producto_compra.dart';
import 'package:Clapp/src/services/pages/new_service.dart';
import 'package:Clapp/src/projectos/pages/collaborator_page.dart';
import 'package:Clapp/src/Equipment/pages/equipment_page.dart';
import 'package:Clapp/src/item/pages/menu_agregar.dart';
import 'package:Clapp/src/Equipment/pages/equipment_edit_page.dart';
import 'package:Clapp/src/Market/pages/items_buy_general_page.dart';
import 'package:Clapp/src/Equipment/pages/equipment_buy_page.dart';
import 'package:Clapp/src/services/pages/contratar_page.dart';
import 'package:Clapp/src/services/pages/personel_page.dart';
import 'package:Clapp/src/StockPhoto/pages/stockphoto_page.dart';
import 'package:Clapp/src/User/pages/sign_up_google.dart';

import 'package:Clapp/src/Contract/pages/my_contract_requests.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'signUp': (BuildContext context) => SignUp(),
    'producto': (BuildContext context) => ProductoPage(),
    'proyectos': (BuildContext context) => ProjectPage(),
    'ver_producto': (BuildContext context) => MostrarProductosPage(),
    'my_studio': (BuildContext context) => MyStudioPage(),
    'store': (BuildContext context) => StorePage(),
    'services': (BuildContext context) => ServicesPages(),
    'new_project': (BuildContext context) => NewProjectPage(),
    'settings': (BuildContext context) => SettingsPage(),
    'profile': (BuildContext context) => ProfilePage(),
    'actividad': (BuildContext context) => ActividadPage(),
    'message': (BuildContext context) => MessagePage(),
    'see_contracts': (BuildContext context) => VerContratos(),
    'new_contract': (BuildContext context) => NewContract(),
    'ver_productos_compra': (BuildContext context) =>
        MostrarProductosCompraPage(),
    'producto_compra': (BuildContext context) => ProductoCompraPage(),
    'details_project': (BuildContext context) => ProjectDetails(),
    'new_service': (BuildContext context) => NewService(),
    'contratos': (BuildContext context) => ContratarPage(),
    'collaborators': (BuildContext context) => VerColaboradores(),
    'equipment': (BuildContext context) => EquipmentPage(),
    'menu_item': (BuildContext context) => MenuAgregarPage(),
    'equipment_edit': (BuildContext context) => EquipmentEditPage(),
    'equipment_comprar': (BuildContext context) => EquipmentCompraPage(),
    'items_buy': (BuildContext context) => ItemsComprarPage(),
    'open_contracts': (BuildContext context) => OtherPage(),
    'messageInfo': (BuildContext context) => MessageInfo(),
    'register_google': (BuildContext context) => SignUpGoogle(),
    'contratar_page': (BuildContext context) => ContratarPage(),
    'personal': (BuildContext context) => PersonelPage(),
    'photos': (BuildContext context) => StockPhotoPage(),
    'finances': (BuildContext context) => Finances(),
    'ver_contratos_recibidos': (BuildContext context) =>
        VerContratosRecibidos(),
    'newgoal': (BuildContext context) => NewGoal(),
    'screenplay': (BuildContext context) => ScreenPlayPage(),
    'mycontract': (BuildContext context) => MyContractRequest(),
    'presupuesto': (BuildContext context) => PresupuestoPage(),
    'space_details': (BuildContext context) => SpaceDetails(),
    'recomendado': (BuildContext context) => RecomendadosPage(),
    'nuevoespacio': (BuildContext context) => NewSpace(),
    'nuevoespacio2': (BuildContext context) => NewSpace2(),
    'space': (BuildContext context) => SpacesPage(),
    'spaces': (BuildContext context) => SpacesPage(),
    'find_photo': (BuildContext context) => FindByPhotoPage(),
    'editar_perfil': (BuildContext context) => EditProfile(),
    'home_market': (BuildContext context) => HomeMarketPage(),
    'home_servicios': (BuildContext context) => HomeServiciosPage(),
    'home_principal': (BuildContext context) => HomePagePrincipal(),
    'props': (BuildContext context) => PropPage(),
    'terminos_clapp': (BuildContext context) => InicioClapp(),
    'menu_mostrar': (BuildContext context) => MenuMostrarPage(),
    'stockphoto_edit': (BuildContext context) => StockPhotoEditPage(),
    'screenplay_edit': (BuildContext context) => ScreenPlayEditPage(),
    'prop_edit': (BuildContext context) => PropEditPage(),
  };
}
