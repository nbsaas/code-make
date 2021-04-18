<#include "componentFieldItem.ftl"/>
[#macro ${config_entity}UpdateView]
    <div class="model-form">
        <el-page-header @back="goBack" content="更新${model!}">
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
                        <el-button type="primary" @click="updateData">确定</el-button>
                    </el-col>
			     </el-row>
            </el-form>
        </div>
    </div>
[/#macro]

[#macro ${config_entity}UpdateConfig]
<script type="text/x-template" id="my-${config_entity}-update">
    [@${config_entity}UpdateView /]
</script>
<script type="text/javascript">
    //更新组件开始
    var ${config_entity}UpdateConfig = {};
    ${config_entity}UpdateConfig.template = "#my-${config_entity}-update";
    ${config_entity}UpdateConfig.methods = config.basicMethod();
    ${config_entity}UpdateConfig.methods.updateData = function () {
        var self = this;
        this.$refs["ruleForm"].validate(function(valid){
            if (valid) {
                self.updateDataPost();
            } else {
                console.log('error submit!!');
                return false;
            }
        });
    }

    ${config_entity}UpdateConfig.methods.updateDataPost = function () {
        var self = this, data = this.form;
        //delete data.${config_entity}Catalog;
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
                self.$router.go(-1);
            } else {
                self.$message.error(res.msg);
            }
        });
    }
    ${config_entity}UpdateConfig.data = function () {
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

    ${config_entity}UpdateConfig.mounted = function () {
        var id = this.$route.query.id;
        var self = this;
        var data = {};
        data.id = id;
        this.postData("<#noparse>${siteurl}</#noparse>tenantRest/${config_entity}/view.htm", data, function (res) {
            if (res.code == 0) {
                self.form = res;
            }
        });
    }
    ${config_entity}UpdateConfig.computed = {};
    <#list bean.fields as item>
          <#if item.option?length gt 2 >
              ${config_entity}UpdateConfig.computed.${item.id}Options = function () {
                    return this.$store.state.${item.id}Options;
                };
          </#if>
    </#list>

    var ${config_entity}UpdateView = Vue.component('update-view', ${config_entity}UpdateConfig);
    //更新组件结束
</script>
[/#macro]