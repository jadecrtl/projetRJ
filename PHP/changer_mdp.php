<?php
include('header.php');
?>
<form action="changer_mdp_verification.php" method="POST">

    <label>Nouveau mot de passe :</label>
    <input type="password" name="mdp_nouveau"></input><br />


    <label>Confirmation mot de passe :</label>
    <input type="password" name="mdp_nouveau_confirm"></input><br />

    <input type="submit" name="changer_mdp" value="Modifier le mot de passe"></input><br />
</form>