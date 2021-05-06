<?php
session_start();
include('bdd.php');

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Accueil</title>
    </head>
    <body>
    <nav>
        <ul>
        
        <li>
            <a href="accueil.php"><img src="logo.png"></a> <br>
        </li>
        <li>
            <a href="profil.php">Profil</a>
        </li>
        <li>
            <a>Notifications</a>
        </li>
        
        <li>
            <a>Demande d'ami</a>
        </li>
                    
        <li>
            <?php
            if (isset($_SESSION['pseudonyme_connecte'])){
                echo '<a href="deconnexion.php">Deconnexion</a><br/>';
            } 
            else { 
                echo '<a href="connexion.php">Connexion</a>';
            } 
            ?>
        </li>
                    
        </ul>
                        
        </nav>
    </body>
</html>
