<?php
if (!isset($_SESSION)) {
  session_start();
}
?>
<html>

<head>
  <meta charset="UTF-8" />
  <title>Accueil de mode-up</title>
  <link rel="stylesheet" href="css/style2.css" />
</head>

<body>
    <div>
      <header><?php include('header.php'); ?></header>
    </div> 
    <div>
      <h1>Bienvenue
      <?php
      if (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {
        echo " " . $_SESSION['pseudonyme_connecte'];
      } else {
        echo " cher visiteur, vous pouvez vous connecter ou vous inscrire.";
      }
      ?>
      </h1>
  </div>

  <div> <?php include('fil_publications.php');?></div>

</body>

</html>