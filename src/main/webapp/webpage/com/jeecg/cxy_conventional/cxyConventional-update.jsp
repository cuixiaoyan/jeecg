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
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="cxyConventionalController.do?doUpdate" callback="jeecgFormFileCallBack@Override">
					<input id="id" name="id" type="hidden" value="${cxyConventionalPage.id }"/>
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right">
							<label class="Validform_label">
								名字:
							</label>
						</td>
						<td class="value">
						    <input id="name" name="name" type="text" maxlength="32" style="width: 150px" class="inputxt"  validType="cxy_conventional,name,id" datatype="*" ignore="checked"  value='${cxyConventionalPage.name}'/>
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
						    <input id="age" name="age" type="text" maxlength="32" style="width: 150px" class="inputxt"  ignore="ignore"  value='${cxyConventionalPage.age}'/>
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
									<t:dictSelect field="sex" type="radio"  typeGroupCode="sex"   defaultVal="${cxyConventionalPage.sex}" hasLabel="false"  title="性别" ></t:dictSelect>     
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
						    <input id="phone" name="phone" type="text" maxlength="32" style="width: 150px" class="inputxt"  validType="cxy_conventional,phone,id" datatype="*" ignore="checked"  value='${cxyConventionalPage.phone}'/>
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
		<table id="avatar_fileTable"></table>
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
		<table id="resume_fileTable"></table>
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
						  	 	<textarea id="introduction" style="height:auto;width:95%;" class="inputxt" rows="6" name="introduction"  ignore="ignore" >${cxyConventionalPage.introduction}</textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">自我介绍</label>
						</td>
					</tr>
			</table>
		</t:formvalid>
 </body>
	  	<script type="text/javascript">
		  	//加载 已存在的 文件
		  	$(function(){
	  			var cgFormId=$("input[name='id']").val();
		  		$.ajax({
		  		   type: "post",
		  		   url: "cxyConventionalController.do?getFiles&id=" +  cgFormId,
		  		   success: function(data){
		  			 var arrayFileObj = jQuery.parseJSON(data).obj;
		  			 
		  			$.each(arrayFileObj,function(n,file){
		  				var fieldName = file.field.toLowerCase();
		  				var table = $("#"+fieldName+"_fileTable");
		  				var tr = $("<tr style=\"height:34px;\"></tr>");
		  				var title = file.title;
		  				if(title.length > 15){
		  					title = title.substring(0,12) + "...";
		  				}
		  				var td_title = $("<td>" + title + "</td>");
		  		  		var td_download = $("<td><a style=\"margin-left:10px;\" href=\"commonController.do?viewFile&fileid=" + file.fileKey + "&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity\" title=\"下载\">下载</a></td>")
		  		  		var td_view = $("<td><a style=\"margin-left:10px;\" href=\"javascript:void(0);\" onclick=\"openwindow('预览','commonController.do?openViewFile&fileid=" + file.fileKey + "&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity','fList',700,500)\">预览</a></td>");
		  		  		tr.appendTo(table);
		  		  		td_title.appendTo(tr);
		  		  		td_download.appendTo(tr);
		  		  		td_view.appendTo(tr);
		  		  		if(location.href.indexOf("load=detail")==-1){
			  		  		var td_del = $("<td><a style=\"margin-left:10px;\" href=\"javascript:void(0)\" class=\"jeecgDetail\" onclick=\"del('cgUploadController.do?delFile&id=" + file.fileKey + "',this)\">删除</a></td>");
			  		  		td_del.appendTo(tr);
		  		  		}
		  			 });
		  		   }
		  		});
		  	});
		  	
		  	/**
		 	 * 删除图片数据资源
		 	 */
		  	function del(url,obj){
		  		var content = "请问是否要删除该资源";
		  		var navigatorName = "Microsoft Internet Explorer"; 
		  		if( navigator.appName == navigatorName ){ 
		  			$.dialog.confirm(content, function(){
		  				submit(url,obj);
		  			}, function(){
		  			});
		  		}else{
		  			layer.open({
						title:"提示",
						content:content,
						icon:7,
						yes:function(index){
							submit(url,obj);
						},
						btn:['确定','取消'],
						btn2:function(index){
							layer.close(index);
						}
					});
		  		}
		  	}
		  	
		  	function submit(url,obj){
		  		$.ajax({
		  			async : false,
		  			cache : false,
		  			type : 'POST',
		  			url : url,// 请求的action路径
		  			error : function() {// 请求失败处理函数
		  			},
		  			success : function(data) {
		  				var d = $.parseJSON(data);
		  				if (d.success) {
		  					var msg = d.msg;
		  					tip(msg);
		  					obj.parentNode.parentNode.parentNode.deleteRow(obj.parentNode.parentNode);
		  				} else {
		  					tip(d.msg);
		  				}
		  			}
		  		});
		  	}
		  	
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
