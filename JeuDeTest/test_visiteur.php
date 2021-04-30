<?php

    include ("bdd.php");

    $requete_sql = ' SELECT * FROM t_publication WHERE id_utilisateur IN (
        SELECT pseudonyme FROM t_utilisateur WHERE pouvoir ="public" ) ';
    echo $requete_sql;
    $reponse_sql = $bdd->query($requete_sql);
 


?>