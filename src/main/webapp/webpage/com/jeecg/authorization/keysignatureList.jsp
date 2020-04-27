<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>密钥签名授权</title>
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

    .el-dialog{
     display: flex;
     flex-direction: column;
     margin:0 !important;
     position:absolute;
     top:50%;
     left:50%;
     transform:translate(-50%,-50%);
     /*height:600px;*/
     max-height:calc(100% - 30px);
     max-width:calc(100% - 30px);
    }
    .el-dialog .el-dialog__body{
     flex:1;
     overflow: auto;
    }

	</style>
</head>
<body style="background-color: #FFFFFF;">
	<div id="keysignatureList" v-cloak>
		<!--工具条-->

			<el-form :inline="true" :model="filters" size="mini" ref="filters">

				<el-row style="margin-top: 15px;">
					<el-form-item style="margin-bottom: 8px;">
						<el-input v-model="filters.userName" placeholder="用户名称"></el-input>
					</el-form-item>
					<el-form-item style="margin-bottom: 8px;" prop="byTime_begin">
						<el-date-picker  type="date" placeholder="选择截止开始时间" v-model="filters.byTime_begin" :picker-options="pickerOptionsStart" @change="changeEnd" ></el-date-picker>
					</el-form-item>
					<el-form-item style="margin-bottom: 8px;" prop="byTime_end">
						<el-date-picker  type="date" placeholder="选择截止结束时间" v-model="filters.byTime_end" :picker-options="pickerOptionsEnd" @change="changeStart" ></el-date-picker>
					</el-form-item>
					<el-form-item>
						<el-button type="primary" icon="el-icon-search" v-on:click="getKeysignatures">查询</el-button>
					</el-form-item>
					<el-form-item>
						<el-button icon="el-icon-refresh" @click="resetForm('filters')">重置</el-button>
					</el-form-item>
				</el-row>

				<el-row style="margin-top: 1px;">
					<el-form-item>
						<el-button type="primary" icon="el-icon-edit" @click="handleAdd">新增</el-button>
					</el-form-item>
					<el-form-item>
						<el-button type="primary" icon="el-icon-edit" @click="ExportXls">导出</el-button>
					</el-form-item>
					<el-form-item>
						<el-button type="primary" @click="ImportXls">导入<i class="el-icon-upload el-icon--right"></i></el-button>
					</el-form-item>
					<el-form-item>
						<el-button type="success" plain icon="el-icon-search" @click="publicKeyCheck">校验</el-button>
					</el-form-item>
				</el-row>

			</el-form>




		<!--列表-->
		<el-table :data="keysignatures" border stripe size="mini" highlight-current-row v-loading="listLoading" @sort-change="handleSortChange"  @selection-change="selsChange" style="width: 100%;">
			<el-table-column type="selection" width="55"></el-table-column>
			<el-table-column label="序号" type="index" width="50"></el-table-column>
			<el-table-column prop="userName" label="用户名称" min-width="100" sortable="custom" show-overflow-tooltip></el-table-column>
			<el-table-column prop="byTime" label="截止时间" min-width="100" sortable="custom" show-overflow-tooltip :formatter="formatDate"></el-table-column>
			<el-table-column :show-overflow-tooltip="true" prop="authorizationModule" label="授权模块" min-width="120" sortable="custom" show-overflow-tooltip></el-table-column>
			<el-table-column :show-overflow-tooltip="true" prop="clear" label="明文" min-width="120" sortable="custom" show-overflow-tooltip></el-table-column>
			<el-table-column :show-overflow-tooltip="true" prop="cipher" label="密文" min-width="120" sortable="custom" show-overflow-tooltip></el-table-column>
			<%--<el-table-column prop="signature" label="签名" min-width="120" sortable="custom" show-overflow-tooltip></el-table-column>--%>
			<el-table-column :show-overflow-tooltip="true" prop="publicKey" label="公钥" min-width="120" sortable="custom" show-overflow-tooltip></el-table-column>
			<el-table-column :show-overflow-tooltip="true" prop="privateKey" label="私钥" min-width="120" sortable="custom" show-overflow-tooltip></el-table-column>
			<el-table-column label="操作" width="220">
				<template scope="scope">
					<el-button type="primary" icon="el-icon-edit" size="mini" @click="handleEdit(scope.$index, scope.row)"></el-button>
					<el-button type="info" plain size="mini" @click="downloadPublicKey(scope.$index, scope.row)">公钥</el-button>
					<el-button type="warning" plain size="mini" @click="downloadCipher(scope.$index, scope.row)">密文</el-button>
					<%--<el-button type="danger" size="mini" @click="handleDel(scope.$index, scope.row)">删除</el-button>--%>
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
		<el-dialog width="50%" :title="formTitle"  z-index="800" :visible.sync="formVisible" :close-on-click-modal="false">
			<el-form :model="form" label-width="80px" :rules="formRules" ref="form" size="mini">
					<el-form-item label="用户名称" prop="userName">
						<el-input v-model="form.userName" auto-complete="off" placeholder="请输入用户名称"></el-input>
					</el-form-item>
					<el-form-item label="截止时间" prop="byTime">
						<el-date-picker type="date" placeholder="选择截止时间" v-model="form.byTime"></el-date-picker>
					</el-form-item>
					<el-form-item label="授权模块" prop="authorizationModule">
						<el-input v-model="form.authorizationModule" auto-complete="off" placeholder="请输入授权模块"></el-input>
					</el-form-item>
					<%--<el-form-item label="明文" prop="clear">--%>
						<%--<el-input v-model="form.clear" auto-complete="off" placeholder="请输入明文"></el-input>--%>
					<%--</el-form-item>--%>
					<%--<el-form-item label="密文" prop="cipher">--%>
						<%--<el-input v-model="form.cipher" auto-complete="off" placeholder="请输入密文"></el-input>--%>
					<%--</el-form-item>--%>
					<%--<el-form-item label="签名" prop="signature">--%>
						<%--<el-input v-model="form.signature" auto-complete="off" placeholder="请输入签名"></el-input>--%>
					<%--</el-form-item>--%>
					<%--<el-form-item label="公钥">--%>
						<%--<el-input type="textarea" name="publicKey" v-model="form.publicKey"></el-input>--%>
					<%--</el-form-item>--%>
					<%--<el-form-item label="私钥">--%>
						<%--<el-input type="textarea" name="privateKey" v-model="form.privateKey"></el-input>--%>
					<%--</el-form-item>--%>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click.native="formVisible = false">取消</el-button>
				<el-button type="primary" @click.native="formSubmit" :loading="formLoading">提交</el-button>
			</div>
		</el-dialog>

		<!--校验-->
		<el-dialog width="50%" :title="formTitle"  z-index="800" :visible.sync="publicKeyCheckVisible" :close-on-click-modal="false">
			<el-form :model="form" label-width="80px" :rules="publicKeyCheckFormRules" ref="form" size="mini">
				<el-form-item label="公钥" prop="publicKey">
				<el-input type="textarea" name="publicKey" v-model="form.publicKey"></el-input>
				</el-form-item>
				<el-form-item label="密文" prop="cipher">
				<el-input type="textarea" name="cipher" v-model="form.cipher"></el-input>
				</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click.native="publicKeyCheckVisible = false">取消</el-button>
				<el-button type="primary" @click.native="publicKeyCheckSubmit" :loading="formLoading">提交</el-button>
			</div>
		</el-dialog>


	</div>
