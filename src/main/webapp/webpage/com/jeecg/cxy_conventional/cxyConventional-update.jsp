<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>常规模版</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,bootstrap-table,layer,validform,webuploader,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;margin-top: 20px">
 <form id="formobj" action="cxyConventionalController.do?doUpdate" class="form-horizontal validform" role="form"  method="post">
	<input type="hidden" id="btn_sub" class="btn_sub"/>
	<input type="hidden" id="id" name="id" value="${cxyConventionalPage.id}"/>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">名字：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="name" name="name" value='${cxyConventionalPage.name}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入名字"  validType="cxy_conventional,name,id" datatype="*" ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="age" class="col-sm-3 control-label">年龄：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="age" name="age" value='${cxyConventionalPage.age}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入年龄"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="sex" class="col-sm-3 control-label">性别：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<t:dictSelect field="sex" type="radio" extendJson="{class:'i-checks'}"  typeGroupCode="sex"  hasLabel="false"  title="性别" defaultVal="${cxyConventionalPage.sex}"></t:dictSelect>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="phone" class="col-sm-3 control-label">手机：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="phone" name="phone" value='${cxyConventionalPage.phone}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入手机"  validType="cxy_conventional,phone,id" datatype="*" ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="avatar" class="col-sm-3 control-label">头像：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<t:webUploader name="avatar" outJs="true" auto="true" showImgDiv="filediv_avatar" type="image" buttonText='添加图片' displayTxt="false" pathValues="${cxyConventionalPage.avatar}"></t:webUploader>
				<div class="form" id="filediv_avatar"></div>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="resume" class="col-sm-3 control-label">简历：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<t:webUploader name="resume" outJs="true" auto="true" showImgDiv="filediv_resume" pathValues="${cxyConventionalPage.resume}"></t:webUploader>
				<div class="form" id="filediv_resume"></div>
			</div>
		</div>
	</div>
		<div class="form-group">
			<label for="introduction" class="col-sm-3 control-label">自我介绍：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<textarea id="introduction" name="introduction" class="form-control" placeholder="请输入自我介绍" rows="4">${cxyConventionalPage.introduction}</textarea>
				</div>
			</div>
		</div>
</form>
<script type="text/javascript">
	var subDlgIndex = '';
	$(document).ready(function() {
		
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