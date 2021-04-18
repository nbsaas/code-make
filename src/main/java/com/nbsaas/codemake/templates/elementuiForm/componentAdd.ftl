
<!-- 增加页面开始 -->
<#include "componentFieldItem.ftl"/>

[#macro ${config_entity}AddView]
    <div  class="model-form">
        <el-page-header @back="goBack" content="增加${model!}">
        </el-page-header>
        <div class="model-content">
            <el-form ref="ruleForm" :rules="rules" :model="form" label-width="160px" >
                <el-row :gutter="10">
                    <#list bean.fields as item>
                       <@fieldItem item />
                    </#list>
                </el-row>
               <el-row>
                    <el-col :span="24"  style="text-align: right;padding-bottom: 20px;padding-top: 20px;">
                        <el-button @click="goBack">取消</el-button>
                        <el-button type="primary" @click="add">确定</el-button>
                    </el-col>
			    </el-row>
            </el-form>
        </div>
    </div>
[/#macro]

[#macro ${config_entity}AddConfig]
<script type="text/x-template" id="my-${config_entity}-add">
	[@${config_entity}AddView /]
</script>
<script type="text/javascript">
        <#list bean.fields as item>
            <#if item.type='richText'>
            var ue${item.id} ;
            </#if>
        </#list>
		//添加组件开始
		var ${config_entity}AddConfig = {};
		${config_entity}AddConfig.template = "#my-${config_entity}-add";
		${config_entity}AddConfig.methods = config.basicMethod();
		${config_entity}AddConfig.data = function () {
			return {
				form: {
					<#list bean.fields as item>
					${item.id!}: ''<#sep>,
					</#list>
				},
				rules: {
					   <#list bean.fields as item>
                        <#if item.required>
                        ${item.id}: [
							{ required: true, message: '请输入${item.title!}', trigger: 'blur' }
						]<#sep>,
                        </#if>
                        </#list>
				}
			}
		};
		${config_entity}AddConfig.mounted = function () {
            <#list bean.fields as item>
                <#if item.type='richText'>
                 ue${item.id} = initEditor("ue${item.id}");;
                </#if>
            </#list>            
		}
		${config_entity}AddConfig.computed = {};
		<#list bean.fields as item>
              <#if item.option?length gt 2 >
				  ${config_entity}AddConfig.computed.${item.id}Options = function () {
						return this.$store.state.${item.id}Options;
					};
              </#if>
        </#list>


		${config_entity}AddConfig.methods.add = function () {
			var self = this;
			this.$refs["ruleForm"].validate(function(valid){
				if (valid) {
					self.addData();
				} else {
					console.log('error submit!!');
					return false;
				}
			});
		}

		${config_entity}AddConfig.methods.addData = function () {
			var self = this, data = this.form;
			if (this.deforeAddData) {
				this.deforeAddData();
			}
             <#list bean.fields as item>
                <#if item.type='richText'>
                    if (ue${item.id}) {
                        data.${item.id} = ue${item.id}.getContent();
                    }
                </#if>
            </#list>               
			this.postData("<#noparse>${siteurl}</#noparse>tenantRest/${config_entity}/create.htm", data, function (res) {
				if (res.code == 0) {
					self.$message({
						message: '添加数据成功',
						type: 'success'
					});
					self.$router.go(-1);
				} else {
					self.$message.error(res.msg);
				}
			});
		}

        ${config_entity}AddConfig.destroyed = function () {
            console.log("destroyed add view ");
            
             <#list bean.fields as item>
                <#if item.type='richText'>
                  UE.getEditor('ue${item.id}').destroy();
                </#if>
            </#list>               
	    }
		var  ${config_entity}AddView = Vue.component('add-view', ${config_entity}AddConfig);


</script>
[/#macro]

<!-- 增加页面结束 -->