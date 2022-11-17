<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
<?php require_once('partials/header.php') ?>
</head>
<body class="sidebar-<?=$_SESSION['template']?>">
    <!-- Modal BUSLIST -->

<div class="modal fade" id="busquedaEmpleados" tabindex="-1" aria-labelledby="busquedaEmpleadosLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="busquedaEmpleadosLabel">B&uacute;squeda de Empleado</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="btn-close"></button>
      </div>
      <div class="modal-body">
	  	<div class="row">
			<div class="col-4">
				<div class="form-group">
                    Departamento<br/>
                    <select id="busdepartamento" class="form-control"><option value='%'></option></select>
				</div>
			</div>
			<div class="col-5">
				<div class="form-group">
                    Nombre<br/>
					<input type="text" id="busnombre" class="form-control" />
				</div>
			</div>
			<div class="col-3">
                <br/>
				<button class="btn btn-secondary btn-large" onclick="buslista()"><i class="mdi mdi-account-search"></i></button>
			</div>
		</div>
		<hr/>
		<div class="row">
			<div class="col-12">
				<table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th> Departamento </th>
							<th> Nombre </th>
						</tr>
					</thead>
					<tbody id="bustbody">
					</tbody>
				</table>
			</div>
		</div>		
      </div>
      <!-- <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div> -->
    </div>
  </div>
