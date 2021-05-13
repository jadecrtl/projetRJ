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
        <?php
        if (isset($_SESSION['pseudonyme_connecte'])) {
            echo "<li>";
            echo "<a href=\"accueil_profil.php\">Profil de " . $_SESSION['pseudonyme_connecte'] . "</a>";
            echo "</li>";
        }
        ?>

        <?php
        if (isset($_SESSION['pseudonyme_connecte'])) {
            echo "<li>";
            echo "<a>Notifications</a>";
            echo "</li>";
        }
        ?>

        <?php
        if (isset($_SESSION['pseudonyme_connecte'])) {
            echo "<li>";
            echo "<a href=\"accueil_gestion_ami.php\">Gérer mes amis</a>";
            echo "</li>";
        }
        ?>

        <?php
        if (isset($_SESSION['pseudonyme_connecte'])) {
            echo "<li>";
            echo "<a href=\"accueil_recherche_ami.php\">Rechercher des amis</a>";
            echo "</li>";
        }
        ?>

        <?php
        if (isset($_SESSION['pseudonyme_connecte'])) {
            echo '<a href="deconnexion.php">Deconnexion</a><br/>';
        } else {
            echo '<a href="connexion.php">Connexion</a>';
        }
        ?>

        <?php
        if (isset($_SESSION['pseudonyme_connecte'])) {
            echo "<form action=\"accueil_creer_publication.php\" method=\"POST\">";
            echo "<input type=\"submit\" name=\"creation publication\" value=\"Creation publication\" />";
            echo "</form>";
        }
        ?>

    </ul>

</nav>