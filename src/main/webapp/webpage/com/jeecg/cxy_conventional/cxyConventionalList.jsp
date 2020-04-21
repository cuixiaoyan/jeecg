<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="cxyConventionalList" checkbox="true" pagination="true" fitColumns="true" title="常规模版" sortName="createDate" actionUrl="cxyConventionalController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建人名称"  field="createName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建人登录名称"  field="createBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建日期"  field="createDate"  formatter="yyyy-MM-dd"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人名称"  field="updateName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人登录名称"  field="updateBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新日期"  field="updateDate"  formatter="yyyy-MM-dd"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="名字"  field="name"  query="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="年龄"  field="age"  query="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="性别"  field="sex"  query="true"  queryMode="single"  dictionary="sex"  width="120"></t:dgCol>
   <t:dgCol title="手机"  field="phone"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="头像"  field="avatar"  queryMode="single"  image="true" imageSize="50,50"  width="120"></t:dgCol>
   <t:dgCol title="简历"  field="resume"  queryMode="single"  downloadName="附件下载"  width="120"></t:dgCol>
   <t:dgCol title="自我介绍"  field="introduction"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="cxyConventionalController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar operationCode="add" title="录入" icon="icon-add" url="cxyConventionalController.do?goAdd" funname="add"></t:dgToolBar>
	<t:dgToolBar title="编辑" icon="icon-edit" url="cxyConventionalController.do?goUpdate" funname="update"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="cxyConventionalController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="cxyConventionalController.do?goUpdate" funname="detail"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
 });
 
   
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'cxyConventionalController.do?upload', "cxyConventionalList");
}

//导出
function ExportXls() {
	JeecgExcelExport("cxyConventionalController.do?exportXls","cxyConventionalList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("cxyConventionalController.do?exportXlsByT","cxyConventionalList");
}

 </script>
