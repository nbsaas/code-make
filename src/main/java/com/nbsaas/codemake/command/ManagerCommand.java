package com.nbsaas.codemake.command;

import freemarker.template.Configuration;
import org.apache.commons.chain.Context;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ManagerCommand extends CodeBaseCommand {


    private Logger logger = LoggerFactory.getLogger(getClass());

    public boolean execute(Context context) throws Exception {
        boolean isService = (Boolean) context.get("isService");
        if (!isService) {
            return false;
        }
        logger.info("service接口和实现生成");
        Configuration config = getConfiguration(context);
        handleCode(context, config, "manager", ".data.service", "Service");
        handleCode(context, config, "manager_impl", ".data.service.impl", "ServiceImpl");
        return false;
    }

}
