<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Inscription</title>
    <link rel="stylesheet" href="css/style.css" />
</head>

<body>
    <div class="blocPrincipal">
        <h1> Inscription : créer votre compte chez mode-up </h1>
        <form action="inscription_verification.php" method="POST">

            <input type="text" name="saisie_pseudonyme" placeholder="Pseudo"> <br>

            <input type="text" name="saisie_adresse_mail" placeholder="Adresse mail"> <br>

            <input type="password" name="saisie_mdp1" placeholder="Mot de passe"> <br>

            <input type="password" name="saisie_mdp2" placeholder="Confirmer votre mot de passe"> <br>

            <input type="submit" name="inscription" value="Inscription">

        </form>
    </div>
</body>

</html>