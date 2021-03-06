<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>${title!"列表"}</title>
	[#include "/admin/common/commons.html"]
	[#include "/tenant/common/site.html"]
	[@baseHead /]
	<script type="text/javascript"></script>
	<link rel="stylesheet" href="<#noparse>${siteurl}</#noparse>plugins/vue-org-tree/style.css">
	<style>
		.bg-white {
			cursor: pointer;
		}

		.bg-white-curren {
			background-color: #409EFF;
			color: #fff;
		}

		.right-menu {
			border: 1px solid #eee;
			box-shadow: 0 .5em 1em 0 rgba(0, 0, 0, .1);
			border-radius: 1px;
		}

		.right-menu {
			position: fixed;
			background: #fff;
			border: 1px solid rgba(0, 0, 0, .2);
			border-radius: 3px;
			z-index: 999;
			display: none;
		}

		.right-menu a {
			padding: 2px;
		}

		.right-menu a {
			width: 75px;
			height: 28px;
			line-height: 28px;
			text-align: center;
			display: block;
			color: #1a1a1a;
		}

		.custom-tree-node {
			flex: 1;
			display: flex;
			align-items: center;
			justify-content: space-between;
			font-size: 14px;
			padding-right: 8px;
		}

		.tree-div {
			width: 100%;
		}

		.el-tabs {
			background-color: #fff;
			padding: 15px;
		}

		.input-line {
			margin: 5px 0px;
		}

		.input-line .title {
			line-height: 32px;
			float: right;
			font-size: 12px;
		}
	</style>
</head>

<body class="hold-transition skin-blue sidebar-mini">
	<!-- Site wrapper -->
	<div class="wrapper">

		<header class="main-header">
			<!-- Header Navbar: style can be found in header.less -->
			[#include "/admin/common/nav.html"]
		</header>

		<!-- =============================================== -->

		<!-- Left side column. contains the sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				[@user_panel /]
				<!-- search form -->
				[@sidebar_form /]
				<!-- /.search form -->
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu" data-widget="tree">
					<li class="header">主面板</li>
					[@menustag id=1]
					[#list list as item]
					[@menu item "${menus!''}"]
					[/@menu]
					[/#list]
					[/@menustag]
				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>

		<!-- =============================================== -->

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" id="app" v-cloak>
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<!-- 导航 -->
				<div class="navigation">
					<i>首页</i> <span>${title!"列表"}</span>
				</div>
			</section>
			<!-- Main content -->
			<section class="content">
				<el-tabs v-model="activeName">
					<el-tab-pane label="${model!}树" name="third">
						<el-button type="primary" size="mini" @click="append()"  style="margin-bottom:15px;">增加一级分类
						</el-button>
						<el-table :data="treeOptions.children" style="width: 100%;margin-bottom: 20px;" row-key="id"
							border>
							<el-table-column prop="name" label="${model!}名称" sortable width="260" align="left">
							</el-table-column>
							<el-table-column prop="sortNum" label="排序号" width="80" align="center">
							</el-table-column>
							<el-table-column prop="addDate" label="添加时间" width="160" >
							</el-table-column>
							<el-table-column prop="demo" label="备注"  >
							</el-table-column>
							<el-table-column label="操作" width="240" align="center"   >
								<template slot-scope="scope">
									<el-button type="primary" size="mini" @click="append(scope.row)">增加
									</el-button>
									<el-button type="primary" size="mini" @click="editData(scope.row)">编辑
									</el-button>
									<el-button type="danger" size="mini" style="cursor: pointer;"
										@click="deleteData(scope.row)">删除
									</el-button>
								</template>
							</el-table-column>
						</el-table>
					</el-tab-pane>
					<el-tab-pane label="${model!}图" name="second">
						<vue2-org-tree class="tree-div" :data="treeOptions"
							:collapsable="collapsable" :expandAll="expandAll" :horizontal="horizontal"
							:label-class-name="labelClassName" :render-content="renderContent" @on-expand="onExpand"
							@on-node-click="onNodeClick" />
					</el-tab-pane>
				</el-tabs>

				<el-dialog title="增加${model!}" :visible.sync="showDialog" width="30%">
					<el-row :gutter="20">
						<el-col :span="18" :offset="2">
							<el-row class="input-line">
								<el-col :span="6">
									<span class="el-form-item__label title">上级${model!}：</span>
								</el-col>
								<el-col :span="18">
									<el-input disabled="true" size="small" v-model="form.parentName"></el-input>
								</el-col>
							</el-row>
							<el-row class="input-line">
								<el-col :span="6">
									<span class="el-form-item__label title">${model!}名称：</span>
								</el-col>
								<el-col :span="18">
									<el-input size="small" v-model="form.name"></el-input>
								</el-col>
							</el-row>
							<el-row class="input-line">
								<el-col :span="6">
									<span class="el-form-item__label title">排序号：</span>
								</el-col>
								<el-col :span="18">
									<el-input size="small" v-model="form.sortNum"></el-input>
								</el-col>
							</el-row>
							<#list bean.fields as item>
							<el-row class="input-line">
                            	<el-col :span="6">
                            		<span class="el-form-item__label title">${item.title!}：</span>
                            	</el-col>
                            	<el-col :span="18">
                            		<el-input size="small" v-model="form.${item.id!}"></el-input>
                            	</el-col>
                            </el-row>
							</#list>

						</el-col>
					</el-row>
					<span slot="footer" class="dialog-footer">
						<el-button size="small" @click="showDialog = false">取 消</el-button>
						<el-button size="small" type="primary" @click="addTreeItem">确 定</el-button>
					</span>
				</el-dialog>
				<el-dialog title="编辑${model!}" :visible.sync="editDialog" width="30%">
					<el-row :gutter="20">
						<el-col :span="18" :offset="2">
							<el-row class="input-line">
								<el-col :span="6">
									<span class="el-form-item__label title">${model!}名称：</span>
								</el-col>
								<el-col :span="18">
									<el-input size="small" v-model="form.name"></el-input>
								</el-col>
							</el-row>
							<el-row class="input-line">
								<el-col :span="6">
									<span class="el-form-item__label title">排序号：</span>
								</el-col>
								<el-col :span="18">
									<el-input size="small" v-model="form.sortNum"></el-input>
								</el-col>
							</el-row>
							<#list bean.fields as item>
                            <el-row class="input-line">
                            	<el-col :span="6">
                            		<span class="el-form-item__label title">${item.title!}：</span>
                            	</el-col>
                            	<el-col :span="18">
                            		<el-input size="small" v-model="form.${item.id!}"></el-input>
                            	</el-col>
                            </el-row>
                            </#list>
						</el-col>
					</el-row>
					<span slot="footer" class="dialog-footer">
						<el-button size="small" @click="editDialog = false">取 消</el-button>
						<el-button size="small" type="primary" @click="editTreeItem">确 定</el-button>
					</span>
				</el-dialog>
				<el-dialog title="提示" :visible.sync="dialogVisible" width="30%">
					<span>确认要删除该条数据吗?</span>
					<span slot="footer" class="dialog-footer">
						<el-button @click="dialogVisible = false">取 消</el-button>
						<el-button type="primary" @click="handleClose">确 定</el-button>
					</span>
				</el-dialog>



				<!-- /.box -->
			</section>


			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		[#include "/admin/common/footer.html"]

		<!-- Control Sidebar -->
		[#include "/admin/common/aside.html"]

		<!-- /.control-sidebar -->
		<!-- Add the sidebar's background. This div must be placed
 immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->
	[@baseScript /]
	<script src="<#noparse>${siteurl}</#noparse>plugins/vue-element/vue-context-menu.js"></script>
	<script src="<#noparse>${siteurl}</#noparse>plugins/vue-org-tree/index.js"></script>

	<script type="text/javascript">
		var config = {};

		config.methods = {};

		[@configBasicVue /]

		config.methods.goBack = function () {
			this.$router.go(-1);
		}
		config.basicMethod = function () {
			var result = {};
			result.postData = config.methods.postData;
			result.postJsonData = config.methods.postJsonData;
			result.goBack = config.methods.goBack;
			return result;
		}

		function clone(Obj) {
			var buf;
			if (Obj instanceof Array) {
				buf = [];
				var i = Obj.length;
				while (i--) {
					buf[i] = clone(Obj[i]);
				}
				return buf;
			}
			else if (Obj instanceof Object) {
				buf = {};
				for (var k in Obj) {
					buf[k] = clone(Obj[k]);
				}
				return buf;
			} else {
				return Obj;
			}
		}
		function restObject(Obj) {
			var buf;
			if (Obj instanceof Array) {
				buf = [];
				var i = Obj.length;
				while (i--) {
					buf[i] = clone(Obj[i]);
				}
				return buf;
			}
			else if (Obj instanceof Object) {
				buf = {};
				for (var k in Obj) {
					buf[k] = restObject(Obj[k]);
				}
				return buf;
			} else {
				return "";
			}
		}
	</script>



	<script type="text/javascript">

		// 3. 创建 router 实例，然后传 `routes` 配置
		// 你还可以传别的配置参数, 不过先这么简单着吧。
		var appConfig = {};
		appConfig.el = "#app";
		appConfig.methods = config.methods;
		appConfig.methods.getSearchList = function () {
			this.loading = true;
			var data = this.searchObject, that = this;
			data.fetch=1;
			data.size=500;
			data.sortMethod = "asc";
            data.sortField = "sortNum";
			$.post("<#noparse>${siteurl}</#noparse>tenantRest/${config_entity}/list.htm", data, function (result) {
				if (result.code == 0) {
					that.treeOptions.children = result.list;
					//that.treeOptions = result.list;
				}
				setTimeout(function () {
					that.loading = false;
				}, 300)
			});
		}
		appConfig.data = function () {
			return {
				searchObject: {
					no: 1,
					size: 10,
					name: '',
					fetch: 1,
					level: 1
				},
				dialogVisible: false,
				editDialog: false,
				defaultProps: {
					children: 'children',
					label: 'name'
				},
				loading: false,
				tableData: {},
				treeOptions: {
					id: -1,
					name: '${model!}结构',
					children: []
				},
				props: { label: 'name', children: 'children', expand: 'expand' },
				horizontal: true,
				collapsable: false,
				expandAll: false,
				labelClassName: 'bg-white',
				contextMenuVisible: false,
				contextMenuTarget: document.body,
				showDialog: false,
				form: {
					name: "",
					parent: "",
					sortNum: "",
					<#list bean.fields as item>
                    ${item.id!}: ''<#sep>,
                    </#list>
				}
				, activeName: "third"
			}
		};
		appConfig.mounted = function () {
			this.getSearchList();
		}

		appConfig.methods.renderContent = function (h, data) {
			return data.name;
		};


		appConfig.methods.onExpand = function (e, data) {
			if ('expand' in data) {
				data.expand = !data.expand
				if (!data.expand && data.children) {
					this.collapse(data.children)
				}
			} else {
				this.$set(data, 'expand', true)
			}
		};
		appConfig.methods.onNodeClick = function (e, data) {
			$(".bg-white").removeClass('bg-white-curren');
			$(e.target).addClass('bg-white-curren');
			this.parentId = data.id;
			this.departmentName = data.name;
		};
		appConfig.methods.collapse = function (list) {
			var _this = this
			list.forEach(function (child) {
				if (child.expand) {
					child.expand = false
				}
				child.children && _this.collapse(child.children)
			})
		};
		appConfig.methods.expandChange = function () {
			this.toggleExpand(this.departments, true)
		};

		appConfig.methods.showClick = function (event) {
			this.contextMenuVisible = false;
			console.log('deleteDatabaseOrTable', event);
		};

		appConfig.methods.handleNodeClick = function (data) {
		}
		appConfig.methods.append = function (data) {
			this.showDialog = true;
			this.form=restObject(this.form);
			this.form.parent = data.id;
			this.form.parentName=data.name;
			this.selectData = data;
		}

		appConfig.methods.remove = function (node, data) {
			console.log(event)
			this.selectId = data.id;
			this.dialogVisible = true;
			var parent = node.parent;
			this.selectData = parent.data.children || parent.data;
		}
		appConfig.methods.deleteData = function (data) {
			console.log(event)
			this.selectId = data.id;
			this.dialogVisible = true;
		}
		appConfig.methods.editData = function (data) {
			console.log(event)
			this.form = clone(data);
			this.form.children="";
			this.editDialog = true;
		}
		appConfig.methods.editTreeItem = function (data) {
			var self = this, data = this.form;
			//delete data.linkCatalog;
			if (this.deforeUpdateData) {
				this.deforeUpdateData();
			}
			this.postData("<#noparse>${siteurl}</#noparse>tenantRest/${config_entity}/update.htm", data, function (res) {
				if (res.code == 0) {
					self.$message({
						message: '修改数据成功',
						type: 'success'
					});
					//window.history.go(-1)
					self.editDialog = false;
					self.getSearchList();
				} else {
					self.$message.error(res.msg);
				}
			});
		}

		appConfig.methods.addTreeItem = function (data) {
			this.addData();
		}
		appConfig.methods.addData = function () {
			var self = this, data = this.form;
			if (this.deforeAddData) {
				this.deforeAddData();
			}
			if (this.parentId) {
				data.parent = this.parentId;
			}
			this.postData("<#noparse>${siteurl}</#noparse>tenantRest/${config_entity}/create.htm", data, function (res) {
				self.showDialog = false;
				if (res.code == 0) {
					self.$message({
						message: '添加数据成功',
						type: 'success'
					});
					self.getSearchList();
				} else {
					self.$message.error(res.msg);
				}
			});
		}
		appConfig.methods.handleClose = function (done) {
			this.dialogVisible = false;
			var self = this;
			if (self.selectId) {
				var params = {};
				params.id = self.selectId;
				this.postData("<#noparse>${siteurl}</#noparse>tenantRest/${config_entity}/delete.htm", params, function (res) {

					if (res.code == 0) {
						self.$message({
							message: '删除数据成功',
							type: 'success'
						});
						self.getSearchList();
						return;
						if (self.selectData) {
							const index = self.selectData.findIndex(d => d.id === self.selectId);
							self.selectData.splice(index, 1);
						} else {

						}
					} else {
						self.$message.error(res.msg);
					}
				});
			}

		}
		var vm = new Vue(appConfig);

	</script>

</body>

</html>