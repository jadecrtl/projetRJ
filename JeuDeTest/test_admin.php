<?php

    include ("bdd.php");
   
    
    $pseudonyme = 'admin';
    $adresse_mail = $pseudonyme."@gmail.com";
    $mot_de_passe = password_hash($pseudonyme, PASSWORD_DEFAULT);
    $pouvoir = 'admin';
    
    
    
    $requete_sql = 'INSERT INTO t_utilisateur (pseudonyme, adresse_mail, mot_de_passe, pouvoir) VALUES ("'.$pseudonyme.'","'.$adresse_mail.'","'.$mot_de_passe.'","'.$pouvoir.'")';
    echo $requete_sql;
    $reponse_sql = $bdd->query($requete_sql);

    


?>