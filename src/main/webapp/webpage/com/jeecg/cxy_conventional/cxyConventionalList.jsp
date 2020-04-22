<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>常规模版</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name=viewportcontent="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no,minimal-ui">
	<link rel="stylesheet" href="${webRoot}/plug-in/element-ui/css/index.css">
	<link rel="stylesheet" href="${webRoot}/plug-in/element-ui/css/elementui-ext.css">
	<script src="${webRoot}/plug-in/vue/vue.js"></script>
	<script src="${webRoot}/plug-in/vue/vue-resource.js"></script>
	<script src="${webRoot}/plug-in/element-ui/index.js"></script>
	<!-- Jquery组件引用 -->
	<script src="${webRoot}/plug-in/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="${webRoot}/plug-in/jquery-plugs/i18n/jquery.i18n.properties.js"></script>
	<script type="text/javascript" src="${webRoot}/plug-in/mutiLang/zh-cn.js"></script>
	<script type="text/javascript" src="${webRoot}/plug-in/lhgDialog/lhgdialog.min.js?skin=metrole"></script>
	<script type="text/javascript" src="${webRoot}/plug-in/tools/curdtools.js"></script>
	<style>
	.toolbar {
	    padding: 10px;
	    margin: 10px 0;
	}
	.toolbar .el-form-item {
	    margin-bottom: 10px;
	}
	.el-table__header tr th{
		padding:3px 0px;
	}
	[v-cloak] { display: none }
	</style>
