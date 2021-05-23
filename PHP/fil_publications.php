<?php
if (!isset($_SESSION)) {
    session_start();
}
include('bdd.php');
//test si on est connecté
if (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {

    $requete = "CALL ps_voir_publications('" . $_SESSION['pseudonyme_connecte'] . "')";
}
//mode visiteur
else {
    $requete = "CALL ps_voir_publications_visiteur()";
}

$resultat = mysqli_query($connexion, $requete);

if (!$resultat) {
    echo mysqli_error($connexion);
    exit();


}
$ligne = mysqli_fetch_assoc($resultat);

if (is_null($ligne)) {
    echo "Aucune publication.";
}
else 
{
    while ($ligne) 
    {
        $ligne['texte_publication'] = str_replace("\\r","\r",$ligne['texte_publication']);
        $ligne['texte_publication'] = str_replace("\\n","\n",$ligne['texte_publication']);
       
        echo "<article>";
        echo "Publié(e) par&nbsp" . htmlspecialchars($ligne['pseudonyme']) . " le&nbsp" . htmlspecialchars($ligne['date_creation']) . "</br></br>";

        echo nl2br($ligne['texte_publication']) . "</br></br>";

        echo "</article>";
    
        $ligne = mysqli_fetch_assoc($resultat);
    }
}


?>
