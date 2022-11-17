<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>

</head>
<body class="sidebar-<?=$_SESSION['template']?>">
	<div class="main-wrapper">

		<!-- partial:partials/_sidebar.html -->
		<?php require_once('partials/sidebar.php') ?>
    
		<!-- partial -->
	
		<div class="page-wrapper">
					
			<!-- partial:partials/_navbar.html -->
			<?php require_once('partials/navbar.php') ?>
				<!-- partial -->
			<div class="page-content">
				<div class="row">
					<div class="col-12">
						<div class="row">
							<div class="col-12" style="text-align:right; padding:1em">
								<button type="button" class="btn btn-secondary btn-icon" onclick="nuevo()"><i class="mdi mdi-file-outline"></i></button>
								<?php if($_SESSION['permisos'][15]['guardar']==1){ ?>
								<button type="button" class="btn btn-success btn-icon" onclick="guardar()"><i class="mdi mdi-content-save"></i></button>
								<?php } if($_SESSION['permisos'][15]['borrar']==1){ ?>
								<button type="button" class="btn btn-danger btn-icon" onclick="eliminar()"><i class="mdi mdi-delete-forever"></i></button>
								<?php } ?>
							</div>
						</div>
						<div class="card">
							<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
								<i class="icon-edit"></i> <span>Datos de Usuario</span>
							</div>
							<!-- /widget-header -->
							<div class="card-body" style="padding:10px">
								<div class="row">
									<div class="col-md-3">
											Usuario<br/>
											<input type="text" id="usuario" class="form-control" />
									</div>	
									<div class="col-md-3">
											Contrase&ntilde;a<br/>
											<input type="password" class="form-control" id="password1" />
									</div>	
									<div class="col-md-3">
											Confirma contrase&ntilde;a<br/>
											<input type="password" class="form-control" id="password2" onKeyUp="validaPass()" />
									</div>	
									<div class="col-md-3">
											Grupo<br/>
											<select id="grupo" class="form-control"></select>
									</div>	
								</div>
								<div class="row">
									<div class="col-md-7">
											Nombre personal<br/>
											<input type="text" id="nombre" class="form-control" />
									</div>	
									<div class="col-md-5">
											Email<br/>
											<input type="text" id="email" class="form-control" />
									</div>	
								</div>
								<hr/>
								<table class="table table-striped table-bordered">
								<thead>
								<tr>
									<th> Usuario </th>
									<th> Nombre </th>
									<th> Tipo </th>
								</tr>
								</thead>
								<tbody id="tbody">
								</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- /span6 -->
				</div>
			</div>
		</div>
	</div>

	<?php require_once('partials/js.php') ?>
	<!-- End custom js for this page -->
  	<script src="js/usuarios.js"></script>
</body>
</html>    