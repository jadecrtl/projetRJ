<?php
if (!isset($_SESSION)) {
  session_start();
}
?>
<html>

<head>
  <meta charset="UTF-8" />
  <title>Accueil de mode-up</title>
  <link rel="stylesheet" href="css/style.css" />
</head>

<body>
  <header>
    <?php include('header.php'); ?>
  </header>

  <div>
    <?php
    include('profil_et_publications.php');
    ?>
  </div>
</body>

</html>