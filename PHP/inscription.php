<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
    <style>
    .container{
       
    /* On ajoute une marge sur les cotés de l'écran */
    padding-right: 15px;
    padding-left: 15px;

    /* Et on centre */
    margin-right: auto;
    margin-left: auto;

    }
    @media (min-width: 1200px){
    .container {
        width: 1170px;
    }
}
    
    </style>
</head>
<body class="container">

    <h1> Inscription : créer votre compte chez mode-up </h1>
    <form action="inscription_verification.php" method="POST" >

        <label>Pseudo :</label>
        <input type="text" name="saisie_pseudonyme"> <br>

        <label>Adresse mail :</label>
        <input type="text" name="saisie_adresse_mail"> <br>

        <label>Mot de passe :</label>
        <input type="password" name="saisie_mdp1"> <br>

        <label>Confirmer votre mot de passe :</label>      
        <input type="password" name="saisie_mdp2"> <br>

        <input type="submit" name="inscription" value="Inscription">

    </form>    
</body>
</html>