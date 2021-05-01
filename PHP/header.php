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
    <ul class="nav justify-content-center text-decoration-none ">
        <div >
                <a href="accueil.php"><img src="logo.png"></a> <br>

            </div>
                        <li>
                            <a href="Membres.php">Notifications</a>
                        </li>
                        <li>
                            <a href="Membres.php">Messages</a>
                        </li>
                        
                        <li class="nav-item px-3">
                            <?php if (isset($_SESSION['user'])) {
                            echo '<a class="nav-link color3" href="deconnexion.php">Deconnexion</a>';
                            } else { 
                            echo '<a class="nav-link color3" href="connexion.php">Connexion</a>';
                            } ?>
        </li>
                    
    </ul>
                        
</nav>