</div>
<!-- MODAL BUSLISTA -->
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
                        <div class="col-6" style="text-align:left; padding:1em">
                            <button type="button" class="btn btn-dark btn-icon" onclick="buscar()"><i data-feather="zoom-in"></i></button>
                        </div>
                    </div>	
                    <div class="card">
						<div class="card-body" style="padding:10px">
                            <div class="row">
                                <div class="col-lg-3">
                                        NIP<br/>
                                        <input type="text" id="inip" class="form-control" readonly />
                                </div>
                                <div class="col-lg-3">
                                        Nombre<br/>
                                        <input type="text" id="inombre" class="form-control" readonly />
                                </div>
                                <div class="col-lg-3">
                                        Departamento<br/>
                                        <input type="text" id="idepartamento" class="form-control" readonly />
                                </div>
                                <div class="col-lg-3">
                                        Puesto<br/>
                                        <input type="text" id="ipuesto" class="form-control" readonly />
                                </div>
                            </div>
                            <hr/>
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="percepciones-tab" data-bs-toggle="tab" data-bs-target="#percepciones" type="button" role="tab" aria-controls="percepciones" aria-selected="true">Percepciones</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="deducciones-tab" data-bs-toggle="tab" data-bs-target="#deducciones" type="button" role="tab" aria-controls="deducciones" aria-selected="false">Deducciones</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="otrospagos-tab" data-bs-toggle="tab" data-bs-target="#otrospagos" type="button" role="tab" aria-controls="otrospagos" aria-selected="false">Otros Pagos</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="Incapacidades-tab" data-bs-toggle="tab" data-bs-target="#Incapacidades" type="button" role="tab" aria-controls="Incapacidades" aria-selected="false">Incapacidades</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="jubilacion-tab" data-bs-toggle="tab" data-bs-target="#jubilacion" type="button" role="tab" aria-controls="jubilacion" aria-selected="false">Jubilaci&oacute;n/Pensi&oacute;n/Retiro</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="separacion-tab" data-bs-toggle="tab" data-bs-target="#separacion" type="button" role="tab" aria-controls="separacion" aria-selected="false">Separaci&oacute;n/Indemnizaci&oacute;n</button>
                                </li>
                            </ul>
                            <div class="tab-content" id="myTabContent" style="padding:1em; border: #DDD 1px solid !important">
                                <div class="tab-pane fade show active" id="percepciones" role="tabpanel" aria-labelledby="percepciones-tab">
                                    <div class="panel-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">Percepci&oacute;n</div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-lg-4">
                                                            Tipo<br/>
                                                            <select id="percepciones_tipopercepcion" class="form-control"></select>
                                                    </div>
                                                    <div class="col-lg-4">
                                                            Importe Gravado<br/>
                                                            <input type="number" id="percepciones_gravado" class="form-control" />                                                        
                                                    </div>
                                                    <div class="col-lg-4">  
                                                            Importe exento<br/>
                                                            <input type="number" id="percepciones_excento" class="form-control" />                                                      
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-4">
                                                            (Acciones o T&iacute;tulos) Valor del mercado<br/>
                                                            <input type="number" id="percepciones_valormercado" class="form-control" />
                                                    </div>
                                                    <div class="col-lg-4">
                                                            (Acciones o T&iacute;tulos) Precio al otorgarse<br/>
                                                            <input type="number" id="percepciones_preciootorgarse" class="form-control" />                                                      
                                                    </div>
                                                    <div class="col-lg-2">
                                                        <br/>
                                                        <?php if($_SESSION['permisos'][8]['guardar']==1){ ?>
                                                        <button type="button" class="btn btn-success btn-icon" onclick="add('percepciones')"><i data-feather="plus"></i></button> 
                                                        <?php } ?>                                                                                           
                                                    </div>
                                                </div>
                                                <hr/>
                                                <table class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th> Tipo de percepci&oacute;n </th>
                                                        <th> Importe Gravado </th>
                                                        <th> Importe Exento </th>
                                                        <th> Valor del Mercado </th>
                                                        <th> Precio a Otorgarse </th>
                                                        <th class="td-actions"> </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbodypercepciones">
                                                </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <div class="panel panel-default">
                                            <div class="panel-heading">Horas extra</div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-lg-2">
                                                            D&iacute;as<br/>
                                                            <input type="number" id="horasextra_dias" class="form-control" />
                                                    </div>
                                                    <div class="col-lg-3">
                                                            Tipo de horas<br/>
                                                            <select id="horasextra_tipohoras" class="form-control">
                                                            </select>                                                    
                                                    </div>
                                                    <div class="col-lg-2">
                                                            Horas extra<br/>
                                                            <input type="number" id="horasextra_horasextra" class="form-control" />
                                                    </div>
                                                    <div class="col-lg-3">
                                                            Importe pagado<br/>
                                                            <input type="number" id="horasextra_importepagado" class="form-control"/>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-4 col-lg-3">
                                                            Importe Gravado<br/>
                                                            <input type="number" id="horasextra_gravado" class="form-control" />
                                                    </div>
                                                    <div class="col-md-4 col-lg-3">
                                                            Importe Exento<br/>
                                                            <input type="number" id="horasextra_exento" class="form-control" />                                                     
                                                    </div>
                                                    <div class="col-md-4 col-lg-6">
                                                        <br/>
                                                        <?php if($_SESSION['permisos'][8]['guardar']==1){ ?>
                                                        <button type="button" class="btn btn-success btn-icon" onclick="add('horasextra')"><i data-feather="plus"></i></button>
                                                        <?php } ?>                                          
                                                    </div>
                                                </div>
                                                <hr/>
                                                <table class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th> Tipo de Horas </th>
                                                        <th> D&iacute;as </th>
                                                        <th> Horas Extra </th>
                                                        <th> Importe Pagado </th>
                                                        <th> Importe Gravado </th>
                                                        <th> Importe Exento </th>
                                                        <th class="td-actions"> </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbodyhorasextra">
                                                </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        </div>
                                </div>
                                <div class="tab-pane fade" id="deducciones" role="tabpanel" aria-labelledby="deducciones-tab">
                                    <input type="hidden" id="trabajadorId">
                                    <div class="row">
                                        <div class="col-lg-3">
                                                Tipo<br/>
                                                <select v-model="tipoDeduccion" id="deducciones_tipodeduccion" class="form-control">
                                                    <option value="-1">Seleeciona una opción</option>
                                                </select>                                            
                                        </div>
                                        <div class="col-lg-3">  
                                                Fecha de cargo<br>
                                                <flat-pickr v-model="fechaCargo" class="form-control"></flat-pickr>                                           
                                        </div>
                                        <div class="col-lg-3">  
                                                Importe<br/>
                                                <input type="number" v-model ='importe' class="form-control"  />                                          
                                        </div>
                                        <div class="col-lg-3"> 
                                            <br/>
                                            <?php if($_SESSION['permisos'][8]['guardar']==1){ ?>
                                            <button type="button" class="btn btn-success btn-icon" @click.prevent="addDeduccion"><i data-feather="plus"></i></button>
                                            <?php } ?>                                          
                                            <input type="checkbox" style="display:none"  v-model="deduccionAuto" name="" @click="visibleProgramar">                                            
                                        </div>
                                    </div>
                                    <div class="row" v-show="deduccionAuto">
                                        <div class="col-lg-4">
                                            Tipo Programación<br>
                                            <select class="form-control" v-model="tipoProgramacion" >
                                                <option value="1">Quincenal</option>
                                                <option value="2">Mensual</option>
                                                <option value="3">Anual</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-4" v-show="deduccionAuto">
                                            Fecha vencimiento<br>
                                            <flat-pickr v-model="vencimientoCargo" class="input" class="form-control"></flat-pickr>
                                        </div>
                                    </div>
                                    <hr/>
                                    <table class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th> Tipo de deducci&oacute;n </th>
                                            <th> Importe </th>
                                            <th>Fecha de Cargo</th>
                                            <th>Frecuencia</th>
                                            <th>Vigencia</th>
                                            <th class="td-actions"> </th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodydeducciones">
                                    </tbody>
                                    </table>
                                </div>
                                <div class="tab-pane fade" id="otrospagos" role="tabpanel" aria-labelledby="otrospagos-tab">
                                    <div class="panel-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">Otro Pago</div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-lg-8">
                                                        Tipo<br/>
                                                        <select id="otrospagos_tipootropago" class="form-control"></select>                                        
                                                    </div>
                                                    <div class="col-lg-4">  
                                                            Importe<br/>
                                                            <input type="number" id="otrospagos_importe" class="form-control" />                                         
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-6 col-lg-4">
                                                        (Subsidio al Empleo) Subsidio causaro<br/>
                                                        <input type="number" id="otrospagos_subsidiocausado" class="form-control" />                                      
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-3">
                                                            (Compensaci&oacute;n Saldo a Favor) A&ntilde;o<br/>
                                                            <input type="number" id="otrospagos_anio" class="form-control" />                                     
                                                    </div>
                                                    <div class="col-lg-3">  
                                                            (Compensaci&oacute;n Saldo a Favor) Saldo a favor<br/>
                                                            <input type="number" id="otrospagos_saldofavor" class="form-control" />                                       
                                                    </div>
                                                    <div class="col-lg-4">  
                                                            (Compensaci&oacute;n Saldo a Favor) Remanente saldo a favor<br/>
                                                            <input type="number" id="otrospagos_remanente" class="form-control"/>                                      
                                                    </div>
                                                    <div class="col-lg-2"> 
                                                        <br/>
                                                        <?php if($_SESSION['permisos'][8]['guardar']==1){ ?>
                                                        <button type="button" class="btn btn-success btn-icon" onclick="add('otrospagos')"><i data-feather="plus"></i></button>  
                                                        <?php } ?>                                                                                  
                                                    </div>
                                                </div>
                                                <hr/>
                                                <table class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th> Tipo de Otro Pago </th>
                                                        <th> Importe </th>
                                                        <th> Subsidio </th>
                                                        <th> Saldo a Favor </th>
                                                        <th> A&ntilde;o </th>
                                                        <th> Remanente </th>
                                                        <th class="td-actions"> </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbodyotrospagos">
                                                </tbody>
                                                </table>
                                            </div>
                                        </div>


                                        </div>
                                </div>
                                <div class="tab-pane fade" id="Incapacidades" role="tabpanel" aria-labelledby="Incapacidades-tab">
                                    <div class="row">
                                        <div class="col-lg-3">
                                                Tipo<br/>
                                                <select id="incapacidades_tipoincapacidad" class="form-control">
                                                </select>                                   
                                        </div>
                                        <div class="col-lg-3">  
                                                D&iacute;as<br/>
                                                <input type="number" id="incapacidades_dias" class="form-control"  />                                      
                                        </div>
                                        <div class="col-lg-4">  
                                                Importe<br/>
                                                <input type="number" id="incapacidades_importe" class="form-control"  />                                    
                                        </div>
                                        <div class="col-lg-2"> 
                                            <br/>
                                            <?php if($_SESSION['permisos'][8]['guardar']==1){ ?>
                                            <button type="button" class="btn btn-success btn-icon" onclick="add('incapacidades')"><i data-feather="plus"></i></button> 
                                            <?php } ?>                                                                                   
                                        </div>
                                    </div>
                                    <hr/>
                                    <table class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th> Tipo de incapacidad </th>
                                            <th> D&iacute;as </th>
                                            <th> Importe </th>
                                            <th class="td-actions"> </th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyincapacidades">
                                    </tbody>
                                    </table>
                                </div>
                                <div class="tab-pane fade" id="jubilacion" role="tabpanel" aria-labelledby="jubilacion-tab">                                    
                                    <div class="row">
                                        <div class="col-md-4 col-lg-4">
                                                Tipo<br/>
                                                <select id="jubilaciones_tipopercepcion" class="form-control">
                                                </select>                               
                                        </div>
                                        <div class="col-md-4 col-lg-4">  
                                                Importe Exento<br/>
                                                <input type="number" id="jubilaciones_gravado" class="form-control" />                                  
                                        </div>
                                        <div class="col-md-4 col-lg-4">  
                                                Importe Gravado<br/>
                                                <input type="number" id="jubilaciones_exento" class="form-control" />                                
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4 col-lg-2">
                                                Total en una exhibici&oacute;n<br/>
                                                <input type="number" id="jubilaciones_unaexhibicion" class="form-control" />                                
                                        </div>
                                        <div class="col-md-4 col-lg-2">  
                                                Total en parcialidades<br/>
                                                <input type="number" id="jubilaciones_parcialidades" class="form-control" />                                     
                                        </div>
                                        <div class="col-md-4 col-lg-2">  
                                                Monto diario<br/>
                                                <input type="number" id="jubilaciones_diario" class="form-control" />                                 
                                        </div>
                                        <div class="col-md-4 col-lg-2">  
                                                Ingreso acumulable<br/>
                                                <input type="number" id="jubilaciones_acumulable" class="form-control" />                                
                                        </div>
                                        <div class="col-md-4 col-lg-2">  
                                                Ingreso no acumulable<br/>
                                                <input type="number" id="jubilaciones_noacumulable" class="form-control" />                                
                                        </div>
                                        <div class="col-md-4 col-lg-2"> 
                                            <br/>
                                            <?php if($_SESSION['permisos'][8]['guardar']==1){ ?>
                                            <button type="button" class="btn btn-success btn-icon" onclick="add('jubilaciones')"><i data-feather="plus"></i></button> 
                                            <?php } ?>                                                                                   
                                        </div>
                                    </div>
                                    <hr/>
                                    <table class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th> Tipo </th>
                                            <th> Una Exhibici&oacute;n </th>
                                            <th> Parcialidades </th>
                                            <th> Monto Diario </th>
                                            <th> Acumulable </th>
                                            <th> No Acumulable </th>
                                            <th> Gravado </th>
                                            <th> Exento </th>
                                            <th class="td-actions"> </th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyjubilaciones">
                                    </tbody>
                                    </table>
                                </div>
                                <div class="tab-pane fade" id="separacion" role="tabpanel" aria-labelledby="separacion-tab">                                   
                                    <div class="row">
                                        <div class="col-md-4 col-lg-4">
                                                Tipo<br/>
                                                <select id="separaciones_tipopercepcion" class="form-control">
                                                </select>                         
                                        </div>
                                        <div class="col-md-4 col-lg-4"> 
                                                Importe Exento<br/>
                                                <input type="number" id="separaciones_gravado" class="form-control" />                                
                                        </div>
                                        <div class="col-md-4 col-lg-4">  
                                                Importe Gravado<br/>
                                                <input type="number" id="separaciones_exento" class="form-control" />                               
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4 col-lg-2"> 
                                                Total pagado<br/>
                                                <input type="number" id="separaciones_pagado" class="form-control"/>                             
                                        </div>
                                        <div class="col-md-4 col-lg-2"> 
                                                A&ntilde;os de servicio<br/>
                                                <input type="number" id="separaciones_anios" class="form-control" />                                     
                                        </div>
                                        <div class="col-md-4 col-lg-2">
                                                &Uacute;ltimo sueldo mensual ordinario<br/>
                                                <input type="number" id="separaciones_sueldo" class="form-control" />                              
                                        </div>
                                        <div class="col-md-4 col-lg-2"> 
                                                Ingreso acumulable<br/>
                                                <input type="number" id="separaciones_acumulable" class="form-control" />                               
                                        </div>
                                        <div class="col-md-4 col-lg-2"> 
                                                Ingreso no acumulable<br/>
                                                <input type="number" id="separaciones_noacumulable" class="form-control" />                                
                                        </div>
                                        <div class="col-md-4 col-lg-2"> 
                                            <br/>
                                            <?php if($_SESSION['permisos'][8]['guardar']==1){ ?>
                                            <button type="button" class="btn btn-success btn-icon" onclick="add('separaciones')"><i data-feather="plus"></i></button>
                                            <?php } ?>                                          
                                        </div>
                                    </div>
                                    <hr/>
                                    <table class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th> Tipo </th>
                                            <th> Pagado </th>
                                            <th> A&ntilde;os Servicio </th>
                                            <th> &Uacute;ltimo Sueldo </th>
                                            <th> Acumulable </th>
                                            <th> No Acumulable </th>
                                            <th> Gravado </th>
                                            <th> Exento </th>
                                            <th class="td-actions"> </th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyseparaciones">
                                    </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
                <!-- /span6 -->
            </div>
            <!-- /row --> 
		</div>
	</div>
    <?php require_once('partials/js.php') ?>


    <script src="js/vue.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.js"></script>


    <link href="https://unpkg.com/flatpickr@4/dist/flatpickr.min.css" rel="stylesheet">
    <script src="https://unpkg.com/flatpickr@4/dist/flatpickr.min.js"></script>
    <script src="https://unpkg.com/vue-flatpickr-component@7"></script>

	<script>
		// Vue.component('date-picker', VueBootstrapDatetimePicker.default);

 			Vue.component('flat-pickr', VueFlatpickr);
	</script>
	<!-- End custom js for this page -->
	<script type="text/javascript" src="js/incidencias.js"></script>
</body>
</html>  