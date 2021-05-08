<?php
    if (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {
        
        $requete = "CALL ps_voir_publications('".$_SESSION['pseudonyme_connecte']."')";
        $resultat1 = mysqli_query($connexion,$requete);

        if (!$resultat1) {
            echo mysqli_error($connexion);
            exit();
        }
        
        $affiche1 = mysqli_fetch_assoc($resultat1);
        mysqli_free_result($resultat1);

    }
?>
