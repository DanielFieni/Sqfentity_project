import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

// Statement for the file to be created
// It is an interesting feature of the Dart language that makes 
// it easy to split a file into different parts to better 
// manage and navigate file as it gets big.part
part 'model.g.dart';

const tableUser = SqfEntityTable(
  tableName: 'user',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  // If useSoftDeleting is true then, The builder engine creates a field 
  // named "isDeleted" on the table. When item was deleted then this field 
  // value is changed to "1" (does not hard delete) in this case it is possible to 
  // recover a deleted item using the recover() method.
  modelName: null,
  // If the modelName (class name) is null then 
  // EntityBase uses TableName instead of modelName
  fields: [
    SqfEntityField('name', DbType.text),
    SqfEntityField('email', DbType.text),
    SqfEntityField('password', DbType.text),
  ] 
);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);

// SqfEntity provides support for the use of 
// multiple databases. So you can create many 
// Database Models and use them in the application.
@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: 'MyDbModel',
  databaseName: 'test_orm.db',
  databaseTables: [tableUser],
  sequences: [seqIdentity],
  // When bundledDatabasePath is empty then 
  // EntityBase creats a new database when 
  // initializing the database. If you want t
  // o use an existing database, type the attached 
  // database address here for ex: “/assets/sample.db”
  bundledDatabasePath: null,
);

// flutter pub run build_runner build --delete-conflicting-outputs
// - The build_runner package provides a concrete way of generating files using Dart code.
// - build: Runs a single build and exits.
// - delete-conflicting-outputs: Assume conflicting 
//  outputs in the users package are from previous builds, 
//  and skip the user prompt that would usually be provided.
