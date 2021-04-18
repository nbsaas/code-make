package com.nbsaas.codemake.command;

import freemarker.template.Configuration;
import org.apache.commons.chain.Context;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RestCommand extends CodeBaseCommand{

	private Logger logger = LoggerFactory.getLogger(getClass());

	public boolean execute(Context context) throws Exception {
		boolean isRest=(Boolean) context.get("isRest");
		Configuration config = getConfiguration(context);

		Boolean restDomain=(Boolean) context.get("restDomain");
		if (restDomain==null){
			restDomain=true;
		}
		Boolean tenantRestController=(Boolean) context.get("tenantRestController");
		if (tenantRestController==null){
			tenantRestController=true;
		}
		Boolean restController=(Boolean) context.get("restController");
		if (restController==null){
			restController=true;
		}
		Boolean restResource=getBoolean (context,"restResource",true);
		Boolean restPage=getBoolean (context,"restPage",true);

		if (restDomain){
			handleCode(context, config,"rest_simple",".api.domain.simple","Simple");
			handleCode(context, config,"rest_response",".api.domain.response","Response");
			handleCode(context, config,"rest_request_data",".api.domain.request","DataRequest");
			//handle(context, config,"rest_request_update",".api.domain.request","UpdateRequest");
			handleCode(context, config,"rest_request_search",".api.domain.request","SearchRequest");
			//handle(context, config,"rest_request_view",".api.domain.request","ViewRequest");
			//handle(context, config,"rest_request_list",".api.domain.request","ListRequest");
			handleCode(context, config,"rest_conver_simple",".rest.convert","SimpleConvert");
			handleCode(context, config,"rest_conver_response",".rest.convert","ResponseConvert");
		}

		if (!isRest) {
			return false;
		}
		logger.info("Rest接口和实现生成");
		handleCode(context, config,"rest_list",".api.domain.list","List");
		if (restPage){
			handleCode(context, config,"rest_page",".api.domain.page","Page");
		}
		handleCode(context, config,"rest_api",".api.apis","Api");
		if (restResource){
			handleCode(context, config,"rest_resource",".rest.resource","Resource");
		}
		if (tenantRestController){
			handleCode(context, config,"rest_controller_tenant",".controller.tenant","TenantRestController");
		}
		if (restController){
			handleCode(context, config,"rest_controller",".controller.rest","RestController");
		}

		return false;
	}
}
