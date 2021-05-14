<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    if (isset($_POST['annuler']) && $_POST['annuler'] == 'Annuler') {
        header("location: accueil.php");
        exit();
    }
?>