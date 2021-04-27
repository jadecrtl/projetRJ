<?php

    if isset ($_SESSION['pseudonyme_connecte']){
        unset ($_SESSION['pseudonyme_connecte']);
    }
    header ("Location: https://localhost/mode-up/connexion.php");



?>