<?php
if (!isset($_SESSION)) {
  session_start();
}
?>
<html>

<head>
  <meta charset="UTF-8" />
  <title>Gérer mes amis</title>
  <link rel="stylesheet" href="mode-up.css" />
</head>

<body>

  <header><?php include('header.php'); ?></header>
  
  <div><?php include('gestion_ami.php');?></div>

</body>

</html>