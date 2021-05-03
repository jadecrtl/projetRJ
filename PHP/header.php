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
        
        <div>
            <a href="accueil.php"><img src="logo.png"></a> <br>
        </div>

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
                echo '<a href="changer_mdp.php">Modifier votre mot de passe</a>';
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
