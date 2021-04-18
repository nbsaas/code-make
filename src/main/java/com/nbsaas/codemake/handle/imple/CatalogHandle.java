package com.nbsaas.codemake.handle.imple;

import com.nbsaas.codemake.annotation.CatalogClass;
import com.nbsaas.codemake.handle.BeanHandle;
import org.apache.commons.chain.Context;

public class CatalogHandle implements BeanHandle {
    @Override
    public void handle(Class<?> object, Context context) {
        CatalogClass catalogClass = object.getAnnotation(CatalogClass.class);
        if (catalogClass == null) {
            context.put("catalog", false);
        } else {
            context.put("catalog", true);
        }
    }
}
