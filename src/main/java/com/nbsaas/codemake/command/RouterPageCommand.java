package com.nbsaas.codemake.command;

import com.nbsaas.codemake.templates.elementuiForm.ElementUIFormDir;
import freemarker.cache.ClassTemplateLoader;
import freemarker.template.Configuration;
import org.apache.commons.chain.Context;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileWriter;

public class RouterPageCommand extends CodeBaseCommand {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Override
    public boolean execute(Context context) throws Exception {
        boolean isView = (Boolean) context.get("isView");
        if (!isView) {
            return false;
        }
        logger.info("Page接口和实现生成");

        Class<?> classDir = (Class<?>) context.get("dir");
        ClassTemplateLoader ctl = new ClassTemplateLoader(classDir, "/" + classDir.getName().replace(classDir.getSimpleName(), "").replace(".", "/"));
        Configuration config = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
        config.setTemplateLoader(ctl);

        File view = (File) context.get("view");
        if (!view.exists()) {
            view.mkdirs();
        }
        Class<?> entity = (Class<?>) context.get("entity");
        File dir = new File(view, entity.getSimpleName().toLowerCase());
        if (!dir.exists()) {
            dir.mkdirs();
        }

        if (classDir.equals(ElementUIFormDir.class)) {
            if (getBoolean (context,"componentAdd",true)){
                handle(dir, config, context, "componentAdd.ftl", "componentAdd.html");
            }
            if (getBoolean (context,"componentList",true)){
                handle(dir, config, context, "componentList.ftl", "componentList.html");
            }
            if (getBoolean (context,"componentShow",true)){
                handle(dir, config, context, "componentShow.ftl", "componentShow.html");
            }
            if (getBoolean (context,"componentUpdate",true)){
                handle(dir, config, context, "componentUpdate.ftl", "componentUpdate.html");
            }
            Boolean catalog = (Boolean) context.get("catalog");
            if (catalog) {
                handle(dir, config, context, "page_catalog_list.ftl", "list.html");
            } else {
                if (getBoolean (context,"pageList",true)){
                    handle(dir, config, context, "page_list.ftl", "list.html");
                }
            }
        } else {
            Boolean catalog = (Boolean) context.get("catalog");
            if (catalog) {
                handle(dir, config, context, "page_catalog_list.ftl", "list.html");
            } else {
                handle(dir, config, context, "page_list.ftl", "list.html");
            }
        }


        return false;
    }

    private void handle(File dir, Configuration config, Context context, String template, String out) {
        try {
            FileWriter component = new FileWriter(new File(dir, out));
            config.getTemplate(template).process(context, component);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
