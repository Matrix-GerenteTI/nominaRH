<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>
    <link rel="stylesheet" href="assets/vendors/datatables.net-bs5/dataTables.bootstrap5.css">
</head>
<body class="sidebar-<?=$_SESSION['template']?>">
	<!-- MODAL -->
	<div class="modal fade" id="modalQuery" tabindex="-1" aria-labelledby="modalQueryLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modalQueryLabel"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="btn-close"></button>
			</div>
				<div class="modal-body">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12" id="txtQuery">
								

							</div>
						</div>					
					</div>
				</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
			</div>
			</div>
		</div>
	</div>
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
					<div class="card">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<i class="mdi mdi-briefcase"></i> <span>Empleados</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" style="padding:10px">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            Status del Empleado:<br/>
                                            <select id="empladotipo" class="form-control">
                                                <option value="1">ACTIVOS</option>
                                                <option value="2">INACTIVOS (BAJA)</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="row">        
                                        <div class="col-md-4">
                                            <div class="d-grid gap-2" style="padding:1em">
                                                <?php if($_SESSION['permisos'][20]['ver']==1){ ?>
                                                <button type="button" class="btn btn-success" id="descargaListaTrabajadores"><i data-feather="download"></i></button>
                                                <?php } ?> 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
					<br/>
					<div class="card">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<i class="mdi mdi-clock"></i> <span>Horarios</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" style="padding:10px">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-lg-12">
											Status del Empleado:<br/>
                                            <select id="horariotipo" class="form-control">
                                                <option value="1">ACTIVOS</option>
                                                <option value="2">INACTIVOS (BAJA)</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="row">        
                                        <div class="col-md-4">
                                            <div class="d-grid gap-2" style="padding:1em">
                                                <?php if($_SESSION['permisos'][20]['ver']==1){ ?>
                                                <button type="button" class="btn btn-success" id="descargaHorarios"><i data-feather="download"></i></button>
                                                <?php } ?> 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
					<br/>
					<div class="card">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<i class="mdi mdi-calculator"></i> <span>Nóminas</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" style="padding:10px">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-lg-12">
											Nómina generada:<br/>
                                            <select id="repnomina" class="form-control"></select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="row">        
                                        <div class="col-md-4">
                                            <div class="d-grid gap-2" style="padding:1em">
                                                <?php if($_SESSION['permisos'][20]['ver']==1){ ?>
                                                <button type="button" class="btn btn-success" id="descargaNominas"><i data-feather="download"></i></button>
                                                <?php } ?> 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
					<br/>
					<div class="card">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<i class="mdi mdi-calendar-blank"></i> <span>Calendario</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" style="padding:10px">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-lg-12">
											Año:<br/>
                                            <select id="calendarioanio" class="form-control"></select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="row">        
                                        <div class="col-md-4">
                                            <div class="d-grid gap-2" style="padding:1em">
                                                <?php if($_SESSION['permisos'][20]['ver']==1){ ?>
                                                <button type="button" class="btn btn-success" id="descargaCalendario"><i data-feather="download"></i></button>
                                                <?php } ?> 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
					<br/>
					<div class="card">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<i class="mdi mdi-account-multiple"></i> <span>Usuarios y Permisos</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" style="padding:10px">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-lg-12">
											Status del Usuario:<br/>
                                            <select id="usuariostipo" class="form-control">
                                                <option value="1">ACTIVOS</option>
                                                <option value="2">INACTIVOS (BAJA)</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="row">        
                                        <div class="col-md-4">
                                            <div class="d-grid gap-2" style="padding:1em">
                                                <?php if($_SESSION['permisos'][20]['ver']==1){ ?>
                                                <button type="button" class="btn btn-success" id="descargaUsuarios"><i data-feather="download"></i></button>
                                                <?php } ?> 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /widget -->
                </div>
            </div>
		</div>
	</div>

	<?php require_once('partials/js.php') ?>
    <script src="assets/vendors/datatables.net/jquery.dataTables.js"></script>
    <script src="assets/vendors/datatables.net-bs5/dataTables.bootstrap5.js"></script>
	<!-- End custom js for this page -->
    <script src="assets/js/data-table.js"></script>
	<script type="text/javascript" src="js/reportes.js"></script>
</body>
</html>    