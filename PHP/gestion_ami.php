<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    if (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {
        include('bdd.php');
        $requete_pouvoir = "SELECT pouvoir FROM t_utilisateur where pseudonyme='".$_SESSION['pseudonyme_connecte']."'";
        $resultat_pouvoir = mysqli_query($connexion, $requete_pouvoir);
        $ligne_pouvoir  = mysqli_fetch_assoc($resultat_pouvoir);
        mysqli_free_result($resultat_pouvoir);
        mysqli_close($connexion);

        include('bdd.php');
        if(($ligne_pouvoir['pouvoir'] != 'public') && ($ligne_pouvoir['pouvoir'] != 'admin')){
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
                echo "<input type=\"hidden\" name=\"pseudonyme_a_refuser\" value=".$ligne['pseudonyme'].">";
                echo "</form>";
                echo "</td>";
                echo "</tr>";
                $ligne = mysqli_fetch_assoc($resultat);
            }
            echo "</table>";
            mysqli_free_result($resultat);
            mysqli_close($connexion);
        }
        include('bdd.php');
        $requete_ami = "CALL ps_voir_amis('".$_SESSION['pseudonyme_connecte']."')";
        $resultat_ami = mysqli_query($connexion, $requete_ami);
        $ligne_ami = mysqli_fetch_assoc($resultat_ami);
        echo "<table><caption>Mes relations</caption>";
        while ($ligne_ami) {
            echo "<tr>";
            echo "<td>".$ligne_ami['pseudonyme']."</td>";
            echo "<td>";
            echo "<form action=\"gestion_ami_desabonner.php\" method=\"POST\">";
            echo "<input type=\"submit\" name=\"retirer\" value=\"Retirer\">";
            echo "<input type=\"hidden\" name=\"pseudonyme_a_retirer\" value=".$ligne_ami['pseudonyme'].">";
            echo "</form>";
            echo "</td>";
            echo "</tr>";
            $ligne_ami = mysqli_fetch_assoc($resultat_ami);
        }
        echo "</table>";
        mysqli_close($connexion);
    }
    else {
        echo "Vous n'êtes pas connecté";
        echo "Retourner à la page d'<a href=\"accueil.php\">accueil</a>";
        exit();    
    }
?>