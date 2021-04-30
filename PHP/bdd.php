<?php
    define ('DSN', "mysql:host=localhost;dbname=ProjetRJ;charset=utf8");
    define ('LOGIN_BDD', "root");
    define ('PASS_BDD', "");

    try {
        $bdd = new PDO(DSN, LOGIN_BDD, PASS_BDD);
    }
    catch (Exception $e) {
        die('Erreur bdd : '.$e->getMessage());
    }

?>