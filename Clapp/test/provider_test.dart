import 'package:Clapp/src/Contract/provider/contract_provider.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
import 'package:Clapp/src/Finance/provider/finances_provider.dart';
import 'package:flutter/material.dart';

void main (){
  WidgetsFlutterBinding.ensureInitialized();
  final contractProvider = new ContratosProvider();
  final equipmentProvider = new EquipmentProvider();
  final financeProvider = new FinancesProvider();
}