</head>
<body style="background-color: #FFFFFF;">
	<div id="cxyConventionalList" v-cloak>
		<!--工具条-->
		<el-row style="margin-top: 15px;">
			<el-form :inline="true" :model="filters" size="mini" ref="filters">
				<el-form-item style="margin-bottom: 8px;" prop="name">
					<el-input v-model="filters.name" auto-complete="off" placeholder="请输入名字"></el-input>
				</el-form-item>
				<el-form-item style="margin-bottom: 8px;" prop="age">
					<el-input v-model="filters.age" auto-complete="off" placeholder="请输入年龄"></el-input>
				</el-form-item>
				<el-form-item style="margin-bottom: 8px;" prop="sex">
					<el-select v-model="filters.sex" placeholder="请选择性别">
				      <el-option :label="option.typename" :value="option.typecode" v-for="option in sexOptions"></el-option>
				    </el-select>
				</el-form-item>
				<el-form-item>
			    	<el-button type="primary" icon="el-icon-search" v-on:click="getCxyConventionals">查询</el-button>
			    </el-form-item>
			    <el-form-item>
			    	<el-button icon="el-icon-refresh" @click="resetForm('filters')">重置</el-button>
			    </el-form-item>

                <%--新版本使用替代 operationCode标签--%>
                <t:hasPermission code="add">
                <el-form-item>
			    	<el-button type="primary" icon="el-icon-edit" @click="handleAdd">新增</el-button>
			    </el-form-item>
                </t:hasPermission>

			    <el-form-item>
			    	<el-button type="primary" icon="el-icon-edit" @click="ExportXls">导出</el-button>
			    </el-form-item>
			    <el-form-item>
			    	<el-button type="primary" icon="el-icon-edit" @click="ImportXls">导入</el-button>
			    </el-form-item>
			</el-form>
		</el-row>
		
		<!--列表-->
		<el-table :data="cxyConventionals" border stripe size="mini" highlight-current-row v-loading="listLoading" @sort-change="handleSortChange"  @selection-change="selsChange" style="width: 100%;">
			<el-table-column type="selection" width="55"></el-table-column>
			<el-table-column type="index" width="60"></el-table-column>
			<el-table-column prop="name" label="名字" min-width="120" sortable="custom" show-overflow-tooltip></el-table-column>
			<el-table-column prop="age" label="年龄" min-width="120" sortable="custom" show-overflow-tooltip></el-table-column>
			<el-table-column prop="sex" label="性别" min-width="120" sortable="custom" show-overflow-tooltip :formatter="formatSexDict"></el-table-column>
			<el-table-column prop="phone" label="手机" min-width="120" sortable="custom" show-overflow-tooltip></el-table-column>
			<el-table-column prop="avatar" label="头像" min-width="120" sortable="custom" show-overflow-tooltip>
				<template slot-scope="scope" v-if="scope.row.avatar">
					<img width="30" height="30" :src="'img/server/'+scope.row.avatar" alt="头像"/>
				</template>
			</el-table-column>
			<el-table-column prop="resume" label="简历" min-width="120" sortable="custom" show-overflow-tooltip>
				<template slot-scope="scope" v-if="scope.row.resume">
					<el-button size="mini" type="primary" @click="handleDownFile('1',scope.row.resume)">文件下载</el-button>
				</template>
			</el-table-column>
			<el-table-column prop="introduction" label="自我介绍" min-width="120" sortable="custom" show-overflow-tooltip></el-table-column>
			<el-table-column label="操作" width="150">
				<template scope="scope">
					<el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
					<el-button type="danger" size="mini" @click="handleDel(scope.$index, scope.row)">删除</el-button>
				</template>
			</el-table-column>
		</el-table>
		
		<!--工具条-->
		<el-col :span="24" class="toolbar">
			<el-button type="danger" size="mini" @click="batchRemove" :disabled="this.sels.length===0">批量删除</el-button>
			 <el-pagination small background @current-change="handleCurrentChange" @size-change="handleSizeChange" :page-sizes="[10, 20, 50, 100]"
      			:page-size="pageSize" :total="total" layout="sizes, prev, pager, next"  style="float:right;"></el-pagination>
		</el-col>
		
		<!--新增界面-->
		<el-dialog :title="formTitle" fullscreen z-index="800" :visible.sync="formVisible" :close-on-click-modal="false">
			<el-form :model="form" label-width="80px" :rules="formRules" ref="form" size="mini">
					<el-form-item label="名字" prop="name">
						<el-input v-model="form.name" auto-complete="off" placeholder="请输入名字"></el-input>
					</el-form-item>
					<el-form-item label="年龄" prop="age">
						<el-input v-model="form.age" auto-complete="off" placeholder="请输入年龄"></el-input>
					</el-form-item>
					<el-form-item label="性别">
						<el-select v-model="form.sex" placeholder="请选择性别">
					      <el-option :label="option.typename" :value="option.typecode" v-for="option in sexOptions"></el-option>
					    </el-select>
					</el-form-item>
					<el-form-item label="手机" prop="phone">
						<el-input v-model="form.phone" auto-complete="off" placeholder="请输入手机"></el-input>
					</el-form-item>
					<el-form-item label="头像" prop="avatar">
						<el-upload
						  :action="url.upload"
						  :data="{isup:'1'}"
						  :on-success="handleAvatarUploadFile"
						  :on-remove="handleAvatarRemoveFile"
						  :file-list="formFile.avatar"
						  list-type="picture">
						  <el-button size="small" type="primary">点击上传</el-button>
						</el-upload>
					</el-form-item>
					<el-form-item label="简历" prop="resume">
						<el-upload
						  :action="url.upload"
						  :data="{isup:'1'}"
						  :on-success="handleResumeUploadFile"
						  :on-remove="handleResumeRemoveFile"
						  :file-list="formFile.resume">
						  <el-button size="small" type="primary">点击上传</el-button>
						</el-upload>
					</el-form-item>
					<el-form-item label="自我介绍">
						<el-input type="textarea" name="introduction" v-model="form.introduction"></el-input>
					</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click.native="formVisible = false">取消</el-button>
				<el-button type="primary" @click.native="formSubmit" :loading="formLoading">提交</el-button>
			</div>
		</el-dialog>
	</div>