</body>
<script>
	var vue = new Vue({
		el:"#keysignatureList",
		data() {
			return {
				filters: {
					byTime_begin:'',
					byTime_end:'',
                    userName:'',
				},
				url:{
					list:'${webRoot}/keysignatureController.do?datagrid',
					del:'${webRoot}/keysignatureController.do?doDel',
					batchDel:'${webRoot}/keysignatureController.do?doBatchDel',
					queryDict:'${webRoot}/systemController.do?typeListJson',
					save:'${webRoot}/keysignatureController.do?doAdd',
					edit:'${webRoot}/keysignatureController.do?doUpdate',
					upload:'${webRoot}/systemController/filedeal.do',
					downFile:'${webRoot}/img/server/',
					exportXls:'${webRoot}/keysignatureController.do?exportXls&id=',
					ImportXls:'${webRoot}/keysignatureController.do?upload',
                    downloadPublicKey:'${webRoot}/keysignatureController.do?downloadPublicKey&id=',
                    downloadCipher:'${webRoot}/keysignatureController.do?downloadCipher&id=',
                    publicKeyCheck:'${webRoot}/keysignatureController.do?publicKeyCheck',


				},
				keysignatures: [],
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
                publicKeyCheckVisible:false,
				formLoading: false,
				formRules: {
                    userName: [
                        { required: true, message: '请输入用户名称', trigger: 'blur' },
                        { min: 0, max: 15, message: '长度在15个字符之内', trigger: 'blur' }
                    ],
                    byTime: [
                        { type: 'date', required: true, message: '请选择截止时间', trigger: 'change' }
                    ],
                    authorizationModule: [
                        { required: true, message: '请输入授权模块', trigger: 'blur' },
                        { min: 0, max: 50, message: '长度在50个字符之内', trigger: 'blur' }
                    ],

				},
				//公钥校验页面
                publicKeyCheckFormRules: {
                    publicKey: [
                        { required: true, message: '请输入公钥', trigger: 'blur' },
                        { min: 0, max: 500, message: '长度在500个字符之内', trigger: 'blur' }
                    ],
                    cipher: [
                        { required: true, message: '请输入密文', trigger: 'blur' },
                        { min: 0, max: 500, message: '长度在500个字符之内', trigger: 'blur' }
                    ],

                },
				//表单界面数据
				form: {},
                // 限制开始时间
                pickerOptionsStart: {},
                pickerOptionsEnd: {},

				//数据字典
			}
		},
		methods: {
			handleSortChange(sort){
				this.sort={
					sort:sort.prop,
					order:sort.order=='ascending'?'asc':'desc'
				};
				this.getKeysignatures();
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
			handleCurrentChange(val) {
				this.page = val;
				this.getKeysignatures();
			},
			handleSizeChange(val) {
				this.pageSize = val;
				this.page = 1;
				this.getKeysignatures();
			},
			resetForm(formName) {
		        this.$refs[formName].resetFields();
                this.filters.userName='';
                this.filters.byTime_begin='yyyy-MM-dd',
				this.filters.byTime_end='yyyy-MM-dd',

		        this.getKeysignatures();
		    },
			//获取用户列表
			getKeysignatures() {
				var fields=[];
				fields.push('id');
				fields.push('id');
				fields.push('createName');
				fields.push('createBy');
				fields.push('createDate');
				fields.push('updateName');
				fields.push('updateBy');
				fields.push('updateDate');
				fields.push('publicKey');
				fields.push('privateKey');
				fields.push('userName');
				fields.push('byTime');
				fields.push('authorizationModule');
				fields.push('clear');
				fields.push('cipher');
                fields.push('signature');
				let para = {
					params: {
						page: this.page,
						rows: this.pageSize,
						//排序
						sort:this.sort.sort,
						order:this.sort.order,
                        userName:this.filters.userName,
					 	byTime_begin: !this.filters.byTime_begin ? '' : this.filters.byTime_begin == 'yyyy-MM-dd' ? '' : utilFormatDate(new Date(this.filters.byTime_begin ), 'yyyy-MM-dd'),
						byTime_end: !this.filters.byTime_end ? '' : this.filters.byTime_end == 'yyyy-MM-dd' ? '' : utilFormatDate(new Date(this.filters.byTime_end ), 'yyyy-MM-dd'),
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
					this.keysignatures = datas;
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
						this.getKeysignatures();
					});
				}).catch(() => {

				});
			},
			//显示编辑界面
			handleEdit: function (index, row) {
				this.formTitle='编辑';
				this.formVisible = true;
				this.form = Object.assign({}, row);
			},
			//显示新增界面
			handleAdd: function () {
				this.formTitle='新增';
				this.formVisible = true;
				this.form = {
					userName:'',
					byTime:'',
					authorizationModule:'',
					clear:'',
					cipher:'',
                    signature:'',
				};
			},
			//新增
			formSubmit: function () {
				this.$refs.form.validate((valid) => {
					if (valid) {
						//this.$confirm('确认提交吗？', '提示', {}).then(() => {
							this.formLoading = true;
							let para = Object.assign({}, this.form);

							para.byTime = !para.byTime ? '' : utilFormatDate(new Date(para.byTime), 'yyyy-MM-dd');


							this.$http.post(!!para.id?this.url.edit:this.url.save,para,{emulateJSON: true}).then((res) => {
								this.formLoading = false;
								this.$message({
									message: '提交成功',
									type: 'success',
									duration:1500
								});
								this.$refs['form'].resetFields();
								this.formVisible = false;
								this.getKeysignatures();
							});
						//});
					}
				});
			},
            //显示校验界面
            publicKeyCheck: function () {
                this.formTitle='校验';
                this.publicKeyCheckVisible = true;
                this.form = {
                    publicKey:'',
                    cipher:'',
                };
            },
            //校验提交
            publicKeyCheckSubmit: function () {
                this.$refs.form.validate((valid) => {
                    if (valid) {
                        this.formLoading = true;
                        let para = Object.assign({}, this.form);
                        this.$http.post(this.url.publicKeyCheck,para,{emulateJSON: true}).then((res) => {
                            this.formLoading = false;
                        this.$message({
                            message: res.body.msg,
                            type: 'success',
                            duration:2000
                        });
                        this.$refs['form'].resetFields();
                        this.publicKeyCheckVisible = false;
                        this.getKeysignatures();
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
						this.getKeysignatures();
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
				openuploadwin('Excel导入',this.url.ImportXls, "keysignatureList");
			},
            //下载公钥
            downloadPublicKey: function (index, row) {
                window.location.href = this.url.downloadPublicKey+row.id;
            },
            //下载密文
            downloadCipher: function (index, row) {
                window.location.href = this.url.downloadCipher+row.id;
            },

            // 结束时间限制开始时间
            changeStart() {
                if (!this.filters.byTime_end) {
                    this.pickerOptionsStart = {
                        disabledDate: {}
                    }
                    return
                }
                this.pickerOptionsStart = Object.assign({}, this.pickerOptionsStart, {
                    // 可通过箭头函数的方式访问到this
                    disabledDate: (time) => {
                    var times = ''
                    times = time.getTime() > this.filters.byTime_end
                    return times
                }
            })
            },
            // 开始时间 控制结束时间
            changeEnd() {
                if (!this.filters.byTime_begin) {
                    this.pickerOptionsEnd = {
                        disabledDate: {}
                    }
                    return
                }
                this.pickerOptionsEnd = Object.assign({}, this.pickerOptionsEnd, {
                    disabledDate: (time) => {
                    return time.getTime() < this.filters.byTime_begin
                }
            })
            },


			//初始化数据字典
			initDictsData:function(){
	        	var _this = this;
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
			this.getKeysignatures();
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