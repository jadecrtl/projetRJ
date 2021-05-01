<?php
session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
    <!--
        - redirection vers l'inscription
        - redirection vers l'accueil ( mode visiteur)
        - html
        - CSS
    -->

</head>
<body>
    <form action="accueil.php" method="post">
        Adresse mail<input type="text" name="saisie_adresse_mail" value=""></br>
        Mot de passe<input type="password" name="saisie_mot_de_passe" value=""></br>
        <input type="submit" name="connexion" value="Connexion"></br>
    </form>
    </br> 
    Si vous n'avez pas de compte <a href="inscription.php">Inscription</a>
    </br>
    Sinon naviguez en tant que <a href="accueil.php">visiteur</a>

    
</body>
</html>