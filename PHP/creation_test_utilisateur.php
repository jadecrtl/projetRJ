<?php

    include ("bdd.php");
    try {
        $bdd = new PDO(DSN, LOGIN_BDD, PASS_BDD);
    }
    catch (Exception $e) {
        die('Erreur bdd : '.$e->getMessage());
    }
    
    $pseudonyme = 'jade3';
    $adresse_mail = $pseudonyme."@gmail.com";
    $mot_de_passe = password_hash($pseudonyme, PASSWORD_DEFAULT);
    $pouvoir = 'prive';
    
    
    
    $requete_sql = 'INSERT INTO t_utilisateur (pseudonyme, adresse_mail, mot_de_passe, pouvoir) VALUES ("'.$pseudonyme.'","'.$adresse_mail.'","'.$mot_de_passe.'","'.$pouvoir.'")';
    echo $requete_sql;
    $reponse_sql = $bdd->query($requete_sql);

    





?>