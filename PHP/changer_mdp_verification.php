<?php
    session_start();
    include('bdd.php');

    if (
        (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) &&        
        (isset($_POST['mdp_nouveau']) && !empty($_POST['mdp_nouveau'])) &&
        (isset($_POST['mdp_nouveau_confirm']) && !empty($_POST['mdp_nouveau_confirm'])) &&
        ($_POST['mdp_nouveau'] == $_POST['mdp_nouveau_confirm'])
       ) 
       {
            $mdp_crypte = password_hash($_POST['mdp_nouveau'], PASSWORD_DEFAULT);
            $requete = "UPDATE t_utilisateur SET mot_de_passe = '".$mdp_crypte."' WHERE pseudonyme = '".$_SESSION['pseudonyme_connecte']."'";

            $resultat = mysqli_query($connexion, $requete);
            if (!$resultat) {
                echo mysqli_error($connexion);
                echo "Erreur: impossible de modifier le mot de passe, réessayez <a href=\"changer_mdp.php\">ici.</a> ";
                exit();
            }
            header('location: accueil.php');
            exit();    
       }
    else {
        echo "Erreur: les mots de passe ne sont pas identiques ou sont vides.</br>";
        echo "Retourner à la page de <a href=\"changer_mdp.php\">modification de mot de passe.</a>";
        echo "Ou connectez vous <a href=\"connexion.php\">ici.</a>";
        exit();        
    }
?>