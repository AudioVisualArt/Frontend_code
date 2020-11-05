import 'dart:io';

import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/Finance/Model/Finance.dart';
import 'package:Clapp/src/Finance/provider/finances_provider.dart';
import 'package:Clapp/src/Props/Model/prop_model.dart';
import 'package:Clapp/src/Props/Provider/prop_provider.dart';
import 'package:Clapp/src/ScreenPlay/Model/screenplay_models.dart';
import 'package:Clapp/src/ScreenPlay/Provider/screenplay_provider.dart';
import 'package:Clapp/src/Space/provider/SpacesProvider.dart';
import 'package:Clapp/src/StockPhoto/provider/stockphoto_provider.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Clapp/src/Equipment/provider/equipment_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final contractProvider = new ContratosProvider();
  final equipmentProvider = new EquipmentProvider();
  final financeProvider = new FinancesProvider();
  final proyectProvider = new ProyectosProvider();
  final propsProvider = new PropProvider();
  final screenPlayProvider = new ScreenPlayProvider();
  final servicesProvider = new WorkersProvider();
  final spaceProvider = new SpacesProvider();
  final stockPhotoProvider = new StockPhotoProvider();
  final userProvider = new UsuarioProvider();

  group('ContractProvider', () {
    test('Get Contracts From Project', () async {
      print('Get Contracts From Project');
      final response = await contractProvider
          .cargarContratosProoyecto("S2xmILeqB7ytIuKqd5xa");
      expect(response, isA<List<ContractModel>>());
    });
    test('Get Contracts Offered', () async {
      print('Get Contracts Offered');
      final response = await contractProvider
          .cargarContratosOfrecidos("IGMd9Ev82iuABtwmJedW");
      expect(response, isA<List<ContractModel>>());
    });
    test('Save Contract', () async {
      print('Save Contract');
      ContractModel contract = new ContractModel();
      contract.projectId = "S2xmILeqB7ytIuKqd5xa";
      contract.latitud = 0;
      contract.longitud = 0;
      contract.acceptedBidder = false;
      contract.userBidderId = "IGMd9Ev82iuABtwmJedW";
      contract.acceptedApplicant = false;
      contract.jobPosition = "test";
      contract.payment = 99999;
      contract.workHours = 999999;

      final response = await contractProvider.crearContrato(contract);
      expect(response, isTrue);
    });
  });

  group('Equipment Provider', () {
    test('Get Equipments', () async {
      print('Get Equipments');
      final response = await equipmentProvider.cargarEquipments();
      expect(response, isA<List<EquipmentModel>>());
    });
    test('Get Equipment', () async {
      print('Get Equipment');
      final response =
          await equipmentProvider.cargarEquipmentsUser("8BK1ODjcFCtMYdqU2nzI");
      expect(response, isNull);
    });
    /*test('Save Equipment', ()async{
      print('Save Equipments');
      EquipmentModel equipment = new EquipmentModel();
      equipment.tag = "test";
      equipment.marca = "test";
      equipment.modelo = "test";
      equipment.rent= true;
      equipment.valor= 9999;
      equipment.titulo="test";
      equipment.fotoUrl= "https://firebasestorage.googleapis.com/v0/b/clappauth.appspot.com/o/Equipment%2FC%C3%A1mara%20Nikon?alt=media&token=366bd2b7-59cf-4ae7-b8d0-7720e89cc4b5";

      File photo = await File("test/test_resources/b4a49d4b864c74bb73de63f080ad7930-bot--n-de-perfil-de-instagram.png").create();

      final response = await equipmentProvider.crearEquipmente(equipment,photo);
      expect(response,isTrue);
    });*/
    /* test('Edit Equipment', ()async{
      print('Edit Equipment');
      EquipmentModel equipment = new EquipmentModel();
      equipment.tag = "test";
      equipment.marca = "test";
      equipment.modelo = "test";
      equipment.rent= true;
      equipment.valor= 9999;
      equipment.titulo="test";
      equipment.fotoUrl= "https://firebasestorage.googleapis.com/v0/b/clappauth.appspot.com/o/Equipment%2FC%C3%A1mara%20Nikon?alt=media&token=366bd2b7-59cf-4ae7-b8d0-7720e89cc4b5";

      File foto = new File("./test/test_resources/b4a49d4b864c74bb73de63f080ad7930-bot--n-de-perfil-de-instagram.png");

      final response = await equipmentProvider.editarEquipment(equipment, foto);
      expect(response,isNull);
    });*/
  });

  group('Finances Provider', () {
    test('Get Finances', () async {
      print('Get Finances');
      final response =
          await financeProvider.cargarFinanzas("75AdCbVzdVSQg78WaoFL");
      expect(response, isA<List<FinanceModel>>());
    });

    test('Save Finances', () async {
      print('Save Finances');
      FinanceModel finance = new FinanceModel();
      finance.projectId = "test";
      finance.title = "test";
      finance.percentage = 999;
      finance.quantity = 999;
      final response = await financeProvider.crearFinance(finance);
      expect(response, isTrue);
    });
  });
  group('Project Provider', () {
    test('Get Projects', () async {
      print('Get Projects');
      final response = await proyectProvider.cargarTodosProyectos();
      expect(response, isA<List<ProjectModel>>());
    });
    test('Get Projects From User', () async {
      print('Get Projects From User');
      final response =
          await proyectProvider.cargarProyectos("IGMd9Ev82iuABtwmJedW");
      expect(response, isA<List<ProjectModel>>());
    });
    test('Save Projects From User', () async {
      print('Save Projects From User');
      ProjectModel project = new ProjectModel();
      project.main_file =
          "./test/test_resources/b4a49d4b864c74bb73de63f080ad7930-bot--n-de-perfil-de-instagram.png";
      project.executive_summary =
          "./test/test_resources/b4a49d4b864c74bb73de63f080ad7930-bot--n-de-perfil-de-instagram.png";
      project.proyectName = "test";
      project.ownerId = "test";
      project.description = "test";
      project.contacto = "test";
      project.projectType = "test";

      final response = await proyectProvider.crearProyecto(project);
      expect(response, isNotEmpty);
    });
  });
  group('Props Provider', () {
    test('Get Props', () async {
      print('Get Props');
      final response = await propsProvider.cargarProps();
      expect(response, isA<List<PropModel>>());
    });

    /*test('Save Props', ()async{
      print('Saver Props');
      PropModel propModel = new PropModel();

      File foto = await File("./test/test_resources/b4a49d4b864c74bb73de63f080ad7930-bot--n-de-perfil-de-instagram.png").create();
      final response = await propsProvider.crearProp(propModel, foto);
      expect(response,isA<List<PropModel>>());
    });*/
  });

  group('ScreenPlay Provider', () {
    test('Get ScreenPlays', () async {
      print('Get ScreenPlays');
      final response = await screenPlayProvider.cargarScreenPlays();
      expect(response, isA<List<ScreenPlayModel>>());
    });
    test('Get ScreenPlays', () async {
      print('Get ScreenPlays');
      ScreenPlayModel screenPlayModel = new ScreenPlayModel();

      PlatformFile screenplay;

      final response =
          await screenPlayProvider.crearScreenPlay(screenPlayModel, screenplay);
      expect(response, isA<List<ScreenPlayModel>>());
    });
  });
}
