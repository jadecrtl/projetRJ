<?php
if (!isset($_SESSION)) {
    session_start();
}
?>

<nav>
<img src="img/mannequin.png" alt="image" width="100" height="100">    
    <ul>        
        <li>
            <a href="accueil.php">Accueil</a> <br>
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
