<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>常规模版</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <t:base type="uploadify"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="cxyConventionalController.do?doAdd" callback="jeecgFormFileCallBack@Override">
					<input id="id" name="id" type="hidden" value="${cxyConventionalPage.id }"/>
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							名字:
						</label>
					</td>
					<td class="value">
					     	 <input id="name" name="name" type="text" maxlength="32" style="width: 150px" class="inputxt"  validType="cxy_conventional,name,id" datatype="*" ignore="checked" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">名字</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							年龄:
						</label>
					</td>
					<td class="value">
					     	 <input id="age" name="age" type="text" maxlength="32" style="width: 150px" class="inputxt"  ignore="ignore" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">年龄</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							性别:
						</label>
					</td>
					<td class="value">
							  <t:dictSelect field="sex" type="radio"  typeGroupCode="sex"  defaultVal="${cxyConventionalPage.sex}" hasLabel="false"  title="性别" ></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">性别</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							手机:
						</label>
					</td>
					<td class="value">
					     	 <input id="phone" name="phone" type="text" maxlength="32" style="width: 150px" class="inputxt"  validType="cxy_conventional,phone,id" datatype="*" ignore="checked" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">手机</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							头像:
						</label>
					</td>
					<td class="value">
		<div class="form jeecgDetail">
			<t:upload name="avatar" id="avatar" queueID="filediv_avatar" outhtml="false" uploader="cgUploadController.do?saveFiles"  extend="pic" buttonText='添加图片'  onUploadStart="avatarOnUploadStart"> </t:upload>
			<div class="form" id="filediv_avatar"></div>
			<script type="text/javascript">
				function avatarOnUploadStart(file){
					var cgFormId=$("input[name='id']").val();
					$('#avatar').uploadify("settings", "formData", {
						'cgFormId':cgFormId,
						'cgFormName':'cxy_conventional',
						'cgFormField':'AVATAR'
					});
				}
			</script>
		</div>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">头像</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							简历:
						</label>
					</td>
					<td class="value">
		<div class="form jeecgDetail">
			<t:upload name="resume" id="resume" queueID="filediv_resume" outhtml="false" uploader="cgUploadController.do?saveFiles"  extend="office" buttonText='添加文件'  onUploadStart="resumeOnUploadStart"> </t:upload>
			<div class="form" id="filediv_resume"></div>
			<script type="text/javascript">
				function resumeOnUploadStart(file){
					var cgFormId=$("input[name='id']").val();
					$('#resume').uploadify("settings", "formData", {
						'cgFormId':cgFormId,
						'cgFormName':'cxy_conventional',
						'cgFormField':'RESUME'
					});
				}
			</script>
		</div>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">简历</label>
						</td>
				</tr>
				
				
				<tr>
					<td align="right">
						<label class="Validform_label">
							自我介绍:
						</label>
					</td>
					<td class="value" >
						  	 <textarea style="height:auto;width:95%" class="inputxt" rows="6" id="introduction" name="introduction"  ignore="ignore" ></textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">自我介绍</label>
						</td>
					</tr>
			</table>
		</t:formvalid>
 </body>
	  	<script type="text/javascript">
	  		function jeecgFormFileCallBack(data){
	  			if (data.success == true) {
					uploadFile(data);
				} else {
					if (data.responseText == '' || data.responseText == undefined) {
						$.messager.alert('错误', data.msg);
						$.Hidemsg();
					} else {
						try {
							var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));
							$.messager.alert('错误', emsg);
							$.Hidemsg();
						} catch(ex) {
							$.messager.alert('错误', data.responseText + '');
						}
					}
					return false;
				}
				if (!neibuClickFlag) {
					var win = frameElement.api.opener;
					win.reloadTable();
				}
	  		}
	  		function upload() {
					$('#avatar').uploadify('upload', '*');	
					$('#resume').uploadify('upload', '*');	
			}
			
			var neibuClickFlag = false;
			function neibuClick() {
				neibuClickFlag = true; 
				$('#btn_sub').trigger('click');
			}
			function cancel() {
					$('#avatar').uploadify('cancel', '*');
					$('#resume').uploadify('cancel', '*');
			}
			function uploadFile(data){
				if(!$("input[name='id']").val()){
					if(data.obj!=null && data.obj!='undefined'){
						$("input[name='id']").val(data.obj.id);
					}
				}
				if($(".uploadify-queue-item").length>0){
					upload();
				}else{
					if (neibuClickFlag){
						alert(data.msg);
						neibuClickFlag = false;
					}else {
						var win = frameElement.api.opener;
						win.reloadTable();
						win.tip(data.msg);
						frameElement.api.close();
					}
				}
			}
	  	</script>
