<?php
if (!isset($_SESSION)) {
    session_start();
}
?>

<nav>

    
    <ul>
        <li>
            
            <a href="accueil.php"><img src="img/logo.png" alt="image"></a> 
        </li>
        <?php
        if (isset($_SESSION['pseudonyme_connecte'])) {
            echo "<li>";
            echo "<a href=\"accueil_profil.php\" class=\"amenu\">Profil de " . $_SESSION['pseudonyme_connecte'] . "</a>";
            echo "</li>";
        }
        ?>

        <?php
        if (isset($_SESSION['pseudonyme_connecte'])) {
            include('bdd.php');
            $requete = "CALL ps_voir_notifications('".$_SESSION['pseudonyme_connecte']."')";
            $resultat = mysqli_query($connexion, $requete);
            $ligne = mysqli_fetch_assoc($resultat);
            if (!$resultat) {
                echo mysqli_error($connexion);
                echo "Echec de la requête.";
                exit();
            }
            if (mysqli_num_rows($resultat) == 1) {
                echo "<li>";
                echo "<a class=\"amenu\">Demandes en amis: ".$ligne['nb_notif']."</a>";
                echo "</li>";    
            }
        }
        ?>

        <?php
        if (isset($_SESSION['pseudonyme_connecte'])) {
            echo "<li>";
            echo "<a href=\"accueil_gestion_ami.php\" class=\"amenu\">Gérer mes amis</a>";
            echo "</li>";
        }
        ?>

        <?php
        if (isset($_SESSION['pseudonyme_connecte'])) {
            echo "<li>";
            echo "<a href=\"accueil_recherche_ami.php\" class=\"amenu\">Rechercher des amis</a>";
            echo "</li>";
        }
        ?>

        <?php
        if (isset($_SESSION['pseudonyme_connecte'])) {
            echo "<li>";
            echo '<a href="deconnexion.php" class="amenu">Deconnexion</a><br/>';
            echo "</li>";
        } else {
            echo "<li>";
            echo '<a href="connexion.php" class="amenu">Connexion</a>';
            echo "</li>";
        }
        ?>

        <?php
        if (isset($_SESSION['pseudonyme_connecte'])) {
            echo "<form action=\"accueil_creer_publication.php\" method=\"POST\" class=\"form\">";
            echo "<input type=\"submit\" name=\"creation publication\" value=\"Creation publication\" />";
            echo "</form>";
        }
        ?>

    </ul>

</nav>