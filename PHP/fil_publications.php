<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    include('bdd.php');
    //test si on est connecté
    if (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {
        
        $requete = "CALL ps_voir_publications('".$_SESSION['pseudonyme_connecte']."')";
        
        $resultat = mysqli_query($connexion, $requete);

        if (!$resultat) {
            echo mysqli_error($connexion);
            exit();
        }
        
        $ligne = mysqli_fetch_assoc($resultat);

        while ($ligne) {

            echo "Publié(e) par&nbsp".htmlspecialchars($ligne['pseudonyme'])." le&nbsp".htmlspecialchars($ligne['date_creation'])."</br></br>";
            echo htmlspecialchars($ligne['texte_publication'])."</br></br>";
            
            $ligne = mysqli_fetch_assoc($resultat);            

        }








    }
    //mode visiteur
    else { 

    }
