<?php
    include('bdd.php');
    if (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {
            
        $requete = "CALL ps_voir_mon_profil('".$_SESSION['pseudonyme_connecte']."')";
        $resultat = mysqli_query($connexion,$requete);

        if (!$resultat) {
            echo mysqli_error($connexion);
            exit();
        }

        $affiche = mysqli_fetch_assoc($resultat);
    }
?>