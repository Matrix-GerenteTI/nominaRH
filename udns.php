<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>

	<div class="main-wrapper">

		<!-- partial:partials/_sidebar.html -->
		<?php require_once('partials/sidebar.php') ?>
</head>
<body class="sidebar-<?=$_SESSION['template']?>">
		<!-- partial -->
	
		<div class="page-wrapper">
					
			<!-- partial:partials/_navbar.html -->
			<?php require_once('partials/navbar.php') ?>
			<!-- partial -->
		<div class="page-content">
			<div class="row">
				<div class="col-12 col-xl-7">
					<div class="card">
					<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
						<i class="icon-home"></i> <span>Unidades de Negocio</span>
					</div>
					<!-- /widget-header -->
					<div class="card-body" style="padding:10px">
											
							<div class="row">
								<div class="col-6 col-xl-6">
									Nombre<br/>
									<input type="text" id="udescripcion" class="form-control"/>
									<input type="text" id="uid" style="display:none"/>
								</div>
								<div class="col-6 col-xl-6">
									Zona<br/>
									<select id="uzona" class="form-control">
									</select>
								</div>
							</div>
							<div class="row">
								<div class="col-6 col-xl-3">
									Latitud<br/>
									<input type="text" id="ulatitud" class="form-control"/>
								</div>
								<div class="col-6 col-xl-3">
									Longitud<br/>
									<input type="text" id="ulongitud" class="form-control"/>
								</div>
								<div class="col-6 col-xl-3">
									Rango en metros<br/>
									<input type="text" id="urango" class="form-control"/>
								</div>
								<div class="col-6 col-xl-3">
									&nbsp;<br/>
									<button type="button" class="btn btn-light btn-icon" onclick="nuevoUDN()"><i class="mdi mdi-file-outline"></i></button>
									<?php if($_SESSION['permisos'][3]['guardar']==1){ ?>
									<button type="button" class="btn btn-success btn-icon" onclick="guardarUDN()"><i class="mdi mdi-content-save"></i></button>
									<?php }if($_SESSION['permisos'][3]['borrar']==1){ ?>
									<button type="button" class="btn btn-danger btn-icon" onclick="eliminar('u','sucursal')"><i class="mdi mdi-minus"></i></button>
									<?php } ?>
								</div>
							</div>
							<hr/>
							<div class="table-responsive pt-3" style="max-height:600px">
								<table class="table ttable-bordered">
									<thead>
									<tr>
										<th width="10px"><input type="checkbox" id="chkall" name="chkall"></th>
										<th> Zona </th>
										<th> UDN </th>
										<th> Lat </th>
										<th> Long </th>
										<th> Rango </th>
										<th>  </th>
									</tr>
									</thead>
									<tbody id="tbodyUdns">
									
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="col-12 col-xl-5">
				<div class="card">
					<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
						<i class="icon-home"></i> <span>Zonas</span>
					</div>
					<!-- /widget-header -->
					<div class="card-body" style="padding:10px">
											
							<div class="row">
								<div class="col-6 col-lg-8">
									Zona<br/>
									<input type="text" id="zdescripcion" class="form-control"/>
									<input type="text" id="zid" style="display:none"/>
								</div>
								<div class="col-6 col-lg-4">
									&nbsp;<br/>
									<button type="button" class="btn btn-light btn-icon" onclick="nuevoZona()"><i class="mdi mdi-file-outline"></i></button>
									<?php if($_SESSION['permisos'][3]['guardar']==1){ ?>
									<button type="button" class="btn btn-success btn-icon" onclick="guardarZona()"><i class="mdi mdi-content-save"></i></button>
									<?php }if($_SESSION['permisos'][3]['borrar']==1){ ?>
									<button type="button" class="btn btn-danger btn-icon" onclick="eliminar('z','zona')"><i class="mdi mdi-minus"></i></button>
									<?php } ?>
								</div>
							</div>
							<hr/>
							<div class="table-responsive pt-3">
								<table class="table ttable-bordered">
									<thead>
									<tr>
										<th width="10px"><input type="checkbox" id="chkall" name="chkall"></th>
										<th> Zona </th>
										<th>  </th>
									</tr>
									</thead>
									<tbody id="tbodyZonas">
									
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<?php require_once('partials/js.php') ?>
	<!-- End custom js for this page -->
	<script type="text/javascript" src="js/udns.js"></script>
</body>
</html>    