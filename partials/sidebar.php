<nav class="sidebar">
<div class="sidebar-header">
  <a href="#" class="sidebar-brand">
    RR.HH<span><?=$_SESSION['abreviatura']?></span>
  </a>
  <div class="sidebar-toggler not-active">
    <span></span>
    <span></span>
    <span></span>
  </div>
</div>
<div class="sidebar-body">
  <ul class="nav">
    <?php    
    if(!isset($_SESSION)){
        session_start(); 
    }
    require_once dirname(__DIR__)."/ajax/mysql.php";
    $arrPadre = array();
    $query = "SELECT    ms.*,m.descripcion as padre 
              FROM      rusuariomodulo um 
              INNER JOIN cmodulos ms ON um.idmodulo=ms.id
              INNER JOIN cmodulo m ON ms.idpadre=m.id
              WHERE usuario='".$_SESSION['userid']."' 
              AND um.status=1 
              AND ms.status=1 
              AND m.status=1 
              ORDER BY m.id,ms.id";
    //echo $query;
    $sql = $conexion->query($query);
    while($row = $sql->fetch_assoc()){
        if(!in_array($row['idpadre'],$arrPadre)){
        ?>
            <li class="nav-item nav-category"><?=$row['padre']?></li>
        <?php
            $arrPadre[] = $row['idpadre'];
        }
        ?>
        <li class="nav-item">
            <a href="<?=$row['href']?>.php" class="nav-link">
                <i class="link-icon" data-feather="<?=$row['icon']?>"></i>
                <span class="link-title"><?=$row['title']?></span>
            </a>
        </li>
        <?php
    }
    ?>
    
  </ul>
</div>
</nav>
<nav class="settings-sidebar">
      <div class="sidebar-body">
        <a href="#" class="settings-sidebar-toggler">
          <i data-feather="settings"></i>
        </a>
        <h6 class="text-muted mb-2">Eliga un Tema:</h6>
        <div class="mb-3 pb-3 border-bottom">
          <div class="form-check form-check-inline">
            <input type="radio" class="form-check-input" name="sidebarThemeSettings" id="sidebarLight" value="sidebar-light">
            <label class="form-check-label" for="sidebarLight">
              Claro
            </label>
          </div>
          <div class="form-check form-check-inline">
            <input type="radio" class="form-check-input" name="sidebarThemeSettings" id="sidebarDark" value="sidebar-dark" checked>
            <label class="form-check-label" for="sidebarDark">
              Oscuro
            </label>
          </div>
        </div>
        <div class="theme-wrapper">
          <h6 class="text-muted mb-2">Light Theme:</h6>
          <a class="theme-item active" href="../demo1/dashboard.html">
            <img src="assets/images/screenshots/light.jpg" alt="light theme">
          </a>
          <h6 class="text-muted mb-2">Dark Theme:</h6>
          <a class="theme-item" href="../demo2/dashboard.html">
            <img src="assets/images/screenshots/dark.jpg" alt="light theme">
          </a>
        </div>
      </div>
    </nav>