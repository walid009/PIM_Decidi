class Proposition {
  late String propositionId;
  //late String propositionImage;

  late String Bac;
  late int Code;
  late String Filiere;
  late String Universite;
  late String Etablissement;
  late String Gouvernorat;
  late String Criteres;
  late String Duree;
  late String Score;

  late List<dynamic> propositionsList;

  Proposition(
    this.propositionId,
    //this.propositionImage,
    this.Bac,
    this.Code,
    this.Filiere,
    this.Universite,
    this.Etablissement,
    this.Gouvernorat,
    this.Criteres,
    this.Duree,
    this.Score,
  );
}
