<?php
    //le DSN est uniquement pour le PDO et les autres define pour PDO ou mysqli
    define ('DSN', "mysql:host=localhost;dbname=ProjetRJ;charset=utf8");
    
    define ('LOGIN_BDD', "root");
    define ('PASS_BDD', "");
    define ('SERVEUR_BDD', "localhost");
    define ('BASE_BDD', "ProjetRJ");

    try {
        $bdd = new PDO(DSN, LOGIN_BDD, PASS_BDD);
    }
    catch (Exception $e) {
        die('Erreur bdd : '.$e->getMessage());
    }

    $connexion = mysqli_connect(SERVEUR_BDD, LOGIN_BDD, PASS_BDD, BASE_BDD);

    if (!$connexion) {
        echo mysqli_connect_error($connexion);
    }

    mysqli_set_charset($connexion, "utf8");

?>