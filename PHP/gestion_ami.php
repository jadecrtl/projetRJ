<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    if (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {
        include('bdd.php');
        $requete = "CALL ps_voir_attentes('".$_SESSION['pseudonyme_connecte']."')";
        $resultat = mysqli_query($connexion, $requete);
        $ligne = mysqli_fetch_assoc($resultat);
        echo "<table><caption>Les demandes en attente</caption>";
        while ($ligne) {
            echo "<tr>";
            echo "<td>".$ligne['pseudonyme']."</td>";
            echo "<td>";
            echo "<form action=\"gestion_ami_accepter.php\" method=\"POST\">";
            echo "<input type=\"submit\" name=\"accepter\" value=\"Accepter\">";
            echo "<input type=\"hidden\" name=\"pseudonyme_a_accepter\" value=".$ligne['pseudonyme'].">";
            echo "</form>";
            echo "</td>";
            echo "<td>";
            echo "<form action=\"gestion_ami_refuser.php\" method=\"POST\">";
            echo "<input type=\"submit\" name=\"refuser\" value=\"Refuser\">";
            echo "</form>";
            echo "</td>";
            echo "</tr>";
            $ligne = mysqli_fetch_assoc($resultat);
        }
        echo "</table>";
        mysqli_free_result($resultat);
        mysqli_close($connexion);

        include('bdd.php');
        $requete = "CALL ps_voir_amis('".$_SESSION['pseudonyme_connecte']."')";
        $resultat = mysqli_query($connexion, $requete);
        $ligne = mysqli_fetch_assoc($resultat);
        echo "<table><caption>Mes relations</caption>";
        while ($ligne) {
            echo "<tr>";
            echo "<td>".$ligne['pseudonyme']."</td>";
            echo "<td>";
            echo "<form action=\"gestion_ami_desabonner.php\" method=\"POST\">";
            echo "<input type=\"submit\" name=\"retirer\" value=\"Retirer\">";
            echo "</form>";
            echo "</td>";
            echo "</tr>";
            $ligne = mysqli_fetch_assoc($resultat);
        }
        echo "</table>";
        mysqli_free_result($resultat);
    }
    else {
        echo "Vous n'êtes pas connecté";
        echo "Retourner à la page d'<a href=\"accueil.php\">accueil</a>";
        exit();    
    }
?>