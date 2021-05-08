<?php

    try {
        $bdd = new PDO("mysql:host=localhost;dbname=ProjetRJ;charset=utf8", "root", "");
    }
    catch (Exception $e) {
        die('Erreur bdd : '.$e->getMessage());
    }

    $connexion = mysqli_connect("localhost", "root", "", "ProjetRJ");

    if (!$connexion) {
        echo mysqli_connect_error($connexion);
    }

    mysqli_set_charset($connexion, "utf8");

?>