</body>
<script>
	var vue = new Vue({			
		el:"#cxyConventionalList",
		data() {
			return {
				filters: {
					name:'',
					age:'',
					sex:'',
				},
				url:{
					list:'${webRoot}/cxyConventionalController.do?datagrid',
					del:'${webRoot}/cxyConventionalController.do?doDel',
					batchDel:'${webRoot}/cxyConventionalController.do?doBatchDel',
					queryDict:'${webRoot}/systemController.do?typeListJson',
					save:'${webRoot}/cxyConventionalController.do?doAdd',
					edit:'${webRoot}/cxyConventionalController.do?doUpdate',
					upload:'${webRoot}/systemController/filedeal.do',
					downFile:'${webRoot}/img/server/',
					exportXls:'${webRoot}/cxyConventionalController.do?exportXls&id=',
					ImportXls:'${webRoot}/cxyConventionalController.do?upload'
				},
				cxyConventionals: [],
				total: 0,
				page: 1,
				pageSize:10,
				sort:{
					sort:'id',
					order:'desc'
				},
				listLoading: false,
				sels: [],//列表选中列
				
				formTitle:'新增',
				formVisible: false,//表单界面是否显示
				formLoading: false,
				formRules: {
				},
				//表单界面数据
				form: {},
				
				formFile: {
					avatar:[],
					resume:[],
				},
				
				//数据字典 
		   		sexOptions:[],
			}
		},
		methods: {
			handleAvatarUploadFile: function(response, file, fileList){
				file.url="img/server/"+response.obj;
				this.form.avatar=response.obj;
				if(fileList.length>1){
					this.handleAvatarRemoveFile(fileList.splice(0,1)[0],fileList);
				}
			},
			handleAvatarRemoveFile: function(file, fileList){
				if(fileList.length==0){
					this.form.avatar="";
				}
				this.$http.get(this.url.upload,{
					params:{
						isdel:'1',
						path:file.url
					}
				}).then((res) => {
				});
			},
			handleResumeUploadFile: function(response, file, fileList){
				file.url=response.obj;
				this.form.resume=response.obj;
				if(fileList.length>1){
					this.handleResumeRemoveFile(fileList.splice(0,1)[0],fileList);
				}
			},
			handleResumeRemoveFile: function(file, fileList){
				if(fileList.length==0){
					this.form.resume="";
				}
				this.$http.get(this.url.upload,{
					params:{
						isdel:'1',
						path:file.url
					}
				}).then((res) => {
				});
			},
			handleSortChange(sort){
				this.sort={
					sort:sort.prop,
					order:sort.order=='ascending'?'asc':'desc'
				};
				this.getCxyConventionals();
			},
			handleDownFile(type,filePath){
				var downUrl=this.url.downFile+ filePath +"?down=true";
				window.open(downUrl);
			},
			formatDate: function(row,column,cellValue, index){
				return !!cellValue?utilFormatDate(new Date(cellValue), 'yyyy-MM-dd'):'';
			},
			formatDateTime: function(row,column,cellValue, index){
				return !!cellValue?utilFormatDate(new Date(cellValue), 'yyyy-MM-dd hh:mm:ss'):'';
			},
			formatSexDict: function(row,column,cellValue, index){
				var names="";
				var values=cellValue;
				if(!Array.isArray(cellValue))values=cellValue.split(',');
				for (var i = 0; i < values.length; i++) {
					var value = values[i];
					if(i>0)names+=",";
					for(var j in this.sexOptions){
						var option=this.sexOptions[j];
						if(value==option.typecode){
							names+=option.typename;
						}
					}
				}
				return names;
			},
			handleCurrentChange(val) {
				this.page = val;
				this.getCxyConventionals();
			},
			handleSizeChange(val) {
				this.pageSize = val;
				this.page = 1;
				this.getCxyConventionals();
			},
			resetForm(formName) {
		        this.$refs[formName].resetFields();
		        this.getCxyConventionals();
		    },
			//获取用户列表
			getCxyConventionals() {
				var fields=[];
				fields.push('id');
				fields.push('id');
				fields.push('createName');
				fields.push('createBy');
				fields.push('createDate');
				fields.push('updateName');
				fields.push('updateBy');
				fields.push('updateDate');
				fields.push('name');
				fields.push('age');
				fields.push('sex');
				fields.push('phone');
				fields.push('avatar');
				fields.push('resume');
				fields.push('introduction');
				let para = {
					params: {
						page: this.page,
						rows: this.pageSize,
						//排序
						sort:this.sort.sort,
						order:this.sort.order,
					 	name:this.filters.name,
					 	age:this.filters.age,
					 	sex:this.filters.sex,
						field:fields.join(',')
					}
				};
				this.listLoading = true;
				this.$http.get(this.url.list,para).then((res) => {
					this.total = res.data.total;
					var datas=res.data.rows;
					for (var i = 0; i < datas.length; i++) {
						var data = datas[i];
					}
					this.cxyConventionals = datas;
					this.listLoading = false;
				});
			},
			//删除
			handleDel: function (index, row) {
				this.$confirm('确认删除该记录吗?', '提示', {
					type: 'warning'
				}).then(() => {
					this.listLoading = true;
					let para = { id: row.id };
					this.$http.post(this.url.del,para,{emulateJSON: true}).then((res) => {
						this.listLoading = false;
						this.$message({
							message: '删除成功',
							type: 'success',
							duration:1500
						});
						this.getCxyConventionals();
					});
				}).catch(() => {

				});
			},
			//显示编辑界面
			handleEdit: function (index, row) {
				this.formTitle='编辑';
				this.formVisible = true;
				this.form = Object.assign({}, row);
				var avatar=[];
				if(!!this.form.avatar){
					avatar=[{
						name:this.form.avatar.substring(this.form.avatar.lastIndexOf('\\')+1),
						url:"img/server/"+this.form.avatar
					}]
				}
				var resume=[];
				if(!!this.form.resume){
					resume=[{
						name:this.form.resume.substring(this.form.resume.lastIndexOf('\\')+1),
						url:this.form.resume
					}]
				}
				this.formFile={
					avatar:avatar,
					resume:resume,
				};
			},
			//显示新增界面
			handleAdd: function () {
				this.formTitle='新增';
				this.formVisible = true;
				this.form = {
					name:'',
					age:'',
					sex:'',
					phone:'',
					avatar:'',
					resume:'',
				};
				this.formFile={
					avatar:[],
					resume:[],
				};
			},
			//新增
			formSubmit: function () {
				this.$refs.form.validate((valid) => {
					if (valid) {
						this.$confirm('确认提交吗？', '提示', {}).then(() => {
							this.formLoading = true;
							let para = Object.assign({}, this.form);
							
							
							
							this.$http.post(!!para.id?this.url.edit:this.url.save,para,{emulateJSON: true}).then((res) => {
								this.formLoading = false;
								this.$message({
									message: '提交成功',
									type: 'success',
									duration:1500
								});
								this.$refs['form'].resetFields();
								this.formVisible = false;
								this.getCxyConventionals();
							});
						});
					}
				});
			},
			selsChange: function (sels) {
				this.sels = sels;
			},
			//批量删除
			batchRemove: function () {
				var ids = this.sels.map(item => item.id).toString();
				this.$confirm('确认删除选中记录吗？', '提示', {
					type: 'warning'
				}).then(() => {
					this.listLoading = true;
					let para = { ids: ids };
					this.$http.post(this.url.batchDel,para,{emulateJSON: true}).then((res) => {
						this.listLoading = false;
						this.$message({
							message: '删除成功',
							type: 'success',
							duration:1500
						});
						this.getCxyConventionals();
					});
				}).catch(() => {
				});
			},
			//导出
			ExportXls: function() {
					var ids = this.sels.map(item => item.id).toString();
					window.location.href = this.url.exportXls+ids;
			},
			//导入
			ImportXls: function(){
				openuploadwin('Excel导入',this.url.ImportXls, "cxyConventionalList");
			},
			//初始化数据字典
			initDictsData:function(){
	        	var _this = this;
		   		_this.initDictByCode('sex',_this,'sexOptions');
	        },
	        initDictByCode:function(code,_this,dictOptionsName){
	        	if(!code || !_this[dictOptionsName] || _this[dictOptionsName].length>0)
	        		return;
	        	this.$http.get(this.url.queryDict,{params: {typeGroupName:code}}).then((res) => {
	        		var data=res.data;
					if(data.success){
					  _this[dictOptionsName] = data.obj;
					  _this[dictOptionsName].splice(0, 1);//去掉请选择
					}
				});
	        }
		},
		mounted() {
			this.initDictsData();
			this.getCxyConventionals();
		}
	});
	
	function utilFormatDate(date, pattern) {
        pattern = pattern || "yyyy-MM-dd";
        return pattern.replace(/([yMdhsm])(\1*)/g, function ($0) {
            switch ($0.charAt(0)) {
                case 'y': return padding(date.getFullYear(), $0.length);
                case 'M': return padding(date.getMonth() + 1, $0.length);
                case 'd': return padding(date.getDate(), $0.length);
                case 'w': return date.getDay() + 1;
                case 'h': return padding(date.getHours(), $0.length);
                case 'm': return padding(date.getMinutes(), $0.length);
                case 's': return padding(date.getSeconds(), $0.length);
            }
        });
    };
	function padding(s, len) {
	    var len = len - (s + '').length;
	    for (var i = 0; i < len; i++) { s = '0' + s; }
	    return s;
	};
	function reloadTable(){
		
	}
</script>
</html>