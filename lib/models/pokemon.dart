import 'dart:developer';

import 'package:flutter/material.dart';

class Pokemon with ChangeNotifier {
  var id;
  var name;
  var sprite;
  var type1;
  var type2;
  var hp;
  var attack;
  var defense;
  var speed;
  var spAttack;
  var spDefense;
  var description;

  Pokemon({
    this.id,
    this.name,
    this.sprite,
    this.type1,
    this.type2,
    this.hp,
    this.attack,
    this.defense,
    this.speed,
    this.spAttack,
    this.spDefense,
    this.description,
  });

  factory Pokemon.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> secJson) {
    String pokeId = json['id'].toString();
    int hp = json['stats'][0]['base_stat'];
    int attack = json['stats'][1]['base_stat'];
    int defense = json['stats'][2]['base_stat'];
    int spAttack = json['stats'][3]['base_stat'];
    int spDefense = json['stats'][4]['base_stat'];
    int speed = json['stats'][5]['base_stat'];
    // need to find more effective way to access flavor text
    List descJson = secJson['flavor_text_entries'];
    int descIndex;
    for (int i = 0; i < descJson.length; i++) {
      var desc = secJson['flavor_text_entries'][i]['language']['name'];
      if (desc == 'en') {
        descIndex = i;
      }
    }
    String pokeDesc = secJson['flavor_text_entries'][descIndex]['flavor_text'];
    double pokeHp = hp / 100;
    double pokeAttack = attack / 100;
    double pokeDef = defense / 100;
    double pokeSpAttack = spAttack / 100;
    double pokespDefense = spDefense / 100;
    double pokeSpeed = speed / 100;

    final List types = json['types'];

    if (types.length == 1) {
      return Pokemon(
        id: pokeId,
        name: json['name'],
        sprite: json['sprites']['front_default'],
        type1: json['types'][0]['type']['name'],
        type2: null,
        hp: pokeHp,
        attack: pokeAttack,
        defense: pokeDef,
        speed: pokeSpeed,
        spAttack: pokeSpAttack,
        spDefense: pokespDefense,
        description: pokeDesc,
      );
    } else {
      return Pokemon(
        id: pokeId,
        name: json['name'],
        sprite: json['sprites']['front_default'],
        type1: json['types'][0]['type']['name'],
        type2: json['types'][1]['type']['name'],
        hp: pokeHp,
        attack: pokeAttack,
        defense: pokeDef,
        speed: pokeSpeed,
        spAttack: pokeSpAttack,
        spDefense: pokespDefense,
        description: pokeDesc,
      );
    }
  }
}
