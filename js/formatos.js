$(document).ready(function(e) {
    cmbFormatos();
    tinymce.init({
        selector: '#editor',
        height: 400,
        default_text_color: 'red',
        plugins: [
        'advlist autolink lists link image charmap print preview hr anchor pagebreak',
        'searchreplace wordcount visualblocks visualchars code fullscreen',
        ],
        toolbar1: 'undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image',
        toolbar2: 'print preview media | forecolor backcolor emoticons | codesample help',
        image_advtab: true,
        templates: [{
            title: 'Test template 1',
            content: 'Test 1'
        },
        {
            title: 'Test template 2',
            content: 'Test 2'
        }
        ],
        content_css: []
    });

    $('#register').on('submit', function(ed) {
        tinymce.triggerSave();
        ed.preventDefault();
        var TinyAjaxPost = $('#register').serialize();
        $.post('ajax/ajaxformatos.php?op=guardaFormato', TinyAjaxPost, function(resp) {
            console.log(resp);
            //alert(resp);
            if(resp>0){
                //alert("El registro se guardo exitosamente!");
                okMsg('Listo!',"Se han guardados los cambios exitosamente!");
                limpiarFormato();
            }else
                errorMsg('Ups!',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
        });
    });

    $("#formato").change(function(){
        let formato = $(this).val();
        
    })
});

function agregaCampo(campo){
    tinymce.activeEditor.execCommand('mceInsertContent', false, '{{'+campo+'}}');
}

function limpiarFormato(){
    cmbFormatos();
    $("#badges").html('')
    tinyMCE.get('editor').setContent('');
}


function cargar(){
    let formato = $("#formato").val();    
    $.post("ajax/ajaxformatos.php?op=cargaFormato", "formato="+formato, function(resp){
        console.log(resp)
        var row = eval('('+resp+')');
        tinyMCE.get('editor').setContent(row[0].texto);
        $("#badges").html('')
        $.post("ajax/ajaxformatos.php?op=getBadgets", "formato="+formato, function(resp2){
            console.log(resp2)
            var echo = '';
            var row2 = eval('('+resp2+')');
            for(i2 in row2){
                echo+= '<a href="javascript: agregaCampo(\''+row2[i2].campo+'\')" class="badge bg-'+row2[i2].color+'">'+row2[i2].campo+'</a>&nbsp;';
            }
            $("#badges").html(echo);
        });
    });
}

function guardarFormato(){
    var formato = $("#formato").val();
    var textot = tinyMCE.get('editor').getContent();
    //console.log(textot)
    var texto = escape(textot);    
    //console.log(texto)
    if(formato.trim()!=""){
        var params = "formato=" + formato;
        params+= "&texto=" + texto;
        $.post("ajax/ajaxformatos.php?op=guardaFormato", params, function(resp){
            console.log(resp);
            //alert(resp);
            if(resp>0){
                //alert("El registro se guardo exitosamente!");
                okMsg('Listo!',"Se han guardados los cambios exitosamente!");
                limpiarFormato();
            }else
                errorMsg('Ups!',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
        });
    }
}



function cmbFormatos(){
    $.post("ajax/ajaxformatos.php?op=cmbFormatos", "", function(resp){
        //alert(resp);
        $("#formato").html(resp);
    });
}