# codemake

#### 介绍
一个简单可扩展的代码生成工具
#### 软件架构
软件架构说明


#### 注解说明


#### 使用说明

```
  CodeMake make = new CodeMake(ElementUIFormDir.class, TemplateHibernateSimpleDir.class);
  File view = new File("生成代码保存的文件夹");
  make.setView(view);
  make.setDao(true);//是否生成Dao代码
  make.setService(false);//是否生成Service代码
  make.setView(true);//是否生成视图代码
  make.setAction(true);//是否生成控制器代码
  make.setRest(true);//是否生成Rest代码
  make.setApi(true);//是否生成Api相关模块
  make.setSo(false);
```


#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request
