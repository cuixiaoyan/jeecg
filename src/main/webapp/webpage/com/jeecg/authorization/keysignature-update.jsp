<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>密钥签名授权</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,bootstrap-table,layer,validform,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="keysignatureController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${keysignature.id}"/>
	<div class="form-group">
		<label for="userName" class="col-sm-3 control-label">用户名称：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="userName" name="userName" value='${keysignature.userName}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入用户名称"  datatype="*" ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="byTime" class="col-sm-3 control-label">截止时间：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
      		    <input id="byTime" name="byTime" type="text" class="form-control input-sm laydate-date" placeholder="请输入截止时间"  datatype="*" ignore="checked"  value="<fmt:formatDate pattern='yyyy-MM-dd' type='date' value='${keysignature.byTime}'/>" />
                <span class="input-group-addon" ><span class="glyphicon glyphicon-calendar"></span></span>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="authorizationModule" class="col-sm-3 control-label">授权模块：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="authorizationModule" name="authorizationModule" value='${keysignature.authorizationModule}' type="text" maxlength="320" class="form-control input-sm" placeholder="请输入授权模块"  datatype="*" ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="clear" class="col-sm-3 control-label">明文：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="clear" name="clear" value='${keysignature.clear}' type="text" maxlength="320" class="form-control input-sm" placeholder="请输入明文"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="cipher" class="col-sm-3 control-label">密文：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="cipher" name="cipher" value='${keysignature.cipher}' type="text" maxlength="320" class="form-control input-sm" placeholder="请输入密文"  ignore="ignore" />
			</div>
		</div>
	</div>
					<div class="form-group">
						<label for="publicKey" class="col-sm-3 control-label">公钥：</label>
						<div class="col-sm-7">
			          <div class="input-group" style="width:100%">
						  	 	<textarea name="publicKey" class="form-control input-sm" rows="6"  ignore="ignore" >${keysignature.publicKey}</textarea>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">公钥</label>
			          </div>
						</div>
					<div class="form-group">
						<label for="privateKey" class="col-sm-3 control-label">私钥：</label>
						<div class="col-sm-7">
			          <div class="input-group" style="width:100%">
						  	 	<textarea name="privateKey" class="form-control input-sm" rows="6"  ignore="ignore" >${keysignature.privateKey}</textarea>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">私钥</label>
			          </div>
						</div>
	</form>
	</div>
 </div>
<script type="text/javascript">
var subDlgIndex = '';
$(document).ready(function() {
	$(".laydate-datetime").each(function(){
		var _this = this;
		laydate.render({
		  elem: _this,
		  format: 'yyyy-MM-dd HH:mm:ss',
		  type: 'datetime',
		  ready: function(date){
		  	 $(_this).val(DateJsonFormat(date,this.format));
		  }
		});
	});
	$(".laydate-date").each(function(){
		var _this = this;
		laydate.render({
		  elem: _this,
		  format: 'yyyy-MM-dd',
		  ready: function(date){
		  	 $(_this).val(DateJsonFormat(date,this.format));
		  }
		});
	});
	//单选框/多选框初始化
	$('.i-checks').iCheck({
		labelHover : false,
		cursor : true,
		checkboxClass : 'icheckbox_square-green',
		radioClass : 'iradio_square-green',
		increaseArea : '20%'
	});
	
	//表单提交
	$("#formobj").Validform({
		tiptype:function(msg,o,cssctl){
			if(o.type==3){
				validationMessage(o.obj,msg);
			}else{
				removeMessage(o.obj);
			}
		},
		btnSubmit : "#btn_sub",
		btnReset : "#btn_reset",
		ajaxPost : true,
		beforeSubmit : function(curform) {
		},
		usePlugin : {
			passwordstrength : {
				minLen : 6,
				maxLen : 18,
				trigger : function(obj, error) {
					if (error) {
						obj.parent().next().find(".Validform_checktip").show();
						obj.find(".passwordStrength").hide();
					} else {
						$(".passwordStrength").show();
						obj.parent().next().find(".Validform_checktip").hide();
					}
				}
			}
		},
		callback : function(data) {
			var win = frameElement.api.opener;
			if (data.success == true) {
				frameElement.api.close();
			    win.reloadTable();
			    win.tip(data.msg);
			} else {
			    if (data.responseText == '' || data.responseText == undefined) {
			        $.messager.alert('错误', data.msg);
			        $.Hidemsg();
			    } else {
			        try {
			            var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));
			            $.messager.alert('错误', emsg);
			            $.Hidemsg();
			        } catch (ex) {
			            $.messager.alert('错误', data.responseText + "");
			            $.Hidemsg();
			        }
			    }
			    return false;
			}
		}
	});
});
</script>
</body>
</html>