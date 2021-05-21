<?php
session_start();
?>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
    <link rel="stylesheet" href="css/style.css" />
</head>

<body>
    <div class="blocPrincipal">
        <div id="logo">
            <img src="img/logo.png" alt="image">
        </div>
        <div>
            <form action="connexion_verification.php" method="post">
                <input type="text" name="saisie_adresse_mail" value="" placeholder="adresse mail"></br>
                <input type="password" name="saisie_mot_de_passe" value="" placeholder="mot de passe"></br>
                <input type="submit" name="connexion" value="Connexion"></br>
            </form>
        </div>
        <div>
            </br>
            Si vous n'avez pas de compte <a href="inscription.php">Inscription</a>
            </br>
            Sinon naviguez en tant que <a href="accueil.php">visiteur</a>
        </div>
    </div>
</body>

</html>