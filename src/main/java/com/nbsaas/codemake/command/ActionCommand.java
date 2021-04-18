package com.nbsaas.codemake.command;

import freemarker.template.Configuration;
import org.apache.commons.chain.Context;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ActionCommand extends CodeBaseCommand {

    private Logger logger = LoggerFactory.getLogger(getClass());

    public boolean execute(Context context) throws Exception {
        boolean isAction = (Boolean) context.get("isAction");
        if (!isAction) {
            return false;
        }
        logger.info("Action接口和实现生成");
        Configuration config = getConfiguration(context);
        Boolean adminAction=(Boolean) context.get("adminAction");
        if (adminAction==null){
            adminAction=true;
        }
        if (adminAction){
            Boolean catalog = (Boolean) context.get("catalog");
            if (catalog) {
                handleCode(context, config, "catalog_action", ".controller.admin", "Action");
            } else {
                handleCode(context, config, "action", ".controller.admin", "Action");
            }
        }

        return false;
    }

}
