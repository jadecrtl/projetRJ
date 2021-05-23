<?php
	if(!isset($_SESSION)) {
		session_start();	
	}
	if (isset($_SESSION['pseudonyme_connecte']) && 
		!empty($_SESSION['pseudonyme_connecte']) && 
		isset($_POST['critere_recherche']) && 
		!empty($_POST['critere_recherche'])) 
		{
		include('bdd.php');
		$requete = "CALL ps_voir_nouveaux_amis('".$_SESSION['pseudonyme_connecte']."', '".$_POST['critere_recherche']."')";
		$resultat = mysqli_query($connexion, $requete);
		if (!$resultat) {
			echo mysqli_error($connexion);
			exit();
		}
		$ligne = mysqli_fetch_assoc($resultat);
		echo "<table class=\"\"><caption>Resultat de la recherche</caption>";
		while($ligne) {
			echo "<tr>";
			echo "<td>".$ligne['pseudonyme']."</td>";
			echo "<td>";
			echo "<form action=\"gestion_ami_ajouter.php\" method=\"POST\" >";
			echo "<input type=\"submit\" name=\"ajouter\" value=\"Ajouter\">";
			echo "<input type=\"hidden\" name=\"pseudonyme_a_ajouter\" value=".$ligne['pseudonyme'].">";
			echo "</form>";
			echo "</td>";
			echo "</tr>";
			$ligne = mysqli_fetch_assoc($resultat);
		}
		echo "</table>";
		mysqli_free_result($resultat);
		mysqli_close($connexion);
	}









?